import torch
from transformers import MarianMTModel, MarianTokenizer
import json
import nltk
from nltk.translate.bleu_score import corpus_bleu, SmoothingFunction

from utils import *

# Load the tokenizer and model
model_name = "Helsinki-NLP/opus-mt-en-de"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()

# Check if GPU is available and move model to GPU if possible
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

# Load the JSON file
with open('translations.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Extract the source and target texts
source_texts = data['source_texts']
target_texts = data['target_texts']

# Ensure nltk is installed
nltk.download('punkt')

def compute_bleu_score(model, source_texts, target_texts):
    # Tokenize and generate translations
    generated_texts = []
    for source in source_texts:
        # Move the inputs to the GPU
        inputs = tokenizer.encode(source, return_tensors='pt', max_length=512, truncation=True).to(device)
        
        with torch.no_grad():
            # Generate translation and move the output back to CPU if needed
            translated_tokens = model.generate(inputs, max_length=512, num_beams=5, early_stopping=True)
        generated_text = tokenizer.decode(translated_tokens[0], skip_special_tokens=True)
        generated_texts.append(generated_text)

    # Tokenize the reference and generated texts
    tokenized_references = [[nltk.word_tokenize(text)] for text in target_texts]
    tokenized_generated_texts = [nltk.word_tokenize(text) for text in generated_texts]

    # Calculate BLEU score
    smoothie = SmoothingFunction().method4
    bleu_score = corpus_bleu(tokenized_references, tokenized_generated_texts, smoothing_function=smoothie)

    return bleu_score * 100

# Compute BLEU score
baseline_bleu = compute_bleu_score(model, source_texts, target_texts)

print(baseline_bleu)
