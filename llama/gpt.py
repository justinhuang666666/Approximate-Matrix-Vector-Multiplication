import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
from evaluater import *

import warnings
warnings.filterwarnings("ignore")

# Load tokenizer and model
model_name = "EleutherAI/gpt-neo-1.3B"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype=torch.float16)

# Move model to CUDA if available
device = "cuda" if torch.cuda.is_available() else "cpu"
device = torch.device("cuda:3")
model = model.to(device)

# Print model architecture
print(model)

ppl = compute_ppl(model, tokenizer, 'wikitext2', model_seq_len=2048, batch_size=1, device="cuda")
print('baseline perplexity: ',ppl)