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

# Compute BLEU score
# baseline_bleu = compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
# print("Baseline BLEU Score")
# print(baseline_bleu) 

# Quantisation
filter = type(model.model.encoder.layers[0])

# Create a mock argument namespace to simulate input arguments
args_int = argparse.Namespace()

import copy

# def find_optimal_rank_array(device, model, tokenizer, source_texts, target_texts, initial_rank_array, filter, target_sum):

#     # Initialize the rank array and BLEU score
#     rank_array = initial_rank_array
#     best_rank_array = copy.deepcopy(rank_array)
#     best_bleu_score = -1

#     # Create a DataFrame to store results
#     results_df = pd.DataFrame(columns=["Iteration", "Rank Array", "BLEU Score"])

#     output_csv = 'best_rank_arrays.csv'

#     # Loop until the total rank sum equals the target_sum
#     iteration = 0

#     # Loop until the total rank sum equals the target_sum
#     while sum(rank_array) > target_sum:
#         current_best_bleu = -1
#         current_best_rank_array = None

#         # Try reducing each element by 4, one at a time
#         for i in range(len(rank_array)):
#             if rank_array[i] > 1:  # Ensure rank remains positive
#                 candidate_rank_array = copy.deepcopy(rank_array)
#                 candidate_rank_array[i] -= 12

#                 # Compute BLEU score for the modified rank array
#                 modified_model = change_rank_array(model, candidate_rank_array, filter)
#                 bleu_score = compute_bleu_score(device, modified_model, tokenizer, source_texts, target_texts)

#                 print(f"Testing rank array {candidate_rank_array} -> BLEU score: {bleu_score}")

#                 # Update if the BLEU score is the best so far
#                 if bleu_score > current_best_bleu:
#                     current_best_bleu = bleu_score
#                     current_best_rank_array = candidate_rank_array

#         # Update the best results for this iteration
#         if current_best_rank_array is not None:
#             rank_array = current_best_rank_array

#         # Log the current best result into the DataFrame
#         results_df = pd.concat([
#             results_df,
#             pd.DataFrame({
#                 "Iteration": [iteration],
#                 "Rank Array": [current_best_rank_array],
#                 "BLEU Score": [current_best_bleu]
#             })
#         ], ignore_index=True)

#         print(f"Iteration {iteration}: Best BLEU score: {current_best_bleu} with rank array {current_best_rank_array}")
#         iteration += 1

#         # Save the DataFrame to a CSV file
#         results_df.to_csv(output_csv, index=False)
#         print(f"Results saved to {output_csv}")

#     return current_best_rank_array, current_best_bleu

def find_optimal_rank_array(device, model, baseline_bleu, tokenizer, source_texts, target_texts, initial_rank_array, filter, epsilon_0=48, decay_alpha=0.2):

    # Initialize the rank array and BLEU score
    rank_array = initial_rank_array
    best_rank_array = copy.deepcopy(rank_array)
    best_bleu_score = -1

    # Create a DataFrame to store results
    results_df = pd.DataFrame(columns=["Iteration", "Rank Array", "BLEU Score"])

    output_csv = 'best_rank_arrays.csv'

    # Loop until the total rank sum equals the target_sum
    iteration = 0

    epsilon = epsilon_0
    
    while (epsilon > 12) and (iteration < 100):
        current_best_bleu = -1

        # Calculate gradients using finite difference method for each layer
        gradients = []

        # Apply small perturbations to compute the finite difference gradient
        epsilon = math.ceil(epsilon_0 / (1 + decay_alpha * iteration))  # Decaying epsilon
        print(f"Iteration {iteration}, Epsilon = {epsilon}")

        # Break condition based on the rank array having any element less than epsilon
        if any(x < epsilon for x in rank_array):
            print("Breaking due to rank array element less than epsilon.")
            break
        
        for i in range(len(rank_array)):
            # Perturb the rank in both directions to compute the gradient
            candidate_rank_array_plus = copy.deepcopy(rank_array)
            candidate_rank_array_plus[i] += epsilon
            candidate_rank_array_minus = copy.deepcopy(rank_array)
            candidate_rank_array_minus[i] -= epsilon

            # Compute BLEU scores for perturbed rank arrays
            bleu_plus = compute_bleu_score(device, change_rank_array(model, candidate_rank_array_plus, filter), tokenizer, source_texts, target_texts)
            bleu_minus = compute_bleu_score(device, change_rank_array(model, candidate_rank_array_minus, filter), tokenizer, source_texts, target_texts)

            # Approximate the gradient using finite difference
            gradient = (bleu_plus - bleu_minus) / (2 * epsilon)
            gradients.append((gradient, i))  # Store the gradient and the corresponding index

            # print(f"Iteration {iteration}, Layer {i}: Gradient = {gradient}")

        # Sort gradients to identify the largest and smallest gradients
        gradients.sort()  # Sorting gradients from smallest to largest
        
        # Identify the layer with the smallest and largest gradients
        min_gradient_layer = gradients[0][1]  # Layer with smallest (most negative) gradient
        max_gradient_layer = gradients[-1][1]  # Layer with largest gradient
        
        rank_array[max_gradient_layer] += epsilon
        rank_array[min_gradient_layer] -= epsilon

        # print(f"Iteration {iteration}: Layer {max_gradient_layer} rank adjusted to {rank_array[max_gradient_layer]}")
        # print(f"Iteration {iteration}: Layer {min_gradient_layer} rank adjusted to {rank_array[min_gradient_layer]}")

        # Compute the BLEU score for the updated rank array
        modified_model = change_rank_array(model, rank_array, filter)
        current_best_bleu = compute_bleu_score(device, modified_model, tokenizer, source_texts, target_texts)

        print(f"Rank array: {rank_array}")
        print(f"BLEI Score: {current_best_bleu}")

        # if(current_best_bleu > best_bleu_score) and (current_best_bleu<baseline_bleu):
        #     best_bleu_score = current_best_bleu
        #     best_rank_array = rank_array

        iteration += 1

    return rank_array, current_best_bleu

weight_wl = 3
act_wl = 8

symmetric = True
round_mode = "nearest"
results_list = []


# quant_svd_model = replace_with_quantized_svd_wrapper(model, 20, quant_scheme_int, weight_wl, "range_based", filter)
quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, 512, weight_wl, "range_based", act_wl, "range_based",filter)

baseline_bleu = 41.337328250540224

initial_rank_arrays = [[368,368,368,368,368,368],[336,336,336,336,336,336],[304,304,304,304,304,304],[272,272,272,272,272,272],[240,240,240,240,240,240],[208,208,208,208,208,208]]
# [64,80,96,112,128,144,160,176,192,208,224,240,256,272,288,304,320,336,352,368,384,400,416,432,448,464,480,496,512]
for initial_rank_array in initial_rank_arrays:
    rank = initial_rank_array[0]
    print("Target rank:",rank)

    best_rank_array, best_bleu_score = find_optimal_rank_array(device, quant_iterative_svd_model, baseline_bleu, tokenizer, source_texts, target_texts, initial_rank_array, filter)
    print("Opt rank array:", best_rank_array)
    print("Opt BLEU:", best_bleu_score)

    compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*weight_wl)

    # Store the results
    results_list.append({
    "Weight Word Length": weight_wl,
    "Activation Word Length": act_wl,
    "Rank":rank,
    "Optimal Rank Array": [best_rank_array],
    "Optimal BLEU Score": best_bleu_score,
    "Compression Ratio":compression_ratio
    })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('optimal_results.csv', index=False)

