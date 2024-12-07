import random
from datasets import load_dataset
import json

# Load the WMT19 English-German dataset
dataset = load_dataset('wmt19', 'de-en', split='validation')

# Define the sample size
sample_size = 100  # Adjust as needed

# Use a dynamic random seed
dynamic_seed = random.randint(0, 10000)
sampled_dataset = dataset.shuffle(seed=dynamic_seed).select(range(sample_size))

# Prepare the references and translations
source_texts = [item['en'] for item in sampled_dataset['translation']]
target_texts = [item['de'] for item in sampled_dataset['translation']]

# Create a dictionary to store the texts
data = {
    'source_texts': source_texts,
    'target_texts': target_texts
}

# Save the sampled data to a JSON file
output_file = 'translations1.json'
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)

print(f"Sampled dataset saved to {output_file} with seed {dynamic_seed}")