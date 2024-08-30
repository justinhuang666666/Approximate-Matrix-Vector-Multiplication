import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys

import warnings

# Suppress all warnings
warnings.filterwarnings("ignore")

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'iterative_approximation'))
from iterative_approximation_gpu import *

# Load the tokenizer and model
model_name = "Helsinki-NLP/opus-mt-en-de"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()

# Check if GPU is available and move model to GPU if possible
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)
model.to(device)

# Load the JSON file
with open('translations.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Extract the source and target texts
source_texts = data['source_texts']
target_texts = data['target_texts']

original_atten_block_weight_array_encoder_0 = extract_weight_array(model.model.encoder.layers[0])
original_atten_block_weight_array_encoder_1 = extract_weight_array(model.model.encoder.layers[1])
original_atten_block_weight_array_encoder_2 = extract_weight_array(model.model.encoder.layers[2])
original_atten_block_weight_array_encoder_3 = extract_weight_array(model.model.encoder.layers[3])
original_atten_block_weight_array_encoder_4 = extract_weight_array(model.model.encoder.layers[4])
original_atten_block_weight_array_encoder_5 = extract_weight_array(model.model.encoder.layers[5])


def eval(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
    """
    Evaluate the performance of a model with tiled layers of approximated submatrices.

    Args:
        tiled_layers (list): List of tiled layer objects containing approximated submatrices.
        tile_size (int): Size of the tile used in the approximation.
        model: The model object containing the encoder with layers to set weights.
        tokenizer: The tokenizer used for encoding the source and target texts.
        source_texts (list): List of source texts for BLEU and F-score evaluation.
        target_texts (list): List of target texts for BLEU and F-score evaluation.
        device (str): Device to use for evaluation ('cuda' or 'cpu').

    Returns:
        pd.DataFrame: DataFrame containing the evaluation metrics.
    """
    mse_array = []
    compression_ratio_array = []
    memory_footprint = 0

    # Loop to merge approximated submatrices back into full matrices
    for i in range(len(tiled_layers)):
        approximated_matrix_array = []
        for j in range(len(tiled_layers[i])):  # Ensure correct sublist length
            # Access the current reconstructed submatrices
            approximated_submatrix_array = tiled_layers[i][j].current_reconstructed_weight_array

            # Merge submatrices back into the original sized matrix
            approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

            # Append the merged matrix to the array
            approximated_matrix_array.append(approximated_matrix)

            # Collect MSE and update memory footprint
            mse_array.append(tiled_layers[i][j].average_mse_array())
            memory_footprint += tiled_layers[i][j].memory_footprint_compressed
            compression_ratio_array.append(tiled_layers[i][j].memory_footprint_compressed / tiled_layers[i][j].memory_footprint_baseline)

        # Set the approximated matrices as weights for the model layer
        set_layer_weight(model.model.encoder.layers[i], approximated_matrix_array)

    # Calculate overall metrics
    num_step = tiled_layers[-1][-1].steps
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    memory_footprint /= 8  # Convert bits to bytes
    compression_ratio = sum(compression_ratio_array) / len(compression_ratio_array) if compression_ratio_array else 0

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
    fscore = compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Steps': [num_step],
        'MSE': [mse],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }
    dataframe = pd.DataFrame(results)
    
    return dataframe

tile_sizes = [32,64.128,256,512] #0.586
steps = [19,38,76,152,304]
skips = [1,2,4,8,16]

tile_size = 32
step = 19
skip = 1

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers
tiled_layers = init_tiled_layers(encoder_layers, tile_size)

from tqdm import tqdm

results = []

with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
    for i in range(step):
        for j in range(len(tiled_layers)):
            for k in range(len(tiled_layers[i])):  # Ensure the correct length is used
                # Assuming iterative_approximation is defined within the WeightArray class
                tiled_layers[j][k].iterative_approximation(1)

        if(i%skip==0):
            result = eval(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts)
            results.append(result)

        pbar2.update(1)
