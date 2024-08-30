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

tile_size = 512 #[32,64.128,256,512]
encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers
tiled_layers = init_tiled_layers(encoder_layers, tile_size)

from tqdm import tqdm

# Debugging using tqdm for progress visualization
with tqdm(total=200, desc='Processing', unit='iteration') as pbar:
    for step in range(200):
        for i in range(len(tiled_layers)):
            for j in range(len(tiled_layers[i])):  # Ensure the correct length is used
                # Assuming iterative_approximation is defined within the WeightArray class
                tiled_layers[i][j].iterative_approximation(1)
        pbar.update(1)

# Loop to merge approximated submatrices back into full matrices
for i in range(len(tiled_layers)):
    approximated_matrix_array = []
    for j in range(len(tiled_layers[i])):  # Ensure correct sublist length
        # Access the current reconstructed submatrices
        approximated_submatrix_array = tiled_layers[i][j].current_reconstructed_weight_array

        # Merge submatrices back into the original sized matrix
        approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

        # Append the merged matrix to the array
        approximated_matrix_array.append(approximated_matrix)

    # Set the approximated matrices as weights for the model layer
    set_layer_weight(model.model.encoder.layers[i],approximated_matrix_array)

bleu = compute_bleu_score(device, model, tokenizer,source_texts,target_texts)
print(bleu)





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

