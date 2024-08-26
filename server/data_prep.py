
from datasets import load_dataset
import json

# Load the WMT14 English-German dataset
dataset = load_dataset('wmt19', 'de-en', split='validation')

import random

# Sample a subset of the dataset for quicker evaluation
sample_size = 100  # Adjust as needed
sampled_dataset = dataset.shuffle(seed=42).select(range(sample_size))

# Prepare the references and generate translations
references = sampled_dataset['translation']
source_texts = [item['en'] for item in references]
target_texts = [item['de'] for item in references]

# Create a dictionary to store the texts
data = {
    'source_texts': source_texts,
    'target_texts': target_texts
}

# Save the dictionary to a JSON file
with open('translations.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)