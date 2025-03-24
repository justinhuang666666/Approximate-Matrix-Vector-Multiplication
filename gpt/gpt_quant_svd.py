import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
from evaluater import *

import warnings
warnings.filterwarnings("ignore")

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
from quant import *

import pandas as pd

import time

# Load tokenizer and model
model_name = "EleutherAI/gpt-neo-1.3B"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float32)

# Move model to CUDA if available
device = "cuda" if torch.cuda.is_available() else "cpu"
model = model.to(device)

# baseline_wiki_perplexity = compute_ppl(model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
# baseline_ptb_perplexity = compute_ppl(model, tokenizer, 'ptb', model_seq_len=2048, batch_size=4, device="cuda")
# print('Baseline Wikitext2 Perplexity:', baseline_wiki_perplexity)
# print('Baseline PTB Perplexity:', baseline_ptb_perplexity)

# Quantisation
filter = type(model.transformer.h[0].attn)

# rank_samples = list(range(256, 2048 + 1, 256))

rank_samples = list(range(128, 1152 + 1, 128))

print(rank_samples)

# Argument parser
# parser = argparse.ArgumentParser(description="Quantized SVD BLEU score computation")
# parser.add_argument('--weight_wl', type=int, required=True, help="Weight word length for quantization")
# args = parser.parse_args()

# weight_wl = args.weight_wl

# weight_wl = 8
# act_word_lengths = [8, 16]

# results_list = []
# print("Start decomposing SVD model...")
# start_time = time.time()
# quant_svd_model = replace_with_quantized_svd_wrapper(model, 1152, weight_wl, "range_based", 16, "range_based", filter)
# end_time = time.time()
# elapsed_time = end_time - start_time
# print(f"SVD decomposition time: {elapsed_time:.4f} seconds")


# print("Start decomposing iterative SVD model...")
# start_time = time.time()
# quant_iterative_svd_model = replace_with_quantized_iterative_svd(model, 1152, weight_wl, "range_based", 16, "range_based", filter)
# end_time = time.time()
# elapsed_time = end_time - start_time
# print(f"Iterative SVD decomposition time: {elapsed_time:.4f} seconds")

# for act_wl in act_word_lengths:

#     for rank in rank_samples:
#         print(f"GPT-NEO-1B INT Model for weight_wl={weight_wl}, act_wl={act_wl}, rank={rank}")
#         # Compute BLEU score
#         quant_svd_model = change_rank(quant_svd_model, rank, act_wl, filter)
#         wiki_perplexity1 = compute_ppl(quant_svd_model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
#         print("Quant SVD Perplexity: ", wiki_perplexity1)
        
#         quant_iterative_svd_model = change_rank(quant_iterative_svd_model, rank, act_wl, filter)
#         # Compute BLEU score
#         wiki_perplexity2 = compute_ppl(quant_iterative_svd_model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
#         print("Iterative Quant SVD Perplexity",wiki_perplexity2)

#         compression_ratio = 2048*2048*3*24*32/(rank*(2048*2)*3*24*weight_wl)

#         # Store the results
#         results_list.append({
#         "Weight Word Length": weight_wl,
#         "Activation Word Length": act_wl,
#         "Rank":rank,
#         "Quant SVD Perplexity": wiki_perplexity1,
#         "Iterative Quant SVD Perplexity": wiki_perplexity2,
#         "Compression Ratio":compression_ratio
#         })

# # Convert the list of dictionaries to a DataFrame
# results_df = pd.DataFrame(results_list)

# # Save results to a CSV file
# results_df.to_csv(f'gpt_quant_svd_{weight_wl}.csv', index=False)

