import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys

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
# baseline_bleu = compute_bleu_score(device,model, tokenizer, source_texts, target_texts)
# print(baseline_bleu) 

# baseline_fscore = compute_character_fscore(device,model, tokenizer, source_texts, target_texts)

# print(baseline_fscore) 

original_atten_block_weight_array_encoder_0 = extract_weight_array(model.model.encoder.layers[0])
original_atten_block_weight_array_encoder_1 = extract_weight_array(model.model.encoder.layers[1])
original_atten_block_weight_array_encoder_2 = extract_weight_array(model.model.encoder.layers[2])
original_atten_block_weight_array_encoder_3 = extract_weight_array(model.model.encoder.layers[3])
original_atten_block_weight_array_encoder_4 = extract_weight_array(model.model.encoder.layers[4])
original_atten_block_weight_array_encoder_5 = extract_weight_array(model.model.encoder.layers[5])

W0 = WeightArray(original_atten_block_weight_array_encoder_0,'array',0.001,1,1,512,512)
W1 = WeightArray(original_atten_block_weight_array_encoder_1,'array',0.001,1,1,512,512)
W2 = WeightArray(original_atten_block_weight_array_encoder_2,'array',0.001,1,1,512,512)
W3 = WeightArray(original_atten_block_weight_array_encoder_3,'array',0.001,1,1,512,512)
W4 = WeightArray(original_atten_block_weight_array_encoder_4,'array',0.001,1,1,512,512)
W5 = WeightArray(original_atten_block_weight_array_encoder_5,'array',0.001,1,1,512,512)


mse = []
bleu_scores = []
compression_ratio = []

for i in range(10):  #150
        atten_block_weight_array_0 = W0.iterative_approximation(1)
        atten_block_weight_array_1 = W1.iterative_approximation(1)
        atten_block_weight_array_2 = W2.iterative_approximation(1)
        atten_block_weight_array_3 = W3.iterative_approximation(1)
        atten_block_weight_array_4 = W4.iterative_approximation(1)
        atten_block_weight_array_5 = W5.iterative_approximation(1)

for i in range(2): #18
    for i in range(5):  #5
        atten_block_weight_array_0 = W0.iterative_approximation(1)
        atten_block_weight_array_1 = W1.iterative_approximation(1)
        atten_block_weight_array_2 = W2.iterative_approximation(1)
        atten_block_weight_array_3 = W3.iterative_approximation(1)
        atten_block_weight_array_4 = W4.iterative_approximation(1)
        atten_block_weight_array_5 = W5.iterative_approximation(1)

    W0_MSE = (W0.average_mse_array()+W1.average_mse_array()+W2.average_mse_array()+W3.average_mse_array()+W4.average_mse_array()+W5.average_mse_array())/6
    mse.append(W0_MSE)
    compression_ratio.append(W0.compression_ratio())

    set_layer_weight(model.model.encoder.layers[0],atten_block_weight_array_0)
    set_layer_weight(model.model.encoder.layers[1],atten_block_weight_array_1)
    set_layer_weight(model.model.encoder.layers[2],atten_block_weight_array_2)
    set_layer_weight(model.model.encoder.layers[3],atten_block_weight_array_3)
    set_layer_weight(model.model.encoder.layers[4],atten_block_weight_array_4)
    set_layer_weight(model.model.encoder.layers[5],atten_block_weight_array_5)

    bleu = compute_bleu_score(model,source_texts,target_texts)
    bleu_scores.append(bleu)

print(bleu_scores)

# original_atten_block_weight_array_decoder_0 = extract_weight_array(model.model.decoder.layers[0])
# original_atten_block_weight_array_decoder_1 = extract_weight_array(model.model.decoder.layers[1])
# original_atten_block_weight_array_decoder_2 = extract_weight_array(model.model.decoder.layers[2])
# original_atten_block_weight_array_decoder_3 = extract_weight_array(model.model.decoder.layers[3])
# original_atten_block_weight_array_decoder_4 = extract_weight_array(model.model.decoder.layers[4])
# original_atten_block_weight_array_decoder_5 = extract_weight_array(model.model.decoder.layers[5])

from tqdm import tqdm

print('single matrix approximation')

tile_sizes = [32,64]#[32,64,128,256,512]

# with tqdm(total=len(tile_sizes), desc='Processing', unit='iteration') as pbar:
#     for tile_size in tile_sizes:


#         W0 = WeightArray(atten_block_weight_array_encoder_0,'array',0.001,1,1,tile_size,tile_size)
#         W1 = WeightArray(atten_block_weight_array_encoder_1,'array',0.001,1,1,tile_size,tile_size)
#         W2 = WeightArray(atten_block_weight_array_encoder_2,'array',0.001,1,1,tile_size,tile_size)
#         W3 = WeightArray(atten_block_weight_array_encoder_3,'array',0.001,1,1,tile_size,tile_size)
#         W4 = WeightArray(atten_block_weight_array_encoder_4,'array',0.001,1,1,tile_size,tile_size)
#         W5 = WeightArray(atten_block_weight_array_encoder_5,'array',0.001,1,1,tile_size,tile_size)
                
#         pbar.update(1)