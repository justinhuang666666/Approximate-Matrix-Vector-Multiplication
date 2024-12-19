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
weight_word_lengths = [4,8] #[2, 3, 4, 5, 6, 7, 8, 16]
act_word_lengths = [8,16] #[6, 8, 16]

results_list = []

symmetric= True
round_mode = "nearest"

for act_wl in act_word_lengths:
    # Iterate over all combinations of wl, fl, symmetric, and round_mode
    for weight_wl in weight_word_lengths: 

            # Replace with quantized model
            int_model = replace_with_quantized(model, weight_wl, "range_based", act_wl, "range_based", filter)

            # Compute BLEU score
            bleu_int1 = compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "mean_based", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int2 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "log2_based", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int3 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "loss_aware", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int4 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Print BLEU score
            print(f"Opus-mt-en-de INT BLEU Score for weight_wl={weight_wl} act_wl={act_wl}")
            print("Range-Based: ", bleu_int1)
            # print("Mean-Based: ", bleu_int2)
            # print("Log2-Based: ", bleu_int3)
            # print("Loss-Aware: ", bleu_int4)

            # Store the results
            results_list.append({
            "Weight Word Length": weight_wl,
            "Activation Word Length": act_wl,
            "BLEU Score (Range-Based)": bleu_int1,
            # "BLEU Score (Mean-Based)": bleu_int2,
            # "BLEU Score (Log2-Based)": bleu_int3,
            # "BLEU Score (Loss-Aware)": bleu_int4,
            "Compression Ratio": 32/weight_wl
            })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('quantization_inout_en_de3.csv', index=False)

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
weight_word_lengths = [4,8] #[2, 3, 4, 5, 6, 7, 8, 16]
act_word_lengths = [8,16] #[6, 8, 16]

results_list = []

symmetric= True
round_mode = "nearest"

for act_wl in act_word_lengths:
    # Iterate over all combinations of wl, fl, symmetric, and round_mode
    for weight_wl in weight_word_lengths: 

            # Replace with quantized model
            int_model = replace_with_quantized(model, weight_wl, "range_based", act_wl, "range_based", filter)

            # Compute BLEU score
            bleu_int1 = compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "mean_based", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int2 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "log2_based", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int3 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Replace with quantized model
            # int_model = replace_with_quantized(model, weight_wl, "loss_aware", act_wl, "log2_based", filter)

            # Compute BLEU score
            # bleu_int4 =  compute_bleu_score(device, int_model, tokenizer, source_texts, target_texts)

            # Print BLEU score
            print(f"Opus-mt-en-de INT BLEU Score for weight_wl={weight_wl} act_wl={act_wl}")
            print("Range-Based: ", bleu_int1)
            # print("Mean-Based: ", bleu_int2)
            # print("Log2-Based: ", bleu_int3)
            # print("Loss-Aware: ", bleu_int4)

            # Store the results
            results_list.append({
            "Weight Word Length": weight_wl,
            "Activation Word Length": act_wl,
            "BLEU Score (Range-Based)": bleu_int1,
            # "BLEU Score (Mean-Based)": bleu_int2,
            # "BLEU Score (Log2-Based)": bleu_int3,
            # "BLEU Score (Loss-Aware)": bleu_int4,
            "Compression Ratio": 32/weight_wl
            })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('quantization_inout_fr_en3.csv', index=False)


