import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys

import pandas as pd
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

tile_sizes = [32,64,128,256,512]
steps = [19,38,76,152,304]
skips = [1,2,4,8,16]

def init_tiled_layer(encoder_layers, layer_id, tile_size):
    """
    Generate tiled weight arrays for each encoder layer.

    Args:
        encoder_layers (List): List of encoder layers.
        tile_size (int): The size of the tiles for each weight matrix.

    Returns:
        List[List[WeightArray]]: A list containing tiled weight arrays for each encoder layer.
    """
    # Initialize a list to store tiled weight arrays for each layer
    tiled_layers = []

    # Iterate over each layer in the encoder and initialize the tiling
    layer = encoder_layers[layer_id]

    # Extract weight arrays for k, q, and v
    weight_array = extract_weight_array(layer)
    k = divide_matrix(weight_array[0], tile_size)
    q = divide_matrix(weight_array[1], tile_size)
    v = divide_matrix(weight_array[2], tile_size)

    # Create WeightArray objects for each tiled matrix
    kk = WeightArray(k, 'array', 0.001, 1, 1, tile_size, tile_size)
    qq = WeightArray(q, 'array', 0.001, 1, 1, tile_size, tile_size)
    vv = WeightArray(v, 'array', 0.001, 1, 1, tile_size, tile_size)

    tiled_layer = [kk,qq,vv]

    return tiled_layer

def eval(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
    """
    Evaluate the performance of a model with tiled layers of approximated submatrices.

    Args:
        tiled_layer (list): List of tiled layer objects containing approximated submatrices.
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
    memory_footprint = 0

    # Loop to merge approximated submatrices back into full matrices
    approximated_matrix_array = []

    for j in range(len(tiled_layer)):  # Ensure correct sublist length
        approximated_submatrix_array = tiled_layer[j].current_reconstructed_weight_array
        # Merge submatrices back into the original sized matrix
        approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

        # Append the merged matrix to the array
        approximated_matrix_array.append(approximated_matrix)
        
        memory_footprint += tiled_layer[j].memory_footprint_compressed
        
    mse_array.append(mean_square_error_array1(extract_weight_array(model.model.encoder.layers[layer_id]),approximated_matrix_array))

    set_layer_weight(model.model.encoder.layers[layer_id], approximated_matrix_array)

    # Calculate overall metrics
    num_step = tiled_layer[-1].steps
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    memory_footprint /= 8  # Convert bits to bytes
    compression_ratio = tiled_layer[-1].compression_ratio()

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
    fscore = compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Layer': [layer_id],
        'Tile Size': [tile_size],
        'Steps': [num_step],
        'MSE': [mse],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }

    metrics_dataframe = pd.DataFrame(results)

    return metrics_dataframe

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers

from tqdm import tqdm

metrics_results = []

layers = [0,1] # [0,1,2,3,4,5]
tile_size = 32
step = 12

with tqdm(total=len(layers), desc='Processing', unit='iteration') as pbar1:
    for layer_id in layers:
        tiled_layer = init_tiled_layer(encoder_layers, layer_id, tile_size)
        with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
            for i in range(step):
                for k in range(len(tiled_layer)):  # Ensure the correct length is used
                    # Assuming iterative_approximation is defined within the WeightArray class
                    tiled_layer[k].iterative_approximation(1)
                pbar2.update(1)

            metrics_dataframe = eval(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts)
            metrics_results.append(metrics_dataframe)
            

        pbar1.update(1)
    

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('single_layered.csv', index=False)

print("metrics_results saved to 'single_layered.csv'")
