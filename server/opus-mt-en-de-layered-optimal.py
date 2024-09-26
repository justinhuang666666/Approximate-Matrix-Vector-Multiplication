import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys

import pandas as pd
import warnings
import copy

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

def init_tiled_layer_single(encoder_layers, layer_id, tile_size):
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

def init_tiled_layer_group(encoder_layers, layer_id, tile_size):
    # Initialize a list to store tiled weight arrays for each layer
    layer = encoder_layers[layer_id]
    # Extract weight arrays for k, q, and v
    weight_array = extract_weight_array(layer)
    k = divide_matrix(weight_array[0], tile_size)
    q = divide_matrix(weight_array[1], tile_size)
    v = divide_matrix(weight_array[2], tile_size)

    tiled_layer = []

    for i in range(len(k)):
        arr = [k[i],q[i],v[i]]
        array = WeightArray(arr, 'array', 0.001, 1, 1, tile_size, tile_size)
        tiled_layer.append(array)

    return tiled_layer


def init_tiled_layer_stack(encoder_layers, layer_id, tile_size):
    layer = encoder_layers[layer_id]

    # Extract weight arrays for k, q, and v
    weight_array = extract_weight_array(layer)
    k = divide_matrix(weight_array[0], tile_size)
    q = divide_matrix(weight_array[1], tile_size)
    v = divide_matrix(weight_array[2], tile_size)

    tiled_layer = []

    for i in range(len(k)):
        arr = [k[i],q[i],v[i]]
        array = WeightArray(arr, 'weight', 0.001, 1, 1, tile_size, tile_size)
        tiled_layer.append(array)

    return tiled_layer

def init_tiled_layer(encoder_layers, layer_id, method, tile_size):
    if method == 1:
        return init_tiled_layer_single(encoder_layers, layer_id, tile_size)
    elif method == 2:
        return init_tiled_layer_group(encoder_layers, layer_id, tile_size)
    elif method == 3:
        return init_tiled_layer_stack(encoder_layers, layer_id, tile_size)
    else:
        return 0

def init_tiled_layers(encoder_layers, opt_methods, tile_size):
    tiled_layers = []
    for layer_id, method in enumerate(opt_methods):
        tiled_layers.append(init_tiled_layer(encoder_layers, layer_id, method, tile_size))
    return tiled_layers


def reconstruct_tiled_layer_single(tiled_layer, tile_size):
    approximated_matrix_array = []

    for j in range(len(tiled_layer)):  # Ensure correct sublist length
        approximated_submatrix_array = tiled_layer[j].current_reconstructed_weight_array
        # Merge submatrices back into the original sized matrix
        approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

        # Append the merged matrix to the array
        approximated_matrix_array.append(approximated_matrix)
        
        memory_footprint += tiled_layer[j].memory_footprint_compressed

    return approximated_matrix_array

def reconstruct_tiled_layer_single(tiled_layer, tile_size):
    approximated_matrix_array = []
    memory_footprint = 0
    for j in range(len(tiled_layer)):  # Ensure correct sublist length
        approximated_submatrix_array = tiled_layer[j].current_reconstructed_weight_array
        # Merge submatrices back into the original sized matrix
        approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

        # Append the merged matrix to the array
        approximated_matrix_array.append(approximated_matrix)
        memory_footprint += tiled_layer[j].memory_footprint_compressed
        
    return approximated_matrix_array, memory_footprint

def reconstruct_tiled_layer_group(tiled_layer, tile_size):
    k_tiles = [array.current_reconstructed_weight_array[0] for array in tiled_layer]
    q_tiles = [array.current_reconstructed_weight_array[1] for array in tiled_layer]
    v_tiles = [array.current_reconstructed_weight_array[2] for array in tiled_layer]

    memory_footprint = 0
    for array in tiled_layer:
        memory_footprint += array.memory_footprint_compressed

    # Merge the tiles back into the original matrices
    k = merge_matrices(k_tiles, tile_size)
    q = merge_matrices(q_tiles, tile_size)
    v = merge_matrices(v_tiles, tile_size)

    # Combine the k, q, v matrices into the original weight array format
    approximated_matrix_array = [k, q, v]

    return approximated_matrix_array, memory_footprint

def reconstruct_tiled_layer_stack(tiled_layer, tile_size):
    k_tiles = [array.reconstructed_weight()[0] for array in tiled_layer]
    q_tiles = [array.reconstructed_weight()[1] for array in tiled_layer]
    v_tiles = [array.reconstructed_weight()[2] for array in tiled_layer]

    memory_footprint = 0
    for array in tiled_layer:
        memory_footprint += array.memory_footprint_compressed

    # Merge the tiles back into the original matrices
    k = merge_matrices(k_tiles, tile_size)
    q = merge_matrices(q_tiles, tile_size)
    v = merge_matrices(v_tiles, tile_size)

    # Combine the k, q, v matrices into the original weight array format
    approximated_matrix_array = [k, q, v]

    return approximated_matrix_array, memory_footprint

def reconstruct_tiled_layer(tiled_layer, method, tile_size):
    if method == 1:
        return reconstruct_tiled_layer_single(tiled_layer, tile_size)
    elif method == 2:
        return reconstruct_tiled_layer_group(tiled_layer, tile_size)
    elif method == 3:
        return reconstruct_tiled_layer_stack(tiled_layer, tile_size)
    else:
        return 0

def eval(tiled_layers, opt_methods, tile_size, step, model, tokenizer, source_texts, target_texts, device='cuda'):
    # Create a deep copy of the model to avoid modifying the original model
    local_model = copy.deepcopy(model)

    mse_array = []
    memory_footprint = 0
    for layer_id, (method, tiled_layer) in enumerate(zip(opt_methods, tiled_layers)):
        approximated_matrix_array, memory_footprint_layer = reconstruct_tiled_layer(tiled_layer, method, tile_size)
        mse_array.append(mean_square_error_array1(extract_weight_array(local_model.model.encoder.layers[layer_id]), approximated_matrix_array))
        set_layer_weight(local_model.model.encoder.layers[layer_id], approximated_matrix_array)
        memory_footprint += memory_footprint_layer

    # Calculate overall metrics
    num_step = step
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    compression_ratio = 32*512*512*3*6/memory_footprint
    memory_footprint /= 8  # Convert bits to bytes
    

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, local_model, tokenizer, source_texts, target_texts)
    fscore = 0 # compute_character_fscore(device, local_model, tokenizer, source_texts, target_texts)

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

tile_size = 64

opt_methods1 = [1,1,1,1,1,1]
opt_methods2 = [2,2,2,2,2,2]
opt_methods3 = [3,3,3,3,3,3]
opt_methods4 = [1,1,2,1,1,2]


opt_methods = opt_methods1
step = 40
skip = 2

metrics_results = []

tiled_layers = init_tiled_layers(encoder_layers, opt_methods, tile_size)
with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
    for i in range(step):
        with tqdm(total=len(opt_methods), desc='Processing', unit='iteration') as pbar3:
            for j, method in enumerate(opt_methods):
                for k in range(len(tiled_layers[j])): 
                    tiled_layers[j][k].iterative_approximation(method)
                pbar3.update(1)
            if ((i+1)%skip) == 0:
                metrics_dataframe = eval(tiled_layers, opt_methods, tile_size, i, model, tokenizer, source_texts, target_texts)
                metrics_results.append(metrics_dataframe)
        pbar2.update(1)

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('layered_optimal_single_results.csv', index=False)

print("metrics_results saved to 'layered_optimal_single_results.csv'")


opt_methods = opt_methods2
step = 120
skip = 6

metrics_results = []

tiled_layers = init_tiled_layers(encoder_layers, opt_methods, tile_size)
with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
    for i in range(step):
        with tqdm(total=len(opt_methods), desc='Processing', unit='iteration') as pbar3:
            for j, method in enumerate(opt_methods):
                for k in range(len(tiled_layers[j])): 
                    tiled_layers[j][k].iterative_approximation(method)
                pbar3.update(1)
            if ((i+1)%skip) == 0:
                metrics_dataframe = eval(tiled_layers, opt_methods, tile_size, i, model, tokenizer, source_texts, target_texts)
                metrics_results.append(metrics_dataframe)
        pbar2.update(1)

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('layered_optimal_group_results.csv', index=False)

print("metrics_results saved to 'layered_optimal_group_results.csv'")


opt_methods = opt_methods3
step = 60
skip = 3

metrics_results = []

tiled_layers = init_tiled_layers(encoder_layers, opt_methods, tile_size)
with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
    for i in range(step):
        with tqdm(total=len(opt_methods), desc='Processing', unit='iteration') as pbar3:
            for j, method in enumerate(opt_methods):
                for k in range(len(tiled_layers[j])): 
                    tiled_layers[j][k].iterative_approximation(method)
                pbar3.update(1)
            if ((i+1)%skip) == 0:
                metrics_dataframe = eval(tiled_layers, opt_methods, tile_size, i, model, tokenizer, source_texts, target_texts)
                metrics_results.append(metrics_dataframe)
        pbar2.update(1)

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('layered_optimal_stack_results.csv', index=False)

print("metrics_results saved to 'layered_optimal_stack_results.csv'")


opt_methods = opt_methods4
step = 40
skip = 2

metrics_results = []

tiled_layers = init_tiled_layers(encoder_layers, opt_methods, tile_size)
with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
    for i in range(step):
        with tqdm(total=len(opt_methods), desc='Processing', unit='iteration') as pbar3:
            for j, method in enumerate(opt_methods):
                if method == 1:
                    for k in range(len(tiled_layers[j])): 
                        tiled_layers[j][k].iterative_approximation(method)
                    pbar3.update(1)
                elif method == 2:
                    for k in range(len(tiled_layers[j])): 
                        tiled_layers[j][k].iterative_approximation(method)
                        tiled_layers[j][k].iterative_approximation(method)
                    pbar3.update(1)
                elif method == 3:
                    for k in range(len(tiled_layers[j])): 
                        tiled_layers[j][k].iterative_approximation(method)
                        tiled_layers[j][k].iterative_approximation(method)
                    pbar3.update(1)
            if ((i+1)%skip) == 0:
                metrics_dataframe = eval(tiled_layers, opt_methods, tile_size, i, model, tokenizer, source_texts, target_texts)
                metrics_results.append(metrics_dataframe)
        pbar2.update(1)

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('layered_optimal_results.csv', index=False)

print("metrics_results saved to 'layered_optimal_results.csv'")
        