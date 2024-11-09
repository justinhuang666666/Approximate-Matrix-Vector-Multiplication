import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys
import pandas as pd

from torch import nn

import warnings

import argparse
import itertools
import csv

# Suppress all warnings
warnings.filterwarnings("ignore")

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
from quant import *
from quant_svd import *

# Suppress all warnings
warnings.filterwarnings("ignore")

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'iterative_approximation'))
from iterative_approximation_quant import *
sys.path.append(os.path.join(parent_dir, 'server'))
from utils import *

# Load the tokenizer and model
model_name = "Helsinki-NLP/opus-mt-en-de"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()

# Check if GPU is available and move model to GPU if possible
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)
model.to(device)

# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

# Define possible values for wl, fl, symmetric, and round_mode
word_lengths = [8, 16] #[6, 8, 16]
frac_lengths = [4, 5] #[1, 2, 3, 4, 5, 6]  # reasonable fraction lengths based on wl
rank_samples = [50,100] #[50, 100, 150, 200]

symmetric = True
round_mode = "nearest"
results_list = []


def compute_u_v_array(weight_array, rank, quant_scheme):
    u_array = []
    v_array = []
    
    for i in range(len(weight_array)):
        # Get the weight matrix
        weight = weight_array[i]
        
        # Perform SVD on the weight matrix to get U, S, V matrices
        u, s, v = torch.svd(weight)
        
        # Reduce U, S, and V matrices to specified rank
        u_reduced = u[:, :rank]
        s_reduced = torch.diag(s[:rank])
        v_reduced = v[:, :rank]
        
        # Compute the rank-r approximation
        u_approx = u_reduced @ s_reduced    # U * S
        v_approx = v_reduced.T  # Transpose V for multiplication
        
        # Quantize the matrices based on the quant_scheme if required
        # u_approx = quantisation(u_approx, quant_scheme)
        # v_approx = quantisation(v_approx, quant_scheme)
        
        # Append the approximations to the arrays
        u_array.append(u_approx)
        v_array.append(v_approx)
    
    return u_array, v_array

def compute_u_v_array_iterative(weight_array, rank, quant_scheme):
    u_array = []
    v_array = []
    
    for i in range(len(weight_array)):
        # Get the weight matrix
        weight = weight_array[i]
        
        # Initialize an empty list to store intermediate u and v for each rank-1 approximation
        u_approx_list = []
        v_approx_list = []
        
        # Iteratively decompose the matrix to get rank-1 approximations
        for _ in range(rank):
            # Perform SVD on the current weight matrix to get the first singular vector and value
            u, s, v = torch.svd(weight)
            
            # Select the first singular value/vector (rank-1 approximation)
            sigma = s[0]  # The largest singular value
            u_1 = u[:, 0].unsqueeze(1)  # Column vector for U
            v_1 = v[:, 0].unsqueeze(1)  # Column vector for V
            
            # Compute the rank-1 matrix and append to approximations
            u_approx_list.append(u_1 * sigma)
            v_approx_list.append(v_1.T)
            
            # Subtract the rank-1 approximation from the weight to get the residual
            weight = weight - sigma * (u_1 @ v_1.T)
        
        # Stack the rank-1 approximations to form the final reduced U and V
        u_approx = torch.cat(u_approx_list, dim=1)
        v_approx = torch.cat(v_approx_list, dim=0)
        
        # Optionally, quantize the matrices based on the quant_scheme
        # u_approx = quantisation(u_approx, quant_scheme)
        # v_approx = quantisation(v_approx, quant_scheme)
        
        # Append the final reduced U and V matrices to the arrays
        u_array.append(u_approx)
        v_array.append(v_approx)
    
    return u_array, v_array


rank_samples = [1,5,10,15,20]
for rank in rank_samples:
#     # Iterate over all combinations of wl, fl, symmetric, and round_mode
#     for wl in word_lengths: 
#         for fl in frac_lengths:
    wl = 8
    fl = 3
    # Skip invalid combinations where fl is greater than wl
    frac = wl - fl

    # if frac <= 0:
    #     continue

    # Define the quantization scheme dictionary with IntQuant settings
    args_int.quant_scheme = {
        "act": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "weight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "bact": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "bweight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "goact": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "goweight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
        "same_input": True,
        "same_weight": True
    }

    # Create the quantization scheme using the from_args method
    quant_scheme_int = QuantScheme.from_args(args_int)

    # Initialize lists to store MSE values for each layer
    mse1_list = []
    mse2_list = []
    delta_mse_list = []

    
    print(f"Opus-mt-en-de INT BLEU Score for wl={wl}, fl={frac}, rank={rank}")
    # Loop over the 6 encoder layers in the model
    # for layer_idx in range(1):

    layer_idx = 0
    # Access the weights for k_proj, q_proj, and v_proj in the self-attention of each layer
    weight_array = [
        model.model.encoder.layers[layer_idx].self_attn.k_proj.weight,
        model.model.encoder.layers[layer_idx].self_attn.q_proj.weight,
        model.model.encoder.layers[layer_idx].self_attn.v_proj.weight
    ]

    # Compute u, v arrays using the two different methods
    u_array1, v_array1 = compute_u_v_array(weight_array, rank, quant_scheme_int)

    # Initialize WeightArray for iterative quantized SVD calculation
    W = WeightArray(weight_array, 'array', 0.001, 1, 1, 512, 512, quant_scheme_int)
    u_array2, v_array2 = W.compute_uv(rank, 1)

    # u_array2, v_array2 = compute_u_v_array_iterative(weight_array, rank, quant_scheme_int)

    # Calculate MSE for the Quant SVD approach
    # approximated_weight_array1 = [u_array1[i] @ v_array1[i] for i in range(len(weight_array))]
    mse1 = mean_square_error_array1(u_array1, u_array2)

    # Calculate MSE for the Iterative Quant SVD approach
    # approximated_weight_array2 = [u_array2[i] @ v_array2[i] for i in range(len(weight_array))]
    mse2 = mean_square_error_array1(v_array1, v_array2)

    print(u_array1[0][0:20,rank-1])
    print(u_array2[0][0:20,rank-1])

    print(v_array1[0][rank-1,0:20])
    print(v_array2[0][rank-1,0:20])

    # # Calculate Delta MSE
    # delta_mse = mse1 - mse2

    # # Append the MSE values to the lists
    # mse1_list.append(mse1)
    # mse2_list.append(mse2)
    # delta_mse_list.append(delta_mse)

    # Print MSE values for debugging

    print(f"Layer {layer_idx + 1} - MSE U: {mse1}")
    print(f"Layer {layer_idx + 1} - MSE V: {mse2}")
    # print(f"Layer {layer_idx + 1} - Delta MSE (Quant - Iterative Quant SVD): {delta_mse}")`

# Calculate compression ratio (keeping it constant here as it depends on wl)
# compression_ratio = 512 * 512 * 3 * 6 * 32 / (rank * 512 * 2 * 3 * 6 * wl)

# Store a single entry with lists of MSEs for all 6 layers
# results_list.append({
#     "Word Length": wl,
#     "Fraction Length": frac,
#     "Rank": rank,
#     "MSE (Quant SVD) - Layer 1": mse1_list[0],
#     "MSE (Iterative Quant SVD) - Layer 1": mse2_list[0],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 1": delta_mse_list[0],
#     "MSE (Quant SVD) - Layer 2": mse1_list[1],
#     "MSE (Iterative Quant SVD) - Layer 2": mse2_list[1],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 2": delta_mse_list[1],
#     "MSE (Quant SVD) - Layer 3": mse1_list[2],
#     "MSE (Iterative Quant SVD) - Layer 3": mse2_list[2],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 3": delta_mse_list[2],
#     "MSE (Quant SVD) - Layer 4": mse1_list[3],
#     "MSE (Iterative Quant SVD) - Layer 4": mse2_list[3],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 4": delta_mse_list[3],
#     "MSE (Quant SVD) - Layer 5": mse1_list[4],
#     "MSE (Iterative Quant SVD) - Layer 5": mse2_list[4],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 5": delta_mse_list[4],
#     "MSE (Quant SVD) - Layer 6": mse1_list[5],
#     "MSE (Iterative Quant SVD) - Layer 6": mse2_list[5],
#     "Delta MSE (Quant - Iterative Quant SVD) - Layer 6": delta_mse_list[5],
#     "Compression Ratio": compression_ratio
# })

# Convert the list of dictionaries to a DataFrame
# results_df = pd.DataFrame(results_list)

# Save results to a CSV file
# results_df.to_csv('svd_quantization_results_mse1.csv', index=False)