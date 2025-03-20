import torch
from transformers import AutoModelForCausalLM, AutoTokenizer
import eval_utils

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

# Evaluate on Wikitext2
results = evaluate_model(
    model=model,
    tokenizer=tokenizer,
    model_name=MODEL_NAME,
    tasks="",  # No classification tasks, only perplexity
    eval_ppl="wikitext2",
    num_fewshot=0,
    limit=-1,  # Use full dataset
    batch_size=1,  # Adjust batch size as needed
    use_bos=False,
)

print("\n===== Evaluation Results =====")
print(results)
