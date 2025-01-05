import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys
import pandas as pd

from torch import nn
import math

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

# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

import copy

weight_wl = 3
act_wl = 16

symmetric = True
round_mode = "nearest"
results_list = []


# quant_svd_model = replace_with_quantized_svd_wrapper(model, 20, quant_scheme_int, weight_wl, "range_based", filter)
# quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, 512, weight_wl, "range_based", act_wl, "range_based",filter)

baseline_bleu = 41.337328250540224
full_rank=[512,512,512,512,512,512]
rank_arrays = [32,64,96,128,160,192,224,256,288,320,352,384,416,448,480]
# [64,80,96,112,128,144,160,176,192,208,224,240,256,272,288,304,320,336,352,368,384,400,416,432,448,464,480,496,512]
for i in range(6):
    rank_array = copy.deepcopy(full_rank)
    for rank in rank_arrays:
        print("Layer: ",i+1)
        rank_array[i] = rank
        print("Rank Array: ",rank_array)

        bleu = 0

        # bleu = compute_bleu_score(device, change_rank_array(quant_iterative_svd_model, rank_array, filter), tokenizer, source_texts, target_texts)
        # print("BLEU:", bleu)

        # Store the results
        results_list.append({
        "Weight Word Length": weight_wl,
        "Activation Word Length": act_wl,
        "Layer": i+1,
        "Rank": rank,
        "BLEU Score": bleu
        })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('sensitivity.csv', index=False)

