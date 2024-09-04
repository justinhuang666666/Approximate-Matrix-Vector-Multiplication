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

def init_tiled_layers(encoder_layers, tile_size):
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
    for layer in encoder_layers:
        # Extract weight arrays for k, q, and v
        weight_array = extract_weight_array(layer)
        k = divide_matrix(weight_array[0], tile_size)
        q = divide_matrix(weight_array[1], tile_size)
        v = divide_matrix(weight_array[2], tile_size)

        layer_array = []

        for i in range(len(k)):
            arr = [k[i],q[i],v[i]]
            array = WeightArray(arr, 'weight', 0.001, 1, 1, tile_size, tile_size)
            layer_array.append(array)

        # Append the initialized weight arrays to the tiled_layers list
        tiled_layers.append(layer_array)

    return tiled_layers

def reverse_tiling(model, tiled_layers, tile_size):
    """
    Reverse the tiling process by merging the matrices back into the original weight arrays.

    Args:
        tiled_layers (list): List of tiled weight arrays for each encoder layer.
        tile_size (int): Size of the tiles used in the original tiling.

    Returns:
        original_layers (list): List of original weight arrays for each encoder layer.
    """
    original_layers = []
    mse_array = []

    # Iterate over each layer's tiled weights
    for i, layer_array in enumerate(tiled_layers):
        print(len(layer_array))
        k_tiles = []
        q_tiles = []
        v_tiles = []
        for array in layer_array:
            print(array)
            stacked = array.reconstructed_weight()
            print(len(stacked))
            k_tiles.append(stacked[0])
            q_tiles.append(stacked[1])
            v_tiles.append(stacked[2])

        # Merge the tiles back into the original matrices
        k = merge_matrices(k_tiles, tile_size)
        q = merge_matrices(q_tiles, tile_size)
        v = merge_matrices(v_tiles, tile_size)

        # Combine the k, q, v matrices into the original weight array format
        weight_array = [k, q, v]

        # Append the merged weight array to the original layers list
        mse_array.append(mean_square_error_array1(extract_weight_array(model.model.encoder.layers[i]),weight_array))
        set_layer_weight(model.model.encoder.layers[i],weight_array)

    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    return model,mse

def eval3(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
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
    memory_footprint = 0

    # Loop to merge approximated submatrices back into full matrices
    for i in range(len(tiled_layers)):
        for j in range(len(tiled_layers[i])):  # Ensure correct sublist length
            # Collect MSE and update memory footprint
            mse_array.append(tiled_layers[i][j].average_mse())
            memory_footprint += tiled_layers[i][j].memory_footprint_compressed

    model,mse_check = reverse_tiling(model, tiled_layers, tile_size)

    # Calculate overall metrics
    tile_size = tiled_layers[i][j].R
    num_step = tiled_layers[i][j].steps
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    memory_footprint /= 8  # Convert bits to bytes
    compression_ratio = tiled_layers[i][j].compression_ratio()

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
    fscore = compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Tile Size': [tile_size],
        'Steps': [num_step],
        'MSE': [mse],
        'MSE Check': [mse_check],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }

    dataframe = pd.DataFrame(results)
    
    return dataframe

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers
# tile_size = 32
# step = 50
# tiled_layers = init_tiled_layers(encoder_layers, tile_size)

steps = [100,200] #[50,100,200,400,800]
tile_sizes = [32,64] #[32,64,128,256,512]
skips = [100,200] #[1,2,4,8,16]

results = []

from tqdm import tqdm

with tqdm(total=len(steps), desc='Processing', unit='iteration') as pbar1:
    for tile_size, step, skip in zip(tile_sizes, steps, skips):
        tiled_layers = init_tiled_layers(encoder_layers, tile_size)
        with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
            for i in range(step):
                for j in range(len(tiled_layers)):
                    for k in range(len(tiled_layers[j])):  # Ensure the correct length is used
                        # Assuming iterative_approximation is defined within the WeightArray class
                        tiled_layers[j][k].iterative_approximation(3)

                if(i%skip==0):
                    result = eval3(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts)
                    results.append(result)

                pbar2.update(1)
        pbar1.update(1)
    

df = pd.concat(results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('stack.csv', index=False)

print("Results saved to 'stack.csv'")
