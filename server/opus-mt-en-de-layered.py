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
    # Iterate over each layer in the encoder and initialize the tiling
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


def eval_single(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
    # Create a deep copy of the model to avoid modifying the original model
    local_model = copy.deepcopy(model)

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
        
    mse_array.append(mean_square_error_array1(extract_weight_array(local_model.model.encoder.layers[layer_id]), approximated_matrix_array))

    set_layer_weight(local_model.model.encoder.layers[layer_id], approximated_matrix_array)

    # Calculate overall metrics
    num_step = tiled_layer[-1].steps
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    memory_footprint /= 8  # Convert bits to bytes
    compression_ratio = tiled_layer[-1].compression_ratio()

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, local_model, tokenizer, source_texts, target_texts)
    fscore = 0 #compute_character_fscore(device, local_model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Method': 'Single',
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

def eval_group(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):

    local_model = copy.deepcopy(model)

    k_tiles = []
    q_tiles = []
    v_tiles = []

    memory_footprint = 0

    for array in tiled_layer:
        # Extract the k, q, v tiled matrices
        k_tiles.append(array.current_reconstructed_weight_array[0])
        q_tiles.append(array.current_reconstructed_weight_array[1])
        v_tiles.append(array.current_reconstructed_weight_array[2])

        memory_footprint += array.memory_footprint_compressed

    # Merge the tiles back into the original matrices
    k = merge_matrices(k_tiles, tile_size)
    q = merge_matrices(q_tiles, tile_size)
    v = merge_matrices(v_tiles, tile_size)

    # Combine the k, q, v matrices into the original weight array format
    weight_array = [k, q, v]

    # Append the merged weight array to the original layers list
    mse = mean_square_error_array1(extract_weight_array(local_model.model.encoder.layers[layer_id]),weight_array)
    set_layer_weight(local_model.model.encoder.layers[layer_id], weight_array)

    # Calculate overall metrics
    tile_size = tiled_layer[-1].R
    num_step = tiled_layer[-1].steps
    memory_footprint /= 8 
    compression_ratio = tiled_layer[-1].compression_ratio()

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, local_model, tokenizer, source_texts, target_texts)
    fscore = 0 #compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Method': 'Group',
        'Layer': [layer_id],
        'Tile Size': [tile_size],
        'Steps': [num_step],
        'MSE': [mse],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }

    dataframe = pd.DataFrame(results)
    
    return dataframe

def eval_stack(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):

    local_model = copy.deepcopy(model)

    k_tiles = []
    q_tiles = []
    v_tiles = []

    memory_footprint = 0

    for array in tiled_layer:
        # Extract the k, q, v tiled matrices
        k_tiles.append(array.reconstructed_weight()[0])
        q_tiles.append(array.reconstructed_weight()[1])
        v_tiles.append(array.reconstructed_weight()[2])

        memory_footprint += array.memory_footprint_compressed

    # Merge the tiles back into the original matrices
    k = merge_matrices(k_tiles, tile_size)
    q = merge_matrices(q_tiles, tile_size)
    v = merge_matrices(v_tiles, tile_size)

    # Combine the k, q, v matrices into the original weight array format
    weight_array = [k, q, v]

    # Append the merged weight array to the original layers list
    mse = mean_square_error_array1(extract_weight_array(local_model.model.encoder.layers[layer_id]),weight_array)
    set_layer_weight(local_model.model.encoder.layers[layer_id], weight_array)

    # Calculate overall metrics
    tile_size = tiled_layer[-1].R
    num_step = tiled_layer[-1].steps
    memory_footprint /= 8 
    compression_ratio = tiled_layer[-1].compression_ratio()

    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, local_model, tokenizer, source_texts, target_texts)
    fscore = 0 #compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Method': 'Stack',
        'Layer': [layer_id],
        'Tile Size': [tile_size],
        'Steps': [num_step],
        'MSE': [mse],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }

    dataframe = pd.DataFrame(results)
    
    return dataframe

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers

from tqdm import tqdm

metrics_results = []

layers = [0,1] #[0,1,2,3,4,5]
tile_size = 64
step = 10
skip = 1

with tqdm(total=len(layers), desc='Processing', unit='iteration') as pbar1:
    for layer_id in layers:
        tiled_layer = init_tiled_layer_single(encoder_layers, layer_id, tile_size)
        with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
            for i in range(step):
                for k in range(len(tiled_layer)):  # Ensure the correct length is used
                    # Assuming iterative_approximation is defined within the WeightArray class
                    tiled_layer[k].iterative_approximation(1)

                if(i%skip==0):
                    metrics_dataframe = eval_single(tiled_layer, layer_id, tile_size, model, tokenizer, source_texts, target_texts)
                    metrics_results.append(metrics_dataframe)

                pbar2.update(1)
            
        pbar1.update(1)
    

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('layered_results.csv', index=False)

print("metrics_results saved to 'layered_results.csv'")
