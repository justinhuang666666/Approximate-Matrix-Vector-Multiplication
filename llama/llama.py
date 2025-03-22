import torch
from transformers import AutoModelForCausalLM, AutoTokenizer
from evalutils import *

# Load Llama 3.2 Model and Tokenizer
MODEL_NAME = "meta-llama/Llama-3.2-1B"  # Adjust if needed
device = "cuda" if torch.cuda.is_available() else "cpu"

print(f"Loading model: {MODEL_NAME} on {device}...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME, torch_dtype=torch.float16 if device == "cuda" else torch.float32
)
model.to(device)
model.eval()
print(model)
# Run Perplexity Evaluation on Wikitext2
# ppl_results = ppl_eval(
#     model=model,
#     tokenizer=tokenizer,
#     datasets=['wikitext2'],
#     model_seq_len=2048,
#     batch_size=32,  # Adjust based on GPU memory
#     device=device
# )

# print("\n===== Final Perplexity Results =====")
# print(ppl_results)

