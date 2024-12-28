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

def find_optimal_rank_array(device, model, tokenizer, source_texts, target_texts, initial_rank_array, filter, target_sum, epsilon_0=24, decay_alpha=0.2):

    # Initialize the rank array and BLEU score
    rank_array = initial_rank_array
    best_rank_array = copy.deepcopy(rank_array)
    best_bleu_score = -1

    # Create a DataFrame to store results
    results_df = pd.DataFrame(columns=["Iteration", "Rank Array", "BLEU Score"])

    output_csv = 'best_rank_arrays.csv'

    # Loop until the total rank sum equals the target_sum
    iteration = 0

    while ((sum(rank_array) > target_sum) & (iteration<200)):
        current_best_bleu = -1
        current_best_rank_array = None

        # Calculate gradients using finite difference method for each layer
        for i in range(len(rank_array)):
            # Store original rank to compute perturbations
            original_rank = rank_array[i]
            
            # Apply small perturbations to compute the finite difference gradient
            epsilon = round(epsilon_0 / (1 + decay_alpha * iteration))  # Decaying epsilon

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

            # Update the rank based on the computed gradient (ensure the rank is an integer)
            rank_array[i] = round(rank_array[i] + gradient)

            print(f"Iteration {iteration}, Layer {i}: Rank adjusted to {rank_array[i]} with gradient {gradient}")

        # After adjustment, ensure that the total rank sum equals the target_sum
        total_rank = sum(rank_array)
        if total_rank > target_sum:
            scaling_factor = target_sum / total_rank
            rank_array = [round(r * scaling_factor) for r in rank_array]
        
        # Compute the BLEU score for the updated rank array
        modified_model = change_rank_array(model, rank_array, filter)
        current_best_bleu = compute_bleu_score(device, modified_model, tokenizer, source_texts, target_texts)
        
        # Log the current best result into the DataFrame
        results_df = pd.concat([
            results_df,
            pd.DataFrame({
                "Iteration": [iteration],
                "Rank Array": [rank_array],
                "BLEU Score": [current_best_bleu]
            })
        ], ignore_index=True)

        print(f"Iteration {iteration}: Best BLEU score: {current_best_bleu} with rank array {rank_array}")
        
        # Update best results if needed
        if current_best_bleu > best_bleu_score:
            best_bleu_score = current_best_bleu
            best_rank_array = copy.deepcopy(rank_array)

        iteration += 1

        # Save the DataFrame to a CSV file
        results_df.to_csv(output_csv, index=False)
        print(f"Results saved to {output_csv}")

    return best_rank_array, best_bleu_score

weight_wl = 3
act_wl = 8

symmetric = True
round_mode = "nearest"
results_list = []


# quant_svd_model = replace_with_quantized_svd_wrapper(model, 20, quant_scheme_int, weight_wl, "range_based", filter)
quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, 512, weight_wl, "range_based", act_wl, "range_based",filter)

initial_rank_array = [304,304,304,304,304,304]
target_sum = 256*6

best_rank_array, best_bleu_score = find_optimal_rank_array(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts, initial_rank_array, filter, target_sum)

print("opt rank array:", best_rank_array)
print("opt bleu:", best_rank_array)

#     for rank in rank_samples:
#         print(f"Opus-mt-en-de INT BLEU Score for weight_wl={weight_wl}, rank={rank}")
#         # Compute BLEU score
#         quant_svd_model = change_rank(quant_svd_model, rank, filter)
#         bleu_int1 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
#         print("Quant SVD BLEU (Range-Based)",bleu_int1)
        
#         quant_iterative_svd_model = change_rank(quant_iterative_svd_model, rank, filter)
#         # Compute BLEU score
#         bleu_int4 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
#         print("Iterative Quant SVD BLEU (Range-Based)",bleu_int4)

#         compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*weight_wl)

#         # Store the results
#         results_list.append({
#         "Word Length": weight_wl,
#         "Rank":rank,
#         "Quant SVD BLEU (Range-Based)": bleu_int1,
#         # "Quant SVD BLEU (Log2-Based)": bleu_int2,
#         # "Quant SVD BLEU (Loss-Aware)": bleu_int3,
#         "Iterative Quant SVD BLEU (Range-Based)": bleu_int4,
#         # "Iterative Quant SVD BLEU (Log2-Based)": bleu_int5,
#         # "Iterative Quant SVD BLEU (Loss-Aware)": bleu_int6,
#         "Compression Ratio":compression_ratio
#         })

# # Convert the list of dictionaries to a DataFrame
# results_df = pd.DataFrame(results_list)

# # Save results to a CSV file
# results_df.to_csv('svd_quant_inout_en_de.csv', index=False)

