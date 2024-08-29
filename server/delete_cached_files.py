from datasets import load_dataset
import json

# Load the WMT14 English-German dataset
dataset = load_dataset('wmt19', 'de-en', split='validation')

load_dataset('wmt19', 'de-en', split='validation').cleanup_cache_files()