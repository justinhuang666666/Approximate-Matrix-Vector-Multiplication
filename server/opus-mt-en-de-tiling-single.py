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

tile_sizes = [32,64] #[32,64,128,256,512]
steps = [4,8] #[19,38,76,152,304]
skips = [1,2] #[1,2,4,8,16]

def init_tiled_layers(encoder_layers, tile_size):
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

encoder_layers = [model.model.encoder.layers[i] for i in range(6)]  # Example encoder layers

from tqdm import tqdm

metrics_results = []
absolute_error_results = []

with tqdm(total=len(steps), desc='Processing', unit='iteration') as pbar1:
    for tile_size, step, skip in zip(tile_sizes, steps, skips):
        tiled_layers = init_tiled_layers(encoder_layers, tile_size)
        with tqdm(total=step, desc='Processing', unit='iteration') as pbar2:
            for i in range(step):
                for j in range(len(tiled_layers)):
                    for k in range(len(tiled_layers[j])):  # Ensure the correct length is used
                        # Assuming iterative_approximation is defined within the WeightArray class
                        tiled_layers[j][k].iterative_approximation(1)

                if(i%skip==0):
                    metrics_dataframe,absolute_error_dataframe = eval(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts)
                    metrics_results.append(metrics_dataframe)
                    absolute_error_results.append(absolute_error_dataframe)

                pbar2.update(1)
        pbar1.update(1)
    

df = pd.concat(metrics_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('single.csv', index=False)

print("metrics_results saved to 'single.csv'")

df = pd.concat(absolute_error_results, ignore_index=True)  # Correct way to combine DataFrames in a list

# Save the concatenated DataFrame to CSV
df.to_csv('single_error.csv', index=False)

print("absolute_error_results saved to 'single_error.csv'")
