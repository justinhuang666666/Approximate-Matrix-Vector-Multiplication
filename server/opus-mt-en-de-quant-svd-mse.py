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
word_lengths = [6, 8, 16]
frac_lengths = [1, 2, 3, 4, 5, 6]  # reasonable fraction lengths based on wl
rank_samples = [100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400]

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
        u_approx = u_reduced @ s_reduced  # U * S
        v_approx = v_reduced.T            # Transpose V for multiplication
        
        # Quantize the matrices based on the quant_scheme if required
        u_approx = quantisation(u_approx, quant_scheme)
        v_approx = quantisation(v_approx, quant_scheme)
        
        # Append the approximations to the arrays
        u_array.append(u_approx)
        v_array.append(v_approx)
    
    return u_array, v_array



for rank in rank_samples:
    # Iterate over all combinations of wl, fl, symmetric, and round_mode
    for wl in word_lengths: 
        for fl in frac_lengths:
            # Skip invalid combinations where fl is greater than wl
            frac = wl - fl

            if frac <= 0:
                continue

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

            weight_array = [model.model.encoder.layers[0].self_attn.k_proj.weight, model.model.encoder.layers[0].self_attn.q_proj.weight, model.model.encoder.layers[0].self_attn.v_proj.weight]

            u_array1, v_array1 = compute_u_v_array(weight_array, rank, quant_scheme_int)

            W = WeightArray(weight_array,'array',0.001,1,1,512,512,quant_scheme_int)

            u_array2, v_array2 = W.compute_uv(rank, 1)

            approximated_weight_array1 = [u_array1[i]@v_array1[i] for i in range(len(weight_array))]

            mse1 = mean_square_error_array1(weight_array,approximated_weight_array1) 

            approximated_weight_array2 = [u_array2[i]@v_array2[i] for i in range(len(weight_array))]

            mse2 = mean_square_error_array1(weight_array,approximated_weight_array2) 

            # Print BLEU score
            print(f"Opus-mt-en-de INT BLEU Score for wl={wl}, fl={frac}, rank={rank}")
            print("MSE (Quant SVD)",mse1)
            print("MSE (Iterative Quant SVD)",mse2)

            print("Delta MSE (Quant - Iterative Quant SVD)",mse1 - mse2)
            compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*wl)

            # Store the results
            results_list.append({
            "Word Length": wl,
            "Fraction Length": frac,
            "Rank":rank,
            "MSE (Quant SVD)": mse1,
            "MSE (Iterative Quant SVD)": mse2,
            "Delta MSE (Quant - Iterative Quant SVD)": mse1 - mse2,
            "Compression Ratio":compression_ratio
            })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('svd_quantization_results_mse.csv', index=False)