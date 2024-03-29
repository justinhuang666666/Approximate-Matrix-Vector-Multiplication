import numpy as np

def generate_random_vector(length):
    """
    Generate a random vector of specified length with values between -1 and 1.
    
    Parameters:
    - length: The length of the random vector.
    
    Returns:
    - random_vector: The generated random vector.
    """
    random_vector = np.random.uniform(-1, 1, length)
    return random_vector

def pad_vector(vector, unroll_factor):
    """
    Pad the input vector so it has a length divisible by unroll_factor.
    
    Parameters:
    - vector: The input vector to be padded.
    - unroll_factor: The factor by which the length of the vector should be divisible.
    
    Returns:
    - padded_vector: The padded vector.
    """
    current_length = len(vector)
    pad_length = (unroll_factor - current_length % unroll_factor) % unroll_factor
    padded_vector = np.pad(vector, (0, pad_length), mode='constant', constant_values=0)
    return padded_vector


