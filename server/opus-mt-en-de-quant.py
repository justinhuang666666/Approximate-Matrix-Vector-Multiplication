import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys
import pandas as pd

from torch import nn

import warnings

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


print(MarianMTModel.model.encoder)
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

# baseline_fscore = compute_character_fscore(device, model, tokenizer, source_texts, target_texts)
# print("Baseline Character Fscore")
# print(baseline_fscore) 

# Create a DataFrame to store the results in a reformatted style
# results = {
#     'Model': ['opus-mt-en-de'],
#     'BLEU Score': [baseline_bleu],
#     'Character Fscore': [baseline_fscore]
# }

# df = pd.DataFrame(results)

# # Save the results to a CSV file named 'baseline.csv'
# df.to_csv('baseline.csv', index=False)

# print("Results saved to 'baseline.csv'")


# Quantisation
attention_layer_types = nn.MultiheadAttention

import argparse

# Create a mock argument namespace to simulate input arguments
args_int32 = argparse.Namespace()

# Define the quantization scheme dictionary with IntQuant settings
args_int32.quant_scheme = {
    "act": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "weight": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "bact": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "bweight": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "goact": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "goweight": {"number_type": "int", "wl": 32, "fl": 27, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "same_input": True,
    "same_weight": True
}

# Create the quantization scheme using the from_args method
quant_scheme_int32 = QuantScheme.from_args(args_int32)

quant_scheme_int32 = replace_with_quantized(model, quant_scheme_int32)

bleu_int32 = compute_bleu_score(device, quant_scheme_int32, tokenizer, source_texts, target_texts)
print("INT32 BLEU Score")
print(bleu_int32) 


# Create a mock argument namespace to simulate input arguments
args_int16 = argparse.Namespace()

# Define the quantization scheme dictionary with IntQuant settings
args_int16.quant_scheme = {
    "act": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "weight": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "bact": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "bweight": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "goact": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "goweight": {"number_type": "int", "wl": 16, "fl": 11, "clamp": True, "symmetric": False, "round_mode": "stochastic"},
    "same_input": True,
    "same_weight": True
}

# Create the quantization scheme using the from_args method
quant_scheme_int16 = QuantScheme.from_args(args_int16)


# INT16_model = replace_with_quantized(model, quant_scheme_int16, attention_layer_types)
INT16_model = replace_with_quantized(model, quant_scheme_int16)

bleu_int16 = compute_bleu_score(device, INT16_model, tokenizer, source_texts, target_texts)
print("INT16 BLEU Score")
print(bleu_int16) 



