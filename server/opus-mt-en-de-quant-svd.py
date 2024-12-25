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

act_word_lengths = [8,16] #[6, 8, 16]

rank_samples = [5,10] #[64,80,96,112,128,144,160,176,192,208,224,240,256,272,288,304,320,336,352,368,384,400,416,432,448,464,480,496,512]

symmetric= True
round_mode = "nearest"


# Argument parser
parser = argparse.ArgumentParser(description="Quantized SVD BLEU score computation")
parser.add_argument('--weight_wl', type=int, required=True, help="Weight word length for quantization")
args = parser.parse_args()

weight_wl = args.weight_wl

results_list = []
quant_svd_model = replace_with_quantized_svd(model, 10, weight_wl, "range_based", 16, "range_based", filter)
quant_iterative_svd_model = replace_with_quantized_iterative_svd(model, 10, weight_wl, "range_based", 16, "range_based", filter)

for act_wl in act_word_lengths:
    for rank in rank_samples:
        print(f"Opus-mt-en-de INT BLEU Score for weight_wl={weight_wl}, act_wl={act_wl}, rank={rank}")
        # Compute BLEU score
        quant_svd_model = change_rank(quant_svd_model, rank, act_wl, filter)
        bleu_int1 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
        print("Quant SVD BLEU (Range-Based)",bleu_int1)

        # quant_svd_model = replace_with_quantized_svd_wrapper(model, rank, quant_scheme_int, wl, "log2_based", filter)

        # Compute BLEU score
        # bleu_int2 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
        # print("Quant SVD BLEU (Log2-Based)",bleu_int2)

        # quant_svd_model = replace_with_quantized_svd_wrapper(model, rank, quant_scheme_int, wl, "loss_aware", filter)

        # Compute BLEU score
        # bleu_int3 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
        # print("Quant SVD BLEU (Loss-Aware)",bleu_int3)
        
        quant_iterative_svd_model = change_rank(quant_iterative_svd_model, rank, act_wl, filter)
        # Compute BLEU score
        bleu_int4 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
        print("Iterative Quant SVD BLEU (Range-Based)",bleu_int4)

        # quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, rank, quant_scheme_int, wl, "log2_based", filter)

        # Compute BLEU score
        # bleu_int5 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
        # print("Iterative Quant SVD BLEU (Log2-Based)",bleu_int5)

        # quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, rank, quant_scheme_int, wl, "loss_aware", filter)

        # Compute BLEU score
        # bleu_int6 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
        # print("Iterative Quant SVD BLEU (Loss-Aware)",bleu_int6)

        compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*weight_wl)

        # Store the results
        results_list.append({
        "Weight Word Length": weight_wl,
        "Activation Word Length": act_wl,
        "Rank":rank,
        "Quant SVD BLEU (Range-Based)": bleu_int1,
        # "Quant SVD BLEU (Log2-Based)": bleu_int2,
        # "Quant SVD BLEU (Loss-Aware)": bleu_int3,
        "Iterative Quant SVD BLEU (Range-Based)": bleu_int4,
        # "Iterative Quant SVD BLEU (Log2-Based)": bleu_int5,
        # "Iterative Quant SVD BLEU (Loss-Aware)": bleu_int6,
        "Compression Ratio":compression_ratio
        })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv(f'svd_quant_inout_en_de_{weight_wl}.csv', index=False)

