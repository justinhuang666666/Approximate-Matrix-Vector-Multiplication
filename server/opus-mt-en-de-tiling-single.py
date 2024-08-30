import torch
from transformers import MarianMTModel, MarianTokenizer
import json
from utils import *
import os
import sys

import warnings

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

original_atten_block_weight_array_encoder_0 = extract_weight_array(model.model.encoder.layers[0])
original_atten_block_weight_array_encoder_1 = extract_weight_array(model.model.encoder.layers[1])
original_atten_block_weight_array_encoder_2 = extract_weight_array(model.model.encoder.layers[2])
original_atten_block_weight_array_encoder_3 = extract_weight_array(model.model.encoder.layers[3])
original_atten_block_weight_array_encoder_4 = extract_weight_array(model.model.encoder.layers[4])
original_atten_block_weight_array_encoder_5 = extract_weight_array(model.model.encoder.layers[5])

def get_tiled_layers(encoder_layers, tile_size):
    """
    Generate tiled weight arrays for each encoder layer.

    Args:
        encoder_layers (List): List of encoder layers.
        tile_size (int): The size of the tiles for each weight matrix.

    Returns:
        List[List[WeightArray]]: A list containing tiled weight arrays for each encoder layer.
    """
    # Initialize a list to store tiled weight arrays for each layer
    tiled_layers = []

    # Iterate over each layer in the encoder and initialize the tiling
    for layer in encoder_layers:
        # Extract weight arrays for k, q, and v
        weight_array = extract_weight_array(layer)
        k = divide_matrix(weight_array[0], tile_size)
        q = divide_matrix(weight_array[1], tile_size)
        v = divide_matrix(weight_array[2], tile_size)

        # Create WeightArray objects for each tiled matrix
        kk = WeightArray(k, 'array', 0.001, 1, 1, tile_size, tile_size)
        qq = WeightArray(q, 'array', 0.001, 1, 1, tile_size, tile_size)
        vv = WeightArray(v, 'array', 0.001, 1, 1, tile_size, tile_size)

        # Append the initialized weight arrays to the tiled_layers list
        tiled_layers.append([kk, qq, vv])

    return tiled_layers

# Example usage:
tile_size = 64
encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers
tiled_layers = get_tiled_layers(encoder_layers, tile_size)
print(len(tiled_layers[0]))
print(tiled_layers[0][0])
# Output the tiled layers
print("Tiled layers:", tiled_layers)



# W0 = WeightArray(original_atten_block_weight_array_encoder_0,'array',0.001,1,1,512,512)
# W1 = WeightArray(original_atten_block_weight_array_encoder_1,'array',0.001,1,1,512,512)
# W2 = WeightArray(original_atten_block_weight_array_encoder_2,'array',0.001,1,1,512,512)
# W3 = WeightArray(original_atten_block_weight_array_encoder_3,'array',0.001,1,1,512,512)
# W4 = WeightArray(original_atten_block_weight_array_encoder_4,'array',0.001,1,1,512,512)
# W5 = WeightArray(original_atten_block_weight_array_encoder_5,'array',0.001,1,1,512,512)


# mse = []
# bleu_scores = []
# compression_ratio = []

# for i in range(150):  #150
#         atten_block_weight_array_0 = W0.iterative_approximation(1)
#         atten_block_weight_array_1 = W1.iterative_approximation(1)
#         atten_block_weight_array_2 = W2.iterative_approximation(1)
#         atten_block_weight_array_3 = W3.iterative_approximation(1)
#         atten_block_weight_array_4 = W4.iterative_approximation(1)
#         atten_block_weight_array_5 = W5.iterative_approximation(1)

# from tqdm import tqdm

# with tqdm(total=18, desc='Processing', unit='iteration') as pbar:
#     for i in range(18): #18
#         for i in range(5):  #5
#             atten_block_weight_array_0 = W0.iterative_approximation(1)
#             atten_block_weight_array_1 = W1.iterative_approximation(1)
#             atten_block_weight_array_2 = W2.iterative_approximation(1)
#             atten_block_weight_array_3 = W3.iterative_approximation(1)
#             atten_block_weight_array_4 = W4.iterative_approximation(1)
#             atten_block_weight_array_5 = W5.iterative_approximation(1)

#         W0_MSE = (W0.average_mse_array()+W1.average_mse_array()+W2.average_mse_array()+W3.average_mse_array()+W4.average_mse_array()+W5.average_mse_array())/6
#         mse.append(W0_MSE)
#         compression_ratio.append(W0.compression_ratio())

#         set_layer_weight(model.model.encoder.layers[0],atten_block_weight_array_0)
#         set_layer_weight(model.model.encoder.layers[1],atten_block_weight_array_1)
#         set_layer_weight(model.model.encoder.layers[2],atten_block_weight_array_2)
#         set_layer_weight(model.model.encoder.layers[3],atten_block_weight_array_3)
#         set_layer_weight(model.model.encoder.layers[4],atten_block_weight_array_4)
#         set_layer_weight(model.model.encoder.layers[5],atten_block_weight_array_5)

#         bleu = compute_bleu_score(device, model, tokenizer,source_texts,target_texts)
#         bleu_scores.append(bleu)

#         pbar.update(1)


# print(bleu_scores)

