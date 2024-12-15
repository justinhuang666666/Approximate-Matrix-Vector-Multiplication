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
baseline_bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
print("Baseline BLEU Score")
print(baseline_bleu) 


# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

# Define possible values for wl, fl, symmetric, and round_mode
word_lengths = [2, 3, 4, 5, 6, 7, 8, 16]

results_list = []

symmetric= True
round_mode = "nearest"


# Iterate over all combinations of wl, fl, symmetric, and round_mode
for wl in word_lengths: 
        fl = wl/2
        frac = wl - fl

        if frac <= 0:
            continue

        # Define the quantization scheme dictionary with IntQuant settings
        args_int.quant_scheme = {
            "act": {"number_type": "int", "wl": 8, "fl": 6, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
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

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "range_based", filter)

        # Compute BLEU score
        bleu_int1 = compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "mean_based", filter)

        # Compute BLEU score
        bleu_int2 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "log2_based", filter)

        # Compute BLEU score
        bleu_int3 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "loss_aware", filter)

        # Compute BLEU score
        bleu_int4 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Print BLEU score
        print(f"Opus-mt-en-de INT BLEU Score for wl={wl}")
        print("Range-Based: ", bleu_int1)
        print("Mean-Based: ", bleu_int2)
        print("Log2-Based: ", bleu_int3)
        print("Loss-Aware: ", bleu_int4)

        # Store the results
        results_list.append({
        "Word Length": wl,
        "BLEU Score (Range-Based)": bleu_int1,
        "BLEU Score (Mean-Based)": bleu_int2,
        "BLEU Score (Log2-Based)": bleu_int3,
        "BLEU Score (Loss-Aware)": bleu_int4,
        "Compression Ratio": 32/wl
        })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('quantization_inout_en_de.csv', index=False)

# Load the tokenizer and model
model_name = "Helsinki-NLP/opus-mt-fr-en"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()

# Check if GPU is available and move model to GPU if possible
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)
model.to(device)

# Load the JSON file
with open('translations_fr_en.json', 'r', encoding='utf-8') as f:
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
word_lengths = [2, 3, 4, 5, 6, 7, 8, 16]

results_list = []

symmetric= True
round_mode = "nearest"


# Iterate over all combinations of wl, fl, symmetric, and round_mode
for wl in word_lengths: 
        fl = wl/2
        frac = wl - fl

        if frac <= 0:
            continue

        # Define the quantization scheme dictionary with IntQuant settings
        args_int.quant_scheme = {
            "act": {"number_type": "int", "wl": 8, "fl": 6, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
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

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "range_based", filter)

        # Compute BLEU score
        bleu_int1 = compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "mean_based", filter)

        # Compute BLEU score
        bleu_int2 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "log2_based", filter)

        # Compute BLEU score
        bleu_int3 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Replace with quantized model
        int_model = replace_with_quantized(model, quant_scheme_int, wl, "loss_aware", filter)

        # Compute BLEU score
        bleu_int4 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

        # Print BLEU score
        print(f"Opus-mt-en-de INT BLEU Score for wl={wl}")
        print("Range-Based: ", bleu_int1)
        print("Mean-Based: ", bleu_int2)
        print("Log2-Based: ", bleu_int3)
        print("Loss-Aware: ", bleu_int4)

        # Store the results
        results_list.append({
        "Word Length": wl,
        "BLEU Score (Range-Based)": bleu_int1,
        "BLEU Score (Mean-Based)": bleu_int2,
        "BLEU Score (Log2-Based)": bleu_int3,
        "BLEU Score (Loss-Aware)": bleu_int4,
        "Compression Ratio": 32/wl
        })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('quantization_inout_fr_en.csv', index=False)


