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
# warnings.filterwarnings("ignore")

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
baseline_bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
print("Baseline BLEU Score")
print(baseline_bleu) 

# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

# Define possible values for wl, fl, symmetric, and round_mode
word_lengths = [4, 5, 6, 7, 8, 16, 32]
frac_lengths = [1, 2, 3, 4, 5, 6, 7, 8]  # reasonable fraction lengths based on wl
rank_samples = [100,150,200,250,300,350,400,450]

symmetric = True
round_mode = "nearest"
results_list = []

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

            quant_svd_model = replace_with_quantized_svd_wrapper(model, rank, quant_scheme_int, filter)

            # Compute BLEU score
            bleu_int = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)

            # Print BLEU score
            print(f"Opus-mt-en-de INT BLEU Score for wl={wl}, fl={frac}, round_mode={round_mode}, symmetric={symmetric}, rank={rank}")
            print("BLEU Score",bleu_int)

            compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*wl)

            # Store the results
            results_list.append({
            "Word Length": wl,
            "Fraction Length": frac,
            "Rank":rank,
            "BLEU Score": bleu_int,
            "Compression Ratio":compression_ratio
            })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('svd_quantization_results.csv', index=False)