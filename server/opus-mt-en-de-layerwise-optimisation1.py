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

def init_tiled_layer_single(encoder_layer, tile_size):
    # Iterate over each layer in the encoder and initialize the tiling
    layer = encoder_layer

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

def init_tiled_layer_group(encoder_layer, tile_size):
    # Initialize a list to store tiled weight arrays for each layer
    layer = encoder_layer
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


def init_tiled_layer_stack(encoder_layer, tile_size):
    layer = encoder_layer

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

def init_tiled_layer(encoder_layer, method, tile_size):
    if method == 1:
        return init_tiled_layer_single(encoder_layer, tile_size)
    elif method == 2:
        return init_tiled_layer_group(encoder_layer, tile_size)
    elif method == 3:
        return init_tiled_layer_stack(encoder_layer, tile_size)
    else:
        return 0

def init_tiled_layers(encoder_layers, opt_methods, tile_size):
    tiled_layers = []
    for layer_id, method in enumerate(opt_methods):
        tiled_layers.append(init_tiled_layer(encoder_layers[layer_id], method, tile_size))
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

def eval_bleu(tiled_layer, layer_id, method, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
    # Create a deep copy of the model to avoid modifying the original model
    local_model = copy.deepcopy(model)

    mse_array = []

    approximated_matrix_array, memory_footprint_layer = reconstruct_tiled_layer(tiled_layer, method, tile_size)
    mse_array.append(mean_square_error_array1(extract_weight_array(local_model.model.encoder.layers[layer_id]), approximated_matrix_array))
    set_layer_weight(local_model.model.encoder.layers[layer_id], approximated_matrix_array)


    # Compute BLEU and F-score
    bleu = compute_bleu_score(device, local_model, tokenizer, source_texts, target_texts)

    return local_model,bleu,memory_footprint_layer

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers

from tqdm import tqdm



def layerwise_optimisation(model, target_compression_ratio, encoder_layers, memory_footprint_array, steps, tile_size, tokenizer, source_texts, target_texts):
    """
    Function to perform layer-wise optimization for a model to achieve a target compression ratio.

    Parameters:
    - model: The base model to be optimized.
    - target_compression_ratio: The desired compression ratio to achieve.
    - encoder_layers: List of encoder layers of the model to be optimized.
    - memory_footprint_array: List of current memory footprints for each layer.
    - steps: Number of steps allocated for optimization for each layer.
    - tile_size: Size of the tiles used for layer approximation.
    - tokenizer: Tokenizer used for evaluation.
    - source_texts: List of source texts for evaluation.
    - target_texts: List of target texts for evaluation.

    Returns:
    - next_model_bleu: BLEU score of the optimized model.
    - next_model_steps: Updated number of steps for each layer.
    - compression_ratio: The final compression ratio achieved by the optimized model.
    """

    next_model_array = []                      # To store the models for each layer optimization.
    next_model_layer_i_memory_array = []        # To store the memory footprint for each optimized layer.
    next_model_bleu_array = []                  # To store the BLEU scores for each optimized model.

    # Iterate over each layer to perform optimization
    for layer_id in range(len(encoder_layers)):
        method = 1  # Define the method for layer approximation (this can be parameterized as needed)
        
        # Initialize the tiled layer for the given layer_id
        tiled_layer = init_tiled_layer(encoder_layers[layer_id], method, tile_size)

        # Perform iterative approximation for the current layer
        for step in range(steps[layer_id] - 2):
            for k in range(len(tiled_layer)):
                tiled_layer[k].iterative_approximation(method)

        # Evaluate the optimized model for the current layer
        next_model_i, next_model_i_bleu, next_model_layer_i_memory = eval_bleu(
            tiled_layer, layer_id, method, tile_size, model, tokenizer, source_texts, target_texts
        )

        # Store the results for comparison
        next_model_array.append(next_model_i)
        next_model_layer_i_memory_array.append(next_model_layer_i_memory)
        next_model_bleu_array.append(next_model_i_bleu)

    # Find the index of the model with the best BLEU score (indicating better performance)
    best_model_idx = next_model_bleu_array.index(max(next_model_bleu_array))
    next_model = next_model_array[best_model_idx]
    
    # Update memory footprint and steps for the best performing model
    memory_footprint_array[best_model_idx] = next_model_layer_i_memory_array[best_model_idx]
    next_model_bleu = next_model_bleu_array[best_model_idx]
    steps[best_model_idx] -= 2  # Reduce the step count for the best layer
    next_model_steps = steps
    next_model_memory_footprint = sum(memory_footprint_array)  # Total memory footprint after optimization

    # Calculate the compression ratio achieved by the optimized model
    compression_ratio = 512 * 512 * 6 * 3 * 32 / next_model_memory_footprint

    print('current bleu: ',next_model_bleu)
    print('current steps: ',next_model_steps)
    print('current compression ratio: ',compression_ratio)

    return next_model, next_model_bleu, next_model_steps, compression_ratio
    
tile_size = 64
steps = [35,35,35,35,35,35]
target_compression_ratio = 1.22 
memory_footprint_array = [166440960,166440960,166440960,166440960,166440960,166440960]

model_compression_ratio = 0
model_steps = steps

while(model_compression_ratio < target_compression_ratio):
    model, model_bleu, model_steps, model_compression_ratio = layerwise_optimisation(model, target_compression_ratio, encoder_layers, memory_footprint_array, model_steps, tile_size, tokenizer, source_texts, target_texts)

import pandas as pd

# Create an empty DataFrame to store results
results_df = pd.DataFrame(columns=['BLEU Score', 'Steps', 'Compression Ratio'])

# Append current results to DataFrame
results_df = results_df.append({
    'BLEU Score': model_bleu,
    'Steps': model_steps,
    'Compression Ratio': model_compression_ratio
}, ignore_index=True)

# Save the DataFrame to a CSV file
results_df.to_csv('layerwise_optimisation_results.csv', index=False)

print('----------------Final----------------')
print('bleu: ',model_bleu)
print('steps: ',model_steps)
print('compression ratio: ',model_compression_ratio)