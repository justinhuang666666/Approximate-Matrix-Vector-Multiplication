import os
import torch
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(device)

from datasets import load_dataset

from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers import Trainer, TrainingArguments
from transformers import DataCollatorForLanguageModeling

from torch.utils.data import DataLoader
import torch.nn as nn

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "3"


# Load the pre-trained GPT-2 model and tokenizer
model_name = "gpt2-xl"
model = AutoModelForCausalLM.from_pretrained(model_name).to(device)
tokenizer = AutoTokenizer.from_pretrained(model_name)

# Set padding token
tokenizer.pad_token = tokenizer.eos_token
model.config.pad_token_id = model.config.eos_token_id

# def generate_text(model, tokenizer, prompt, max_length=100):
#     """
#     Generate text using GPT-2.
#     :param model: Pretrained GPT-2 model
#     :param tokenizer: GPT-2 tokenizer
#     :param prompt: Input text prompt
#     :param max_length: Maximum length of generated text
#     """

#     # Tokenize the input prompt
#     inputs = tokenizer(prompt, return_tensors="pt").to(device)
#     input_ids = inputs.input_ids
#     attention_mask = inputs.attention_mask

#     # Generate text tokens
#     gen_tokens = model.generate(
#         input_ids=input_ids,
#         attention_mask=attention_mask,
#         max_length=max_length,
#         num_return_sequences=1,  # Generate one sequence
#         temperature=0.7,  # Adjust for more randomness
#         top_k=50,  # Use top-k sampling
#         top_p=0.9,  # Use nucleus sampling
#         do_sample=True  # Enable sampling
#     )

#     # Decode generated tokens to text
#     gen_text = tokenizer.decode(gen_tokens[0], skip_special_tokens=True)
#     print("Generated Text:\n", gen_text)


#     # Example usage
# generate_text(model, tokenizer, "GPT-2 is a language model based on transformers developed by OpenAI.", max_length=100)

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

# Test DataLoader
# for batch in train_dataloader:
#     print("Input IDs Shape:", batch['input_ids'].shape)
#     print("Attention Mask Shape:", batch['attention_mask'].shape)
#     print("Labels Shape:", batch['labels'].shape)
#     break

# print("DataLoader is working correctly!")

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

perplexity = evaluate_perplexity(model, test_dataloader)
print(f"Initial perplexity: {perplexity}")

import os
os.environ["WANDB_DISABLED"] = "true"  # Disable W&B logging

# Set up training arguments
training_args = TrainingArguments(
    output_dir="/home/jh4420/model/gpt2-xl-wikitext-2",
    overwrite_output_dir=True,
    num_train_epochs=3,
    per_device_train_batch_size=8,
    per_device_eval_batch_size=8,
    eval_steps=400,
    save_steps=800,
    warmup_steps=500,
    prediction_loss_only=True,
    evaluation_strategy="epoch",  # Report validation and training loss every epoch
    logging_dir="./logs",  # Directory for logging
    logging_strategy="epoch",  # Log training/validation loss at the end of each epoch
)

# Create a Trainer object
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=tokenized_datasets_train,
    eval_dataset=tokenized_datasets_valid,
    tokenizer=tokenizer,
    data_collator=data_collator,
)

# Train the model
trainer.train()

# Save the fine-tuned model
trainer.save_model()

# Load the fine-tuned model
model_finetuned = AutoModelForCausalLM.from_pretrained("/home/jh4420/model/gpt2-xl-wikitext-2").to(device)

# Evaluate perplexity on the validation dataset
perplexity = evaluate_perplexity(model_finetuned, test_dataloader)
print(f"Fine-tuned perplexity: {perplexity}")