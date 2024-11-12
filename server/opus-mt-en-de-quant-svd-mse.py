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
# word_lengths = [4, 6, 8, 16]
# frac_lengths = [1, 2, 3, 4, 5, 6]  # reasonable fraction lengths based on wl
# rank_samples = [50, 100, 150, 200]

symmetric = True
round_mode = "nearest"
results_list = []


# def compute_u_v_array(weight_array, rank, quant_scheme):
#     u_array = []
#     v_array = []
    
#     for i in range(len(weight_array)):
#         # Get the weight matrix
#         weight = weight_array[i]
        
#         # Perform SVD on the weight matrix to get U, S, V matrices
#         u, s, v = torch.svd(weight)
        
#         # Reduce U, S, and V matrices to specified rank
#         u_reduced = u[:, :rank]
#         s_reduced = torch.diag(s[:rank])
#         v_reduced = v[:, :rank]
        
#         # Compute the rank-r approximation
#         u_approx = u_reduced @ s_reduced    # U * S
#         v_approx = v_reduced.T  # Transpose V for multiplication
        
#         # Quantize the matrices based on the quant_scheme if required
#         # u_approx = quantisation(u_approx, quant_scheme)
#         # v_approx = quantisation(v_approx, quant_scheme)
        
#         # Append the approximations to the arrays
#         u_array.append(u_approx)
#         v_array.append(v_approx)
    
#     return u_array, v_array

import numpy as np

def compute_u_v_array(weight_array, rank, quant_scheme=None):
    u_array = []
    v_array = []
    
    for i in range(len(weight_array)):
        # Get the weight matrix and convert to NumPy for SVD
        weight = weight_array[i].cpu().detach().numpy() if isinstance(weight_array[i], torch.Tensor) else weight_array[i]
        
        # Perform SVD using numpy to get U, S, V matrices
        u, s, v_t = np.linalg.svd(weight, full_matrices=False)  # v_t is already transposed in numpy
        
        # Reduce U, S, and V matrices to the specified rank
        u_reduced = u[:, :rank]
        s_reduced = np.diag(s[:rank])
        v_reduced = v_t[:rank, :]
        
        # Compute the rank-r approximation in numpy
        u_approx = u_reduced @ s_reduced    # U * S
        v_approx = v_reduced  # V^T is already transposed from np.linalg.svd

        # Convert results back to PyTorch tensors if needed
        u_approx = torch.tensor(u_approx)
        v_approx = torch.tensor(v_approx)
        
        # Quantize the matrices based on the quant_scheme if required
        # u_approx = quantisation(u_approx, quant_scheme)
        # v_approx = quantisation(v_approx, quant_scheme)
        
        # Append the approximations to the arrays
        u_array.append(u_approx)
        v_array.append(v_approx)
    
    return u_array, v_array

# def compute_u_v_array_iterative(weight_array, rank, quant_scheme):
#     u_array = []
#     v_array = []
    
#     for i in range(len(weight_array)):
#         # Get the weight matrix
#         weight = weight_array[i]
        
#         # Initialize an empty list to store intermediate u and v for each rank-1 approximation
#         u_approx_list = []
#         v_approx_list = []
        
#         # Iteratively decompose the matrix to get rank-1 approximations
#         for _ in range(rank):
#             # Perform SVD on the current weight matrix to get the first singular vector and value
#             u, s, v = torch.svd(weight)
            
#             # Select the first singular value/vector (rank-1 approximation)
#             sigma = s[0]  # The largest singular value
#             u_1 = u[:, 0].unsqueeze(1)  # Column vector for U
#             v_1 = v[:, 0].unsqueeze(1)  # Column vector for V
            
#             # Compute the rank-1 matrix and append to approximations
#             u_approx_list.append(u_1 * sigma)
#             v_approx_list.append(v_1.T)
            
#             # Subtract the rank-1 approximation from the weight to get the residual
#             weight = weight - sigma * (u_1 @ v_1.T)
        
#         # Stack the rank-1 approximations to form the final reduced U and V
#         u_approx = torch.cat(u_approx_list, dim=1)
#         v_approx = torch.cat(v_approx_list, dim=0)
        
#         # Optionally, quantize the matrices based on the quant_scheme
#         # u_approx = quantisation(u_approx, quant_scheme)
#         # v_approx = quantisation(v_approx, quant_scheme)
        
#         # Append the final reduced U and V matrices to the arrays
#         u_array.append(u_approx)
#         v_array.append(v_approx)
    
#     return u_array, v_array

# def compute_u_v_iterative(weight, rank, quant_scheme=None):
#     u_approx_list = []
#     v_approx_list = []

#     # Iteratively decompose the matrix to get rank-1 approximations
#     for _ in range(rank):
#         # Perform SVD on the current weight matrix to get the first singular vector and value
#         u, s, v = torch.svd(weight)

#         # Select the first singular value/vector (rank-1 approximation)
#         sigma = s[0]  # The largest singular value
#         u_1 = u[:, 0].unsqueeze(1)  # Column vector for U
#         v_1 = v[:, 0].unsqueeze(1)  # Column vector for V

#         # Compute the rank-1 matrix and append to approximations
#         u_approx_list.append(u_1 * sigma)
#         v_approx_list.append(v_1.T)

#         # Subtract the rank-1 approximation from the weight to get the residual
#         weight = weight - sigma * (u_1 @ v_1.T)

#     # Stack the rank-1 approximations to form the final reduced U and V
#     u_approx = torch.cat(u_approx_list, dim=1)
#     v_approx = torch.cat(v_approx_list, dim=0)

#     return u_approx, v_approx

def compute_u_v_iterative(weight, rank, quant_scheme=None):
    u_approx_list = []
    v_approx_list = []

    # Convert weight matrix to a NumPy array if it's a PyTorch tensor
    weight = weight.cpu().detach().numpy() if isinstance(weight, torch.Tensor) else weight

    # Iteratively decompose the matrix to get rank-1 approximations
    for _ in range(rank):
        # Perform SVD on the current weight matrix to get the first singular vector and value
        u, s, v_t = np.linalg.svd(weight, full_matrices=False)

        # Select the first singular value/vector (rank-1 approximation)
        sigma = s[0]  # The largest singular value
        u_1 = u[:, 0].reshape(-1, 1)  # Column vector for U
        v_1 = v_t[0, :].reshape(1, -1)  # Row vector for V (already transposed in np.linalg.svd)

        # Compute the rank-1 approximation and append to lists
        u_approx_list.append(u_1 * sigma)
        v_approx_list.append(v_1)

        # Subtract the rank-1 approximation from weight to get the residual
        weight = weight - sigma * (u_1 @ v_1)

    # Stack the rank-1 approximations to form the final reduced U and V
    u_approx = torch.tensor(np.hstack(u_approx_list))  # Convert back to PyTorch tensor
    v_approx = torch.tensor(np.vstack(v_approx_list))  # Convert back to PyTorch tensor

    return u_approx, v_approx

rank_samples = [1,2,3]
for rank in rank_samples:
#     # Iterate over all combinations of wl, fl, symmetric, and round_mode
#     for wl in word_lengths: 
#         for fl in frac_lengths:

    wl = 16
    fl = 8
        
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
    layer_idx = 0
    # for layer_idx in range(6):

    # Access the weights for k_proj, q_proj, and v_proj in the self-attention of each layer
    weight_array = [
        model.model.encoder.layers[layer_idx].self_attn.k_proj.weight,
        model.model.encoder.layers[layer_idx].self_attn.q_proj.weight,
        model.model.encoder.layers[layer_idx].self_attn.v_proj.weight
    ]

    # Compute u, v arrays using the two different methods
    u_array1, v_array1 = compute_u_v_array(weight_array, rank, quant_scheme_int)

    # Initialize WeightArray for iterative quantized SVD calculation
    # W = WeightArray(weight_array, 'array', 0.001, 1, 1, 512, 512, quant_scheme_int)
    # u_array2, v_array2 = W.compute_uv(rank, 1)

    u_array2 = []
    v_array2 = []
    for i in range(len(weight_array)):
        u, v = compute_u_v_iterative(weight_array[i], rank, quant_scheme_int)
        u_array2.append(u)
        v_array2.append(v)


    # Calculate MSE for the Iterative Quant SVD approach
    approximated_weight_array1 = [u_array1[i] @ v_array1[i] for i in range(len(weight_array))]
    approximated_weight_array2 = [u_array2[i] @ v_array2[i] for i in range(len(weight_array))]
    mse1 = mean_square_error_array1(u_array1, u_array2)
    mse2 = mean_square_error_array1(v_array1, v_array2)
    mse3 = mean_square_error_array1(approximated_weight_array1, approximated_weight_array2)

    # mse1_list.append(mse1)
    # mse2_list.append(mse2)
    # delta_mse_list.append(mse1-mse2)

    for j in range(3):
        # print(f"W1: {approximated_weight_array1[j][0:5, 0:5].cpu()}")
        # print(f"W2: {approximated_weight_array2[j][0:5, 0:5].cpu()}")

        # Compute MSE between approximated_weight_array1 and approximated_weight_array2
        mse_check_1 = (u_array1[j] - u_array2[j]).pow(2).mean()
        # Compute MSE between approximated_weight_array1 and approximated_weight_array2
        mse_check_2 = (v_array1[j] - v_array2[j]).pow(2).mean()
        mse_check_3 = (approximated_weight_array1[j] - approximated_weight_array2[j]).pow(2).mean()

        print(f"MSE Check 1: {mse_check_1:.20f}")
        print(f"MSE Check 2: {mse_check_2:.20f}")
        print(f"MSE Check 3: {mse_check_3:.20f}")

    print(f"Layer {layer_idx + 1} - MSE 1: {mse1:.20f}")
    print(f"Layer {layer_idx + 1} - MSE 2: {mse2:.20f}")
    print(f"Layer {layer_idx + 1} - MSE 3: {mse3:.20f}")
    # print(f"Layer {layer_idx + 1} - Diff MSE: {mse1-mse2:.20f}")

    # Calculate compression ratio (keeping it constant here as it depends on wl)
    compression_ratio = 512 * 512 * 3 * 6 * 32 / (rank * 512 * 2 * 3 * 6 * wl)

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
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
# results_df.to_csv('svd_quantization_results_mse3.csv', index=False)