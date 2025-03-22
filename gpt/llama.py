import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
from tqdm import tqdm
import numpy as np

# Load the model and tokenizer
# Replace with the actual LLaMA 3.2 1B model path or identifier if it's local or on Hugging Face
model_name = "meta-llama/Llama-2-7b-hf"  # Change to the 3.2 1B version if available
tokenizer = AutoTokenizer.from_pretrained(model_name, use_fast=False)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float16)

# Evaluate PPL on WikiText
ppl_eval(model, tokenizer, datasets=['wikitext2'], model_seq_len=2048, batch_size=4, device="cuda")