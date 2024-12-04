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

# Compute BLEU score
# baseline_bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
# print("Baseline BLEU Score")
# print(baseline_bleu) 

# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

# Define possible values for wl, fl, symmetric, and round_mode
word_lengths = [4,8] #[2, 4, 6, 8, 16]
rank_samples_array = [[30,60],[15,30]] #[[256,320,384,448,512],[128,160,192,224,256],[85,105,125,145,165],[64,80,96,112,128],[32,40,48,56,64]]

symmetric = True
round_mode = "nearest"
results_list = []


for idx, wl in enumerate(word_lengths): 
    rank_samples = rank_samples_array[idx]
    for rank in rank_samples:
        fl = wl/2
        fl = int(fl)
        frac = wl - fl

        print(f"Opus-mt-en-de INT BLEU Score for wl={wl}, rank={rank}")

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

        mse1_list = []
        mse2_list = []
        mse3_list = []
        
        for layer_idx in range(6):

            # Access the weights for k_proj, q_proj, and v_proj in the self-attention of each layer
            weight_array = [
                model.model.encoder.layers[layer_idx].self_attn.k_proj.weight,
                model.model.encoder.layers[layer_idx].self_attn.q_proj.weight,
                model.model.encoder.layers[layer_idx].self_attn.v_proj.weight
            ]

            # Compute u, v arrays using the two different methods
            u_array1, v_array1 = compute_u_v_array(weight_array, rank, wl, "range_based")

            u_array2 = []
            v_array2 = []
            for i in range(len(weight_array)):
                u, v = compute_u_v_iterative(weight_array[i], rank, wl, "range_based")
                u_array2.append(u)
                v_array2.append(v)


            # Calculate MSE for the Iterative Quant SVD approach
            approximated_weight_array1 = [u_array1[i] @ v_array1[i] for i in range(len(weight_array))]
            approximated_weight_array2 = [u_array2[i] @ v_array2[i] for i in range(len(weight_array))]
            mse1 = mean_square_error_array1(weight_array, approximated_weight_array1)
            mse2 = mean_square_error_array1(weight_array, approximated_weight_array2)
            mse3 = mse1 - mse2

            mse1_list.append(mse1)
            mse2_list.append(mse2)
            mse3_list.append(mse3)

        compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*wl)

        # Store the results
        results_list.append({
        "Word Length": wl,
        "Rank":rank,
        "MSE Layer 1":mse1_list[0],
        "Iterative MSE Layer 1":mse2_list[0],
        "Delta MSE Layer 1":mse3_list[0],
        "MSE Layer 2":mse1_list[1],
        "Iterative MSE Layer 2":mse2_list[1],
        "Delta MSE Layer 2":mse3_list[1],
        "MSE Layer 3":mse1_list[2],
        "Iterative MSE Layer 3":mse2_list[2],
        "Delta MSE Layer 3":mse3_list[2],
        "MSE Layer 4":mse1_list[3],
        "Iterative MSE Layer 4":mse2_list[3],
        "Delta MSE Layer 4":mse3_list[3],
        "MSE Layer 5":mse1_list[4],
        "Iterative MSE Layer 5":mse2_list[4],
        "Delta MSE Layer 5":mse3_list[4],
        "MSE Layer 6":mse1_list[5],
        "Iterative MSE Layer 6":mse2_list[5],
        "Delta MSE Layer 6":mse3_list[5],
        "Compression Ratio":compression_ratio
        })

        result = results_list[-1]
        print(f"  Word Length: {result['Word Length']}")
        print(f"  Rank: {result['Rank']}")
        print(f"  Compression Ratio: {result['Compression Ratio']}")
    
        for layer in range(1, 7):  # Assuming 6 layers
            print(f"  Layer {layer}:")
            print(f"    MSE: {result[f'MSE Layer {layer}']}")
            print(f"    Iterative MSE: {result[f'Iterative MSE Layer {layer}']}")
            print(f"    Delta MSE: {result[f'Delta MSE Layer {layer}']}")
        print("-" * 50)


# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('svd_quantization_scaling_mse1.csv', index=False)