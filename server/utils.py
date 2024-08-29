import torch
from transformers import MarianMTModel, MarianTokenizer

import json

import nltk
from nltk.translate.bleu_score import corpus_bleu, SmoothingFunction
nltk.download('punkt', download_dir='.')

def compute_bleu_score(model,tokenizer,source_texts,target_texts):
    # Tokenize and generate translations
    generated_texts = []
    for source in source_texts:
        inputs = tokenizer.encode(source, return_tensors='pt', max_length=512, truncation=True)
        with torch.no_grad():
            translated_tokens = model.generate(inputs, max_length=512, num_beams=5, early_stopping=True)
        generated_text = tokenizer.decode(translated_tokens[0], skip_special_tokens=True)
        generated_texts.append(generated_text)

    # Tokenize the reference and generated texts
    tokenized_references = [[nltk.word_tokenize(text)] for text in target_texts]
    tokenized_generated_texts = [nltk.word_tokenize(text) for text in generated_texts]

    # Calculate BLEU score
    smoothie = SmoothingFunction().method4
    bleu_score = corpus_bleu(tokenized_references, tokenized_generated_texts, smoothing_function=smoothie)

    return bleu_score*100


def compute_character_fscore(model, tokenizer, source_texts, target_texts):
    """
    Compute the character-level F1 score of a language model given source and target texts.
    
    Parameters:
    - model: The pre-trained language model (e.g., from Hugging Face transformers).
    - source_texts: A list of input texts to provide context for the model.
    - target_texts: A list of texts that the model is expected to predict.
    - tokenizer: The tokenizer corresponding to the model.
    
    Returns:
    - f1_score: The character-level F1 score of the model on the given texts.
    """
    
    # Ensure the model is in evaluation mode
    model.eval()
    
    total_precision = 0.0
    total_recall = 0.0
    total_f1 = 0.0
    num_samples = len(source_texts)
    
    # Iterate over the source and target texts
    for source_text, target_text in zip(source_texts, target_texts):
        
        # Encode the input text
        inputs = tokenizer(source_text, return_tensors='pt')

        # Generate model outputs
        with torch.no_grad():
            outputs = model.generate(**inputs)
        
        # Decode the generated text
        predicted_text = tokenizer.decode(outputs[0], skip_special_tokens=True)

        # Calculate true positives, false positives, and false negatives
        target_chars = list(target_text)
        predicted_chars = list(predicted_text)
        
        true_positives = sum(1 for c1, c2 in zip(target_chars, predicted_chars) if c1 == c2)
        false_positives = len(predicted_chars) - true_positives
        false_negatives = len(target_chars) - true_positives

        # Calculate precision, recall, and F1 score for the current sample
        precision = true_positives / (true_positives + false_positives) if (true_positives + false_positives) > 0 else 0
        recall = true_positives / (true_positives + false_negatives) if (true_positives + false_negatives) > 0 else 0
        f1 = (2 * precision * recall) / (precision + recall) if (precision + recall) > 0 else 0
        
        total_precision += precision
        total_recall += recall
        total_f1 += f1

    # Average F1 score across all samples
    avg_f1_score = total_f1 / num_samples
    
    return avg_f1_score

def extract_weight_array(layer):
    atten_block = layer.self_attn
    
    k_weight = atten_block.k_proj.weight.detach().clone().numpy()
    v_weight = atten_block.v_proj.weight.detach().clone().numpy()
    q_weight = atten_block.q_proj.weight.detach().clone().numpy()

    return [k_weight,v_weight,q_weight]

def set_layer_weight(layer,atten_block_weight_array,quantizer=False,precision=32):
    layer.self_attn.k_proj.weight.data = torch.tensor(atten_block_weight_array[0],dtype=torch.float32)
    layer.self_attn.v_proj.weight.data = torch.tensor(atten_block_weight_array[1],dtype=torch.float32)
    layer.self_attn.q_proj.weight.data = torch.tensor(atten_block_weight_array[2],dtype=torch.float32)

    return layer

