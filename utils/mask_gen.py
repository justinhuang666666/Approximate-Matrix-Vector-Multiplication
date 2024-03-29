import numpy as np

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