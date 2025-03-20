import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys
import pandas as pd

import warnings

# Suppress all warnings
warnings.filterwarnings("ignore")

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'iterative_approximation'))
from iterative_approximation_gpu import *

# Load the tokenizer and model
model_name = "Helsinki-NLP/opus-mt-fr-en"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()


# Get the model's state dictionary
state_dict = model.state_dict()

# Sum the total number of parameters in the model
num_params = sum(p.numel() for p in state_dict.values())

# Convert the number of parameters to bytes (each parameter is 4 bytes)
model_size_bytes = num_params * 4

# Convert bytes to megabytes (1 MB = 1024 * 1024 bytes)
model_size_mb = model_size_bytes / (1024 * 1024)

print(f"Model size: {model_size_mb:.2f} MB")

# # Check if GPU is available and move model to GPU if possible
# device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
# print(device)
# model.to(device)

# # Load the JSON file
# with open('translations.json', 'r', encoding='utf-8') as f:
#     data = json.load(f)

# # Extract the source and target texts
# source_texts = data['source_texts']
# target_texts = data['target_texts']

# # Compute BLEU score
# baseline_bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
# print("Baseline BLEU Score")
# print(baseline_bleu) 

# baseline_fscore = compute_character_fscore(device, model, tokenizer, source_texts, target_texts)
# print("Baseline Character Fscore")
# print(baseline_fscore) 

# # Create a DataFrame to store the results in a reformatted style
# results = {
#     'Model': ['opus-mt-en-de'],
#     'BLEU Score': [baseline_bleu],
#     'Character Fscore': [baseline_fscore]
# }

# df = pd.DataFrame(results)

# # Save the results to a CSV file named 'baseline.csv'
# df.to_csv('baseline.csv', index=False)

# print("Results saved to 'baseline.csv'")



