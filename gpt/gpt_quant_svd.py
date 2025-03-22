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

# Load tokenizer and model
model_name = "EleutherAI/gpt-neo-1.3B"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float32)

# Move model to CUDA if available
device = "cuda" if torch.cuda.is_available() else "cpu"
model = model.to(device)

baseline_wiki_perplexity = compute_ppl(model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
baseline_ptb_perplexity = compute_ppl(model, tokenizer, 'ptb', model_seq_len=2048, batch_size=4, device="cuda")
print('Baseline Wikitext2 Perplexity:', baseline_wiki_perplexity)
print('Baseline PTB Perplexity:', baseline_ptb_perplexity)

# Quantisation
filter = type(model.transformer.h[0].attn)

print(model.transformer.h[0].attn.attention.k_proj.weight.shape)


act_word_lengths = [6, 8, 16]

rank_samples = [64,80,96,112,128,144,160,176,192,208,224,240,256,272,288,304,320,336,352,368,384,400,416,432,448,464,480,496,512]

symmetric= True
round_mode = "nearest"


# Argument parser
# parser = argparse.ArgumentParser(description="Quantized SVD BLEU score computation")
# parser.add_argument('--weight_wl', type=int, required=True, help="Weight word length for quantization")
# args = parser.parse_args()

# weight_wl = args.weight_wl

# results_list = []
# quant_svd_model = replace_with_quantized_svd_wrapper(model, 512, weight_wl, "range_based", 16, "range_based", filter)
# quant_iterative_svd_model = replace_with_quantized_iterative_svd(model, 512, weight_wl, "range_based", 16, "range_based", filter)

# for act_wl in act_word_lengths:
#     for rank in rank_samples:
#         print(f"Opus-mt-en-de INT BLEU Score for weight_wl={weight_wl}, act_wl={act_wl}, rank={rank}")
#         # Compute BLEU score
#         quant_svd_model = change_rank(quant_svd_model, rank, act_wl, filter)
#         bleu_int1 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
#         print("Quant SVD BLEU (Range-Based)",bleu_int1)

#         # quant_svd_model = replace_with_quantized_svd_wrapper(model, rank, quant_scheme_int, wl, "log2_based", filter)

#         # Compute BLEU score
#         # bleu_int2 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
#         # print("Quant SVD BLEU (Log2-Based)",bleu_int2)

#         # quant_svd_model = replace_with_quantized_svd_wrapper(model, rank, quant_scheme_int, wl, "loss_aware", filter)

#         # Compute BLEU score
#         # bleu_int3 = compute_bleu_score(device, quant_svd_model, tokenizer, source_texts, target_texts)
#         # print("Quant SVD BLEU (Loss-Aware)",bleu_int3)
        
#         quant_iterative_svd_model = change_rank(quant_iterative_svd_model, rank, act_wl, filter)
#         # Compute BLEU score
#         bleu_int4 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
#         print("Iterative Quant SVD BLEU (Range-Based)",bleu_int4)

#         # quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, rank, quant_scheme_int, wl, "log2_based", filter)

#         # Compute BLEU score
#         # bleu_int5 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
#         # print("Iterative Quant SVD BLEU (Log2-Based)",bleu_int5)

#         # quant_iterative_svd_model = replace_with_quantized_iterative_svd_wrapper(model, rank, quant_scheme_int, wl, "loss_aware", filter)

#         # Compute BLEU score
#         # bleu_int6 = compute_bleu_score(device, quant_iterative_svd_model, tokenizer, source_texts, target_texts)
#         # print("Iterative Quant SVD BLEU (Loss-Aware)",bleu_int6)

#         compression_ratio = 512*512*3*6*32/(rank*(512*2)*3*6*weight_wl)

#         # Store the results
#         results_list.append({
#         "Weight Word Length": weight_wl,
#         "Activation Word Length": act_wl,
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
# results_df.to_csv(f'svd_quant_inout_en_de_{weight_wl}.csv', index=False)

