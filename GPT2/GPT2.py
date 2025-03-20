import torch
import torch.nn as nn
from torch.utils.data import DataLoader
from transformers import GPT2Tokenizer, GPT2LMHeadModel
from datasets import load_dataset
from tqdm import tqdm

# Check if GPU is available
device = "cuda" if torch.cuda.is_available() else "cpu"

# Load GPT-2 XL model and tokenizer
print("Loading GPT-2 XL model...")
tokenizer = GPT2Tokenizer.from_pretrained("gpt2-xl")
model = GPT2LMHeadModel.from_pretrained("gpt2-xl")
model.to(device)
model.eval()

# Ensure the tokenizer has a pad token
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token  # Use EOS as padding token

# Load WikiText-2 dataset
print("Loading WikiText-2 dataset...")
dataset = load_dataset("wikitext", "wikitext-2-raw-v1", split="test")

# Tokenize dataset
def preprocess_function(examples):
    return tokenizer(
        examples["text"],
        truncation=True,
        padding="max_length",
        max_length=512,  # Adjust as needed
        return_tensors="pt"
    )

print("Tokenizing dataset...")
tokenized_dataset = dataset.map(preprocess_function, batched=True)
tokenized_dataset.set_format(type="torch", columns=["input_ids", "attention_mask"])

# Create DataLoader
test_dataloader = DataLoader(tokenized_dataset, batch_size=4, shuffle=False)  # Adjust batch size if needed

# Function to evaluate perplexity
def evaluate_perplexity(model, dataloader):
    model.eval()
    total_loss = 0
    total_length = 0
    loss_fn = nn.CrossEntropyLoss(ignore_index=tokenizer.pad_token_id, reduction="sum")  # Ignore padding tokens

    with torch.no_grad():
        for batch in tqdm(dataloader, desc="Evaluating Perplexity"):
            input_ids = batch["input_ids"].to(device)
            attention_mask = batch["attention_mask"].to(device)

            # Labels should be the same as input_ids but shifted
            labels = input_ids.clone()

            # Forward pass
            outputs = model(input_ids, attention_mask=attention_mask, labels=labels)
            logits = outputs.logits

            # Shift so that tokens < n predict token n
            shift_logits = logits[..., :-1, :].contiguous()
            shift_labels = labels[..., 1:].contiguous()

            # Compute loss
            loss = loss_fn(shift_logits.view(-1, shift_logits.size(-1)), shift_labels.view(-1))

            total_loss += loss.item()
            total_length += attention_mask.sum().item()  # Count total valid tokens

    # Calculate perplexity
    avg_loss = total_loss / total_length
    perplexity = torch.exp(torch.tensor(avg_loss))

    return perplexity.item()

# Evaluate perplexity
print("Evaluating model on WikiText-2...")
perplexity = evaluate_perplexity(model, test_dataloader)
print(f"GPT-2 XL Perplexity on WikiText-2: {perplexity:.2f}")
