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

ppl = compute_ppl(model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
print('baseline perplexity:', ppl)

# Quantisation
filter = type(model.transformer.h[0].attn)

# Define possible values for wl, fl, symmetric, and round_mode
weight_word_lengths = [2, 4, 6, 8, 10, 12, 14, 16]
act_word_lengths = [4, 6, 8, 16]

results_list = []

for act_wl in act_word_lengths:
    # Iterate over all combinations of wl, fl, symmetric, and round_mode
    for weight_wl in weight_word_lengths: 

            # Replace with quantized model
            int_model = replace_with_quantized(model, weight_wl, "range_based", act_wl, "range_based", filter)

            # Compute BLEU score
            wiki_perplexity = compute_ppl(int_model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=4, device="cuda")
            ptb_perplexity = compute_ppl(int_model, tokenizer, 'ptb', model_seq_len=2048, batch_size=4, device="cuda")
            c4_perplexity = compute_ppl(int_model, tokenizer, 'c4', model_seq_len=2048, batch_size=4, device="cuda")

            # Print BLEU score
            print(f"GPT-NEO-1.3B INT Wikitext2 Perplexity for weight_wl={weight_wl} act_wl={act_wl}")
            print("Wikitext2 Perplexity: ", wiki_perplexity)
            print("PTB Perplexity: ", ptb_perplexity)
            print("C4 Perplexity: ", c4_perplexity)

            # Store the results
            results_list.append({
            "Weight Word Length": weight_wl,
            "Activation Word Length": act_wl,
            "Wiki Perplexity": wiki_perplexity,
            "PTB Perplexity": ptb_perplexity,
            "C4 Perplexity": c4_perplexity,
            "Compression Ratio": 32/weight_wl
            })

# Convert the list of dictionaries to a DataFrame
results_df = pd.DataFrame(results_list)

# Save results to a CSV file
results_df.to_csv('gpt_quantization.csv', index=False)