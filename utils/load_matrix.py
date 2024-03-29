import numpy as np

def load_matrix(file_path):
    # Initialize an empty list to store the matrix rows
    matrix = []

    # Open the file and read line by line
    with open(file_path, 'r') as file:
        for line in file:
            # Split the line into elements, convert each to float, and append to the matrix
            matrix.append([float(x) for x in line.strip().split()])

    # Convert the list of lists into a numpy array
    weight_matrix = np.array(matrix)

    return weight_matrix