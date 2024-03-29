import numpy as np

def mean_square_error_vector(vector1, vector2):
    """
    Calculates the Mean Squared Error (MSE) between two vectors.

    Parameters:
    - vector1: First input vector.
    - vector2: Second input vector, must be the same length as vector1.

    Returns:
    - MSE: The mean squared error between the two input vectors.
    """
    
    # Check if the input vectors have the same length
    if vector1.shape != vector2.shape:
        raise ValueError("The input vectors must have the same length.")
    
    # Calculate the element-wise difference, square it, and then compute the mean
    diff_squared = (vector1 - vector2) ** 2
    MSE = np.mean(diff_squared)
    
    return MSE

def mean_square_error_matrix(matrix1, matrix2):
    """
    Calculates the Mean Squared Error (MSE) between two matrices.

    Parameters:
    - matrix1: First input matrix.
    - matrix2: Second input matrix, must be the same size as matrix1.

    Returns:
    - MSE: The mean squared error between the two input matrices.
    """
    
    # Check if the input matrices have the same size
    if matrix1.shape != matrix2.shape:
        raise ValueError("The input matrices must have the same size.")
    
    # Calculate the element-wise difference, square it, and then compute the mean
    diff_squared = (matrix1 - matrix2) ** 2
    MSE = np.mean(diff_squared)
    
    return MSE

    
def mean_square_error_array(array1, array2):
    """
    Calculates the Mean Squared Error (MSE) between two matrices.

    Parameters:
    - array1: First input array of matrices.
    - array2: Second input array of matrices, must be the same size as array1.

    Returns:
    - MSE: The mean squared error between the two input arrays.
    """
    # Check if the input array have the same size
    if len(array1) != len(array2):
        raise ValueError("The arrays must have the same size.")
    
    # Check if the input matrices within the arrays have the same size
    if any(a1.shape != a2.shape for a1, a2 in zip(array1, array2)):
        raise ValueError("All matrices within the arrays must have the same size.")
    
    # Calculate MSE for each corresponding matrix pair and take the mean of these errors
    MSE = [np.mean((a1 - a2) ** 2) for a1, a2 in zip(array1, array2)]
    
    return MSE

def mean_square_error_array1(array1, array2):
    """
    Calculates the Mean Squared Error (MSE) between two matrices.

    Parameters:
    - array1: First input array of matrices.
    - array2: Second input array of matrices, must be the same size as array1.

    Returns:
    - MSE: The mean squared error between the two input arrays.
    """
    # Check if the input array have the same size
    if len(array1) != len(array2):
        raise ValueError("The arrays must have the same size.")
    
    # Check if the input matrices within the arrays have the same size
    if any(a1.shape != a2.shape for a1, a2 in zip(array1, array2)):
        raise ValueError("All matrices within the arrays must have the same size.")
    
    # Calculate MSE for each corresponding matrix pair and take the mean of these errors
    MSE = [np.mean((a1 - a2) ** 2) for a1, a2 in zip(array1, array2)]
    
    return np.mean(MSE)