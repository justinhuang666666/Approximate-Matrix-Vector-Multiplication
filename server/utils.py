import torch
from transformers import MarianMTModel, MarianTokenizer

import json
import os
import sys

import numpy as np

import pandas as pd

import torch

import nltk
from nltk.translate.bleu_score import corpus_bleu, SmoothingFunction
nltk.download('punkt_tab')

# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.dirname(current_dir)

# # Add utility directories dynamically
# sys.path.append(os.path.join(parent_dir, 'iterative_approximation'))
# from iterative_approximation_gpu import *

def to_device(tensor, device):
    return tensor.to(device) if tensor.device != device else tensor


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
    vector1 = vector1.to(device, dtype=torch.float32)
    vector2 = vector2.to(device, dtype=torch.float32)
    
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
    matrix1 = matrix1.to(device, dtype=torch.float32)
    matrix2 = matrix2.to(device, dtype=torch.float32)
    
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
    array1 = [a.to(device, dtype=torch.float32) for a in array1]
    array2 = [a.to(device, dtype=torch.float32) for a in array2]
    
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
    array1 = [a.to(device, dtype=torch.float32) for a in array1]
    array2 = [a.to(device, dtype=torch.float32) for a in array2]
    
    # Calculate MSE for each corresponding matrix pair and take the mean of these errors
    MSE = [(a1 - a2).pow(2).mean() for a1, a2 in zip(array1, array2)]
    
    return torch.mean(torch.stack(MSE)).item()  # Return as a Python float

def cal_absolute_error(arr1, arr2):
    """
    Calculate absolute errors between corresponding matrices in two arrays.

    Parameters:
    - arr1: List of PyTorch tensors (matrices) on GPU.
    - arr2: List of PyTorch tensors (matrices) on GPU.

    Returns:
    - errors: List of absolute errors between corresponding matrices.
    """
    # Check if inputs are of the same length
    if len(arr1) != len(arr2):
        raise ValueError("Both arrays must have the same length.")

    # Ensure all tensors are on the GPU
    arr1 = [tensor.to('cuda') for tensor in arr1]
    arr2 = [tensor.to('cuda') for tensor in arr2]

    # Calculate absolute errors
    errors = []
    for tensor1, tensor2 in zip(arr1, arr2):
        # Calculate absolute error
        error = torch.nn.functional.l1_loss(tensor1, tensor2, reduction='mean')
        # Append error to the result list
        errors.append(error.item())

    return errors

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

def set_layer_weight(layer,atten_block_weight_array):
    # Set the weights directly, using clone().detach() to avoid computation graph issues
    layer.self_attn.k_proj.weight.data = atten_block_weight_array[0].clone().detach().to(torch.float32)
    layer.self_attn.v_proj.weight.data = atten_block_weight_array[1].clone().detach().to(torch.float32)
    layer.self_attn.q_proj.weight.data = atten_block_weight_array[2].clone().detach().to(torch.float32)

    return layer



def divide_matrix(matrix, tile_size):
    """
    Divide a square matrix into smaller square matrices of given tile size and run on GPU.

    Args:
        matrix (torch.Tensor): The input square matrix.
        tile_size (int): The size of the smaller square matrices.
        device (str): The device to run the computation ('cuda' for GPU, 'cpu' for CPU).

    Returns:
        List of torch.Tensor: A list of smaller square matrices on the specified device.

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

    # Move matrix to the specified device (GPU or CPU)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    matrix = matrix.to(device)

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


def merge_matrices(smaller_matrices, tile_size):
    """
    Merge smaller square matrices into a larger square matrix.

    Args:
        smaller_matrices (List[torch.Tensor]): A list of smaller square matrices.
        tile_size (int): The size of each smaller square matrix.
        device (str): The device to run the computation ('cuda' for GPU, 'cpu' for CPU).

    Returns:
        torch.Tensor: The merged larger square matrix on the specified device.

    Raises:
        ValueError: If the smaller matrices cannot be combined into a square matrix.
    """
    # Calculate the number of tiles along each dimension
    num_tiles = int(len(smaller_matrices) ** 0.5)

    # Ensure the list of smaller matrices forms a square layout
    if num_tiles * num_tiles != len(smaller_matrices):
        raise ValueError("The number of smaller matrices does not form a perfect square.")

    # Calculate the size of the larger matrix
    n = num_tiles * tile_size

    # Initialize the larger matrix on the specified device
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    merged_matrix = torch.zeros((n, n), device=device)

    # Merge the smaller matrices into the larger matrix
    for i in range(num_tiles):
        for j in range(num_tiles):
            # Place each smaller matrix in its correct position in the larger matrix
            merged_matrix[i*tile_size:(i+1)*tile_size, j*tile_size:(j+1)*tile_size] = smaller_matrices[i*num_tiles + j]

    return merged_matrix

def eval(tiled_layers, tile_size, model, tokenizer, source_texts, target_texts, device='cuda'):
    """
    Evaluate the performance of a model with tiled layers of approximated submatrices.

    Args:
        tiled_layers (list): List of tiled layer objects containing approximated submatrices.
        tile_size (int): Size of the tile used in the approximation.
        model: The model object containing the encoder with layers to set weights.
        tokenizer: The tokenizer used for encoding the source and target texts.
        source_texts (list): List of source texts for BLEU and F-score evaluation.
        target_texts (list): List of target texts for BLEU and F-score evaluation.
        device (str): Device to use for evaluation ('cuda' or 'cpu').

    Returns:
        pd.DataFrame: DataFrame containing the evaluation metrics.
    """
    mse_array = []
    mse_check_array = []
    compression_ratio_array = []
    memory_footprint = 0

    absolute_error = []
    absolute_error_records = []

    # Loop to merge approximated submatrices back into full matrices
    for i in range(len(tiled_layers)):
        approximated_matrix_array = []
        layer_absolute_error = []
        print("number of layers",len(tiled_layers))
        for j in range(len(tiled_layers[i])):  # Ensure correct sublist length
            print("number of weights",len(tiled_layers[i]))
            approximated_submatrix_array = tiled_layers[i][j].current_reconstructed_weight_array
            error = cal_absolute_error(tiled_layers[i][j].original_weight_array,tiled_layers[i][j].current_reconstructed_weight_array)
            layer_absolute_error.append(error)
            print("errors",len(error))
            # Merge submatrices back into the original sized matrix
            approximated_matrix = merge_matrices(approximated_submatrix_array, tile_size)

            # Append the merged matrix to the array
            approximated_matrix_array.append(approximated_matrix)
            
            memory_footprint += tiled_layers[i][j].memory_footprint_compressed
            
        mse_array.append(mean_square_error_array1(extract_weight_array(model.model.encoder.layers[i]),approximated_matrix_array))
        # Set the approximated matrices as weights for the model layer
        set_layer_weight(model.model.encoder.layers[i], approximated_matrix_array)
        absolute_error.append(layer_absolute_error)

    # Calculate overall metrics
    tile_size = tiled_layers[i][j].R
    num_step = tiled_layers[-1][-1].steps
    mse = sum(mse_array) / len(mse_array) if mse_array else 0
    memory_footprint /= 8  # Convert bits to bytes
    compression_ratio = tiled_layers[i][j].compression_ratio()

    # Compute BLEU and F-score
    bleu = 0 #compute_bleu_score(device, model, tokenizer, source_texts, target_texts)
    fscore = 0 #compute_character_fscore(device, model, tokenizer, source_texts, target_texts)

    # Compile results into a DataFrame
    results = {
        'Tile Size': [tile_size],
        'Steps': [num_step],
        'MSE': [mse],
        'Memory Footprint (Bytes)': [memory_footprint],
        'Compression Ratio': [compression_ratio],
        'BLEU Score': [bleu],
        'Character F-score': [fscore]
    }

    for layer_idx, layer_error in enumerate(absolute_error):
        for matrix_idx, matrix_error in enumerate(layer_error):
            for tile_idx, tile_error in enumerate(matrix_error):
                absolute_error_records.append({
                    'Tile Size': [tile_size],
                    'Steps': [num_step],
                    'Layer': layer_idx,  # Assuming layers are 1-indexed
                    'Matrix': matrix_idx,   # Assuming tiles are 1-indexed
                    'Tile': tile_idx,
                    'Absolute Error': tile_error
                })

    metrics_dataframe = pd.DataFrame(results)
    absolute_error_dataframe = pd.DataFrame(absolute_error_records)
    
    return metrics_dataframe,absolute_error_dataframe




