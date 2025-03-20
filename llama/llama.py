import torch
import torch.nn.functional as F
from transformers import AutoModelForCausalLM, AutoTokenizer
from datasets import load_dataset
from tqdm import tqdm

# Load Llama 3.2 Model and Tokenizer
MODEL_NAME = "meta-llama/Llama-3.2-1B"  # Adjust if needed
device = "cuda" if torch.cuda.is_available() else "cpu"

print(f"Loading model: {MODEL_NAME} on {device}...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = AutoModelForCausalLM.from_pretrained(MODEL_NAME, torch_dtype=torch.float16 if device == "cuda" else torch.float32)
model.to(device)
model.eval()

# Load WikiText-2 dataset
print("Loading WikiText-2 dataset...")
dataset = load_dataset("wikitext", "wikitext-2-raw-v1", split="test")
text_data = dataset["text"]  # List of text strings

# Ensure the tokenizer has a pad token
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token  # Use EOS token as PAD token

# Tokenize dataset with proper padding
print("Tokenizing dataset...")
tokenized_inputs = tokenizer(
    text_data,
    return_tensors="pt",
    truncation=True,
    padding=True,
    max_length=2048
)
input_ids = tokenized_inputs["input_ids"].to(device)

# Compute Perplexity
def compute_perplexity(model, input_ids):
    total_loss = 0.0
    total_tokens = 0

    with torch.no_grad():
        for i in tqdm(range(len(input_ids))):  # Loop through each token sequence
            inputs = input_ids[i].unsqueeze(0)  # Single sequence

            # Mask padding tokens in labels
            labels = inputs.clone()
            labels[labels == tokenizer.pad_token_id] = -100  # Ignore padding

            outputs = model(inputs, labels=labels)
            loss = outputs.loss  # Model's loss is already averaged over tokens

            total_loss += loss.item()
            total_tokens += 1  # Count sequences instead of multiplying by length

    avg_loss = total_loss / total_tokens
    perplexity = torch.exp(torch.tensor(avg_loss))  # Compute perplexity (e^loss)
    return perplexity.item()

# Run evaluation
print("Evaluating model on WikiText-2...")
perplexity_score = compute_perplexity(model, input_ids)
print(f"Llama 3.2 Perplexity on WikiText-2: {perplexity_score:.2f}")
