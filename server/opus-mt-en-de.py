import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *

import nltk
nltk.download('punkt', download_dir='.')

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
baseline_bleu = compute_bleu_score(model, tokenizer, source_texts, target_texts)
print(baseline_bleu) 

baseline_fscore = compute_character_fscore(model, tokenizer, source_texts, target_texts)

print(baseline_fscore) 

# from tqdm import tqdm

# with tqdm(total=100, desc='Processing', unit='iteration') as pbar:
#     for _ in range(100):

#         # Update the progress bar
#         pbar.update(1)