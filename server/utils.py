import torch
from transformers import MarianMTModel, MarianTokenizer

import json

import numpy as np

import nltk
from nltk.translate.bleu_score import corpus_bleu, SmoothingFunction
nltk.download('punkt_tab')

def to_device(tensor, device):
    return tensor.to(device) if tensor.device != device else tensor


# Compute BLEU score
def compute_bleu_score(device, model, tokenizer, source_texts, target_texts):
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
    return bleu_score*100

def compute_character_fscore(device, model, tokenizer, source_texts, target_texts):
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
    # Move the layer to GPU if available
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    layer = layer.to(device)

    # Access the attention block
    atten_block = layer.self_attn

    # Detach and clone weights, staying in PyTorch and keeping tensors on GPU
    k_weight = atten_block.k_proj.weight.detach().clone().to(device)
    v_weight = atten_block.v_proj.weight.detach().clone().to(device)
    q_weight = atten_block.q_proj.weight.detach().clone().to(device)

    return [k_weight, v_weight, q_weight]

def set_layer_weight(layer,atten_block_weight_array,quantizer=False,precision=32):
    layer.self_attn.k_proj.weight.data = torch.tensor(atten_block_weight_array[0],dtype=torch.float32)
    layer.self_attn.v_proj.weight.data = torch.tensor(atten_block_weight_array[1],dtype=torch.float32)
    layer.self_attn.q_proj.weight.data = torch.tensor(atten_block_weight_array[2],dtype=torch.float32)

    return layer

def divide_matrix(matrix, tile_size):
    """
    Divide a square matrix into smaller square matrices of given tile size.

    Args:
        matrix (numpy.ndarray): The input square matrix.
        tile_size (int): The size of the smaller square matrices.

    Returns:
        List of numpy.ndarray: A list of smaller square matrices.

    Raises:
        ValueError: If the matrix size is not divisible by the tile size.
    """
    # Check if the matrix is square
    if matrix.shape[0] != matrix.shape[1]:
        raise ValueError("The input matrix must be square.")

    # Check if the matrix size is divisible by tile_size
    n = matrix.shape[0]
    if n % tile_size != 0:
        raise ValueError(f"The matrix size ({n}) is not divisible by the tile size ({tile_size}).")

    # Number of tiles along each dimension
    num_tiles = n // tile_size

    # Create a list to store the smaller matrices
    smaller_matrices = []

    # Divide the matrix into smaller matrices
    for i in range(num_tiles):
        for j in range(num_tiles):
            # Extract the sub-matrix of size tile_size x tile_size
            sub_matrix = matrix[i*tile_size:(i+1)*tile_size, j*tile_size:(j+1)*tile_size]
            smaller_matrices.append(sub_matrix)

    return smaller_matrices

import torch

def mean_square_error_vector(vector1, vector2):
    """
    Calculates the Mean Squared Error (MSE) between two vectors using GPU.

    Parameters:
    - vector1: First input vector.
    - vector2: Second input vector, must be the same length as vector1.

    Returns:
    - MSE: The mean squared error between the two input vectors.
    """
    # Check if the input vectors have the same length
    if vector1.shape != vector2.shape:
        raise ValueError("The input vectors must have the same length.")
    
    # Move tensors to GPU if available
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    vector1 = torch.tensor(vector1, device=device, dtype=torch.float32)
    vector2 = torch.tensor(vector2, device=device, dtype=torch.float32)
    
    # Calculate the element-wise difference, square it, and then compute the mean
    diff_squared = (vector1 - vector2) ** 2
    MSE = diff_squared.mean()
    
    return MSE.item()  # Return as a Python float

def mean_square_error_matrix(matrix1, matrix2):
    """
    Calculates the Mean Squared Error (MSE) between two matrices using GPU.

    Parameters:
    - matrix1: First input matrix.
    - matrix2: Second input matrix, must be the same size as matrix1.

    Returns:
    - MSE: The mean squared error between the two input matrices.
    """
    # Check if the input matrices have the same size
    if matrix1.shape != matrix2.shape:
        raise ValueError("The input matrices must have the same size.")
    
    # Move tensors to GPU if available
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    matrix1 = torch.tensor(matrix1, device=device, dtype=torch.float32)
    matrix2 = torch.tensor(matrix2, device=device, dtype=torch.float32)
    
    # Calculate the element-wise difference, square it, and then compute the mean
    diff_squared = (matrix1 - matrix2) ** 2
    MSE = diff_squared.mean()
    
    return MSE.item()

def mean_square_error_array(array1, array2):
    """
    Calculates the Mean Squared Error (MSE) between two arrays of matrices using GPU.

    Parameters:
    - array1: First input array of matrices.
    - array2: Second input array of matrices, must be the same size as array1.

    Returns:
    - MSE: The mean squared error between the two input arrays.
    """
    # Check if the input arrays have the same size
    if len(array1) != len(array2):
        raise ValueError("The arrays must have the same size.")
    
    # Check if the input matrices within the arrays have the same size
    if any(a1.shape != a2.shape for a1, a2 in zip(array1, array2)):
        raise ValueError("All matrices within the arrays must have the same size.")
    
    # Move tensors to GPU if available
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    array1 = [torch.tensor(a, device=device, dtype=torch.float32) for a in array1]
    array2 = [torch.tensor(a, device=device, dtype=torch.float32) for a in array2]
    
    # Calculate MSE for each corresponding matrix pair and return the list of errors
    MSE = [(a1 - a2).pow(2).mean().item() for a1, a2 in zip(array1, array2)]
    
    return MSE

def mean_square_error_array1(array1, array2):
    """
    Calculates the Mean Squared Error (MSE) between two arrays of matrices using GPU.

    Parameters:
    - array1: First input array of matrices.
    - array2: Second input array of matrices, must be the same size as array1.

    Returns:
    - MSE: The mean squared error between the two input arrays.
    """
    # Check if the input arrays have the same size
    if len(array1) != len(array2):
        raise ValueError("The arrays must have the same size.")
    
    # Check if the input matrices within the arrays have the same size
    if any(a1.shape != a2.shape for a1, a2 in zip(array1, array2)):
        raise ValueError("All matrices within the arrays must have the same size.")
    
    # Move tensors to GPU if available
    device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
    array1 = [torch.tensor(a, device=device, dtype=torch.float32) for a in array1]
    array2 = [torch.tensor(a, device=device, dtype=torch.float32) for a in array2]
    
    # Calculate MSE for each corresponding matrix pair and take the mean of these errors
    MSE = [(a1 - a2).pow(2).mean() for a1, a2 in zip(array1, array2)]
    
    return torch.mean(torch.tensor(MSE, device=device)).item()  # Return as a Python float

def create_mask_vector(v1, NZ, Tc):
    """
    Creates a mask vector based on the input vector v1, the number of non-zero elements NZ,
    and the group size Tc.
    
    Parameters:
    - v1: The input vector from the SVD (v1 vector of the rank-1 approximation).
    - NZ: The number of non-zero elements to keep in the mask.
    - Tc: The size of each group in the vector to consider for masking.

    Returns:
    - fi: The final mask vector with repeated elements based on the compressed mask.
    - compressed_fi: The compressed mask vector before repetition.
    """
    
    # Validate inputs
    if NZ > len(v1) / Tc:
        raise ValueError('NZ cannot be larger than the number of elements in v1 divided by Tc')
    
    # Initialize the compressed mask vector
    compressed_fi = np.zeros(len(v1) // Tc)
    
    # Group v1 into parts with length Tc
    v1_grouped = np.reshape(v1, (-1, Tc))
    
    # Compute the mean of each group
    group_means = np.mean(np.abs(v1_grouped), axis=1)
    
    # Find the indices of the NZ largest group means
    selected_indices = np.argsort(group_means)[-NZ:]
    
    # Set the corresponding elements in the compressed mask to 1
    compressed_fi[selected_indices] = 1
    
    # Repeat each element in compressed_fi Tc times to create fi
    fi = np.repeat(compressed_fi, Tc)
    
    # Type cast fi and compressed_fi to int arrays
    fi = fi.astype(int)
    compressed_fi = compressed_fi.astype(int)
    
    return fi, compressed_fi

