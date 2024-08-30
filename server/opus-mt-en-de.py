import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *

import nltk
nltk.download('punkt_tab')

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
baseline_bleu = compute_bleu_score(device,model, tokenizer, source_texts, target_texts)
print(baseline_bleu) 

baseline_fscore = compute_character_fscore(device,model, tokenizer, source_texts, target_texts)

print(baseline_fscore) 

original_atten_block_weight_array_encoder_0 = extract_weight_array(model.model.encoder.layers[0])
original_atten_block_weight_array_encoder_1 = extract_weight_array(model.model.encoder.layers[1])
original_atten_block_weight_array_encoder_2 = extract_weight_array(model.model.encoder.layers[2])
original_atten_block_weight_array_encoder_3 = extract_weight_array(model.model.encoder.layers[3])
original_atten_block_weight_array_encoder_4 = extract_weight_array(model.model.encoder.layers[4])
original_atten_block_weight_array_encoder_5 = extract_weight_array(model.model.encoder.layers[5])

original_atten_block_weight_array_decoder_0 = extract_weight_array(model.model.decoder.layers[0])
original_atten_block_weight_array_decoder_1 = extract_weight_array(model.model.decoder.layers[1])
original_atten_block_weight_array_decoder_2 = extract_weight_array(model.model.decoder.layers[2])
original_atten_block_weight_array_decoder_3 = extract_weight_array(model.model.decoder.layers[3])
original_atten_block_weight_array_decoder_4 = extract_weight_array(model.model.decoder.layers[4])
original_atten_block_weight_array_decoder_5 = extract_weight_array(model.model.decoder.layers[5])

from tqdm import tqdm

print('single matrix approximation')

tile_sizes = [32,64,128,256,512]

with tqdm(total=len(tile_sizes), desc='Processing', unit='iteration') as pbar:
    for tile_size in tile_sizes:

        pbar.update(1)