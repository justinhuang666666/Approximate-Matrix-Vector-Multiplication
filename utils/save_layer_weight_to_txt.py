import numpy as np

def save_layer_weights_to_txt(layer, filename):
    weights = layer.get_weights()  # Get weights from the layer
    with open(filename, 'w') as f:
        for weight in weights:
            np.savetxt(f, weight.flatten())  # Save flattened weights to file
            f.write('\n')  # Newline to separate weight arrays (e.g., kernels and biases)
