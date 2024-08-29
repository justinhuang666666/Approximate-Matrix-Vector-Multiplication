import torch
from transformers import MarianMTModel, MarianTokenizer

import json

import nltk
from nltk.translate.bleu_score import corpus_bleu, SmoothingFunction
nltk.download('punkt_tab')

def to_device(tensor, device):
    return tensor.to(device) if tensor.device != device else tensor


# Compute BLEU score
def compute_bleu_score(model, tokenizer, source_texts, target_texts, device):
    translations = []
    for text in source_texts:
        # Tokenize and encode, and move to device
        inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True).to(device)
        # Generate translation
        with torch.no_grad():
            outputs = model.generate(**inputs)
        # Decode generated ids to text
        translation = tokenizer.decode(outputs[0], skip_special_tokens=True)
        translations.append(translation)
    
    # Compute BLEU score
    bleu_score = nltk.translate.bleu_score.corpus_bleu(
        [[t.split()] for t in target_texts], [t.split() for t in translations]
    )
    return bleu_score

def compute_character_fscore(model, tokenizer, source_texts, target_texts, device):
    """
    Computes the character-level F-score between model translations and target texts.

    Args:
        model: The translation model.
        tokenizer: The tokenizer for the model.
        source_texts: List of source texts.
        target_texts: List of reference target texts.
        device: The device (CPU or GPU) to perform computations on.

    Returns:
        Character-level F-score.
    """
    # List to store generated translations
    translations = []

    for text in source_texts:
        # Tokenize and encode the text, then move to the specified device
        inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True).to(device)

        # Generate the translation and move the output to the device
        with torch.no_grad():
            outputs = model.generate(**inputs)

        # Decode the generated output ids to text
        translation = tokenizer.decode(outputs[0], skip_special_tokens=True)
        translations.append(translation)

    # Compute character-level precision, recall, and F-score
    precision_sum, recall_sum, f_score_sum = 0, 0, 0

    for translation, target in zip(translations, target_texts):
        # Ensure both strings are on the CPU for comparison
        translation_chars = list(translation)
        target_chars = list(target)

        # Compute character-level precision
        common_chars = set(translation_chars) & set(target_chars)
        precision = len(common_chars) / len(translation_chars) if len(translation_chars) > 0 else 0

        # Compute character-level recall
        recall = len(common_chars) / len(target_chars) if len(target_chars) > 0 else 0

        # Compute character-level F-score
        if precision + recall > 0:
            f_score = 2 * (precision * recall) / (precision + recall)
        else:
            f_score = 0

        # Accumulate scores
        precision_sum += precision
        recall_sum += recall
        f_score_sum += f_score

    # Average the scores over all examples
    avg_precision = precision_sum / len(translations)
    avg_recall = recall_sum / len(translations)
    avg_fscore = f_score_sum / len(translations)

    return avg_fscore

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

