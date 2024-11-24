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
        u_approx_quant = quantisation(u_approx, quant_scheme)
        v_approx_quant = quantisation(v_approx, quant_scheme)

        # Append the approximations to the arrays
        u_array.append(u_approx_quant)
        v_array.append(v_approx_quant)
    
    return u_array, v_array

def compute_u_v_iterative(weight, rank, quant_scheme=None):
    if isinstance(weight, torch.Tensor):
        weight = weight.cpu().detach().numpy()  # Convert to NumPy if PyTorch tensor

    # Validate rank
    if rank > min(weight.shape):
        raise ValueError(f"Rank ({rank}) cannot exceed the minimum dimension of the weight matrix {weight.shape}.")

    u_approx_list = []
    v_approx_list = []

    residual = weight.copy()  # Create a copy of the weight matrix for residual calculations

    for _ in range(rank):
        # Perform SVD on the current weight matrix to get the first singular vector and value
        u, s, v_t = np.linalg.svd(residual, full_matrices=False)

        # Select the first singular value/vector (rank-1 approximation)
        sigma = s[0]  # The largest singular value
        u_1 = u[:, 0].reshape(-1, 1)  # Column vector for U
        v_1 = v_t[0, :].reshape(1, -1)  # Row vector for V (already transposed in np.linalg.svd)

        # Convert results back to PyTorch tensors if needed
        u_approx = torch.tensor(u_1 * sigma)
        v_approx = torch.tensor(v_1)
        
        # Quantize the matrices based on the quant_scheme if required
        u_approx_quant = quantisation(u_approx, quant_scheme)
        v_approx_quant = quantisation(v_approx, quant_scheme)

        # Compute the rank-1 approximation and append to lists
        u_approx_list.append(u_approx_quant)
        v_approx_list.append(v_approx_quant)

        # Subtract the rank-1 approximation from weight to get the residual
        residual -= (u_approx_quant @ v_approx_quant).numpy()  # Convert to NumPy for subtraction

    # Stack the rank-1 approximations to form the final reduced U and V
    u_approx = torch.tensor(np.hstack(u_approx_list))  # Convert back to PyTorch tensor
    v_approx = torch.tensor(np.vstack(v_approx_list))  # Convert back to PyTorch tensor

    return u_approx, v_approx

rank_samples = [1,20,40,60,80]
word_lengths = [32,16,8,6,4]

symmetric = False
round_mode = "nearest"
results_list = []

for rank in rank_samples:
    # Iterate over all combinations of wl, fl, symmetric, and round_mode
    for wl in word_lengths: 
        fl = wl/2
        fl = int(fl)
            
        # Skip invalid combinations where fl is greater than wl
        frac = wl - fl

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

        print(f"Opus-mt-en-de INT BLEU Score for wl={wl}, fl={frac}, rank={rank}")
        # Loop over the 6 encoder layers in the model

        mse1_list = []
        mse2_list = []
        mse3_list = []
        delta_mse_list = []

        for layer_idx in range(6):

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
            mse1 = mean_square_error_array1(weight_array, approximated_weight_array1)
            mse2 = mean_square_error_array1(weight_array, approximated_weight_array2)
            mse3 = mean_square_error_array1(approximated_weight_array1, approximated_weight_array2)

            mse1_list.append(mse1)
            mse2_list.append(mse2)
            mse3_list.append(mse3)
            delta_mse_list.append(mse1-mse2)

            print(f"Layer {layer_idx + 1} - MSE 1: {mse1:.20f}")
            print(f"Layer {layer_idx + 1} - MSE 2: {mse2:.20f}")
            print(f"Layer {layer_idx + 1} - MSE 1 - MSE 2: {mse1 - mse2:.20f}")
            print(f"Layer {layer_idx + 1} - MSE 3: {mse3:.20f}")
            # print(f"Layer {layer_idx + 1} - Diff MSE: {mse1-mse2:.20f}")

        # Calculate compression ratio (keeping it constant here as it depends on wl)
        compression_ratio = 512 * 512 * 3 * 6 * 32 / (rank * 512 * 2 * 3 * 6 * wl)

        # Store a single entry with lists of MSEs for all 6 layers
        results_list.append({
            "Word Length": wl,
            "Fraction Length": frac,
            "Rank": rank,
            "MSE (Quant SVD) - Layer 1": mse1_list[0],
            "MSE (Iterative Quant SVD) - Layer 1": mse2_list[0],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 1": delta_mse_list[0],
            "Mean Square Diff - Layer 1": mse3_list[0],
            "MSE (Quant SVD) - Layer 2": mse1_list[1],
            "MSE (Iterative Quant SVD) - Layer 2": mse2_list[1],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 2": delta_mse_list[1],
            "Mean Square Diff - Layer 2": mse3_list[1],
            "MSE (Quant SVD) - Layer 3": mse1_list[2],
            "MSE (Iterative Quant SVD) - Layer 3": mse2_list[2],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 3": delta_mse_list[2],
            "Mean Square Diff - Layer 3": mse3_list[2],
            "MSE (Quant SVD) - Layer 4": mse1_list[3],
            "MSE (Iterative Quant SVD) - Layer 4": mse2_list[3],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 4": delta_mse_list[3],
            "Mean Square Diff - Layer 4": mse3_list[3],
            "MSE (Quant SVD) - Layer 5": mse1_list[4],
            "MSE (Iterative Quant SVD) - Layer 5": mse2_list[4],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 5": delta_mse_list[4],
            "Mean Square Diff - Layer 5": mse3_list[4],
            "MSE (Quant SVD) - Layer 6": mse1_list[5],
            "MSE (Iterative Quant SVD) - Layer 6": mse2_list[5],
            "Delta MSE (Quant - Iterative Quant SVD) - Layer 6": delta_mse_list[5],
            "Mean Square Diff - Layer 6": mse3_list[5],
            "Compression Ratio": compression_ratio
        })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
# results_df.to_csv('svd_quantization_results_mse4.csv', index=False)