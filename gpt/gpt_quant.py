import os
import torch
import sys

import warnings
warnings.filterwarnings("ignore")

from datasets import load_dataset

from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers import Trainer, TrainingArguments
from transformers import DataCollatorForLanguageModeling

from torch.utils.data import DataLoader
import torch.nn as nn

import os

import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
from quant import *

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)

# Load the pre-trained GPT-2 model and tokenizer
model_name = "gpt2-xl"
model = AutoModelForCausalLM.from_pretrained(model_name).to(device)
tokenizer = AutoTokenizer.from_pretrained(model_name)

# Set padding token
tokenizer.pad_token = tokenizer.eos_token
model.config.pad_token_id = model.config.eos_token_id

# Load tokenizer
tokenizer = AutoTokenizer.from_pretrained("gpt2-xl")
tokenizer.pad_token = tokenizer.eos_token

# Load the WikiText dataset
dataset = load_dataset("wikitext", "wikitext-2-raw-v1")  # Using raw text version

# Select 10% of the dataset for training and validation and test
dataset_train = dataset["train"].select(range(len(dataset["train"]) // 10))
dataset_valid = dataset["validation"].select(range(len(dataset["validation"]) // 10))
dataset_test = dataset["test"].select(range(len(dataset["test"]) // 10))

# Function to tokenize dataset and set labels same as input_ids
def tokenize_function(examples):
    tokenized = tokenizer(examples["text"], padding="max_length", truncation=True, max_length=512)
    tokenized["labels"] = tokenized["input_ids"].copy()  # Labels must be the same as input_ids for causal LM
    return tokenized

# Tokenize the dataset
tokenized_datasets_train = dataset_train.map(tokenize_function, batched=True, remove_columns=["text"])
tokenized_datasets_valid = dataset_valid.map(tokenize_function, batched=True, remove_columns=["text"])
tokenized_datasets_test = dataset_test.map(tokenize_function, batched=True, remove_columns=["text"])

# Set format for PyTorch
tokenized_datasets_train.set_format("torch")
tokenized_datasets_valid.set_format("torch")
tokenized_datasets_test.set_format("torch")

# Create a DataCollator for training and validation
data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)  # mlm=False for causal LM

# Create DataLoaders
train_dataloader = DataLoader(tokenized_datasets_train, shuffle=True, batch_size=4, collate_fn=data_collator)
valid_dataloader = DataLoader(tokenized_datasets_valid, batch_size=4, collate_fn=data_collator)
test_dataloader = DataLoader(tokenized_datasets_test, batch_size=4, collate_fn=data_collator)

def evaluate_perplexity(model, dataloader):
    model.eval()
    total_loss = 0
    total_length = 0
    loss_fn = nn.CrossEntropyLoss(reduction='sum')  # Sum the loss over all tokens

    with torch.no_grad():
        for batch in dataloader:
            # Move batch to device (GPU if available)
            input_ids = batch["input_ids"].to(device)
            attention_mask = batch["attention_mask"].to(device)
            labels = batch["labels"].to(device)

            # Forward pass
            outputs = model(input_ids, attention_mask=attention_mask, labels=labels)
            logits = outputs.logits

            # Shift so that tokens < n predict n
            shift_logits = logits[..., :-1, :].contiguous()
            shift_labels = labels[..., 1:].contiguous()

            # Compute loss
            loss = loss_fn(shift_logits.view(-1, shift_logits.size(-1)), shift_labels.view(-1))

            total_loss += loss.item()
            total_length += attention_mask.sum().item()  # Count total valid tokens

    # Calculate perplexity
    perplexity = torch.exp(torch.tensor(total_loss / total_length))

    return perplexity.item()

# train_perplexity = evaluate_perplexity(model, train_dataloader)
# print(f"train data perplexity: {train_perplexity}")

# valid_perplexity = evaluate_perplexity(model, valid_dataloader)
# print(f"valid data perplexity: {valid_perplexity}")

test_perplexity = evaluate_perplexity(model, test_dataloader)
print(f"baseline perplexity: {test_perplexity}")

# Define possible values for wl, fl, symmetric, and round_mode
weight_word_lengths = [2, 4, 6, 8, 10, 12, 14, 16]
act_word_lengths = [4, 6, 8, 16]

results_list = []

print(model)
filter = type(model.model.encoder.layers[0])



# for act_wl in act_word_lengths:
#     for weight_wl in weight_word_lengths: 

#             # Replace with quantized model
#             int_model = replace_with_quantized(model, weight_wl, "range_based", act_wl, "range_based", filter)

#             # Compute BLEU score
#             perplexity = evaluate_perplexity(int_model, test_dataloader)

#             # Print BLEU score
#             print(f"GPT2-XL INT Perplexity for weight_wl={weight_wl} act_wl={act_wl}")
#             print("Range-Based: ", perplexity)

#             # Store the results
#             results_list.append({
#             "Weight Word Length": weight_wl,
#             "Activation Word Length": act_wl,
#             "Perplexity": perplexity,
#             "Compression Ratio": 32/weight_wl
#             })

# # Convert the list of dictionaries to a DataFrame
# results_df = pd.DataFrame(results_list)

# # Save results to a CSV file
# results_df.to_csv('quantization_inout_en_de3.csv', index=False)






