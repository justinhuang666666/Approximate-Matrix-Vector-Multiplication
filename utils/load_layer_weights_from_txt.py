import numpy as np

def load_layer_weights_from_txt(layer, filename):
    with open(filename, 'r') as f:
        weight_strings = f.read().strip().split('\n\n')  # Split at double newline to separate weight arrays
        weight_arrays = [np.loadtxt(weight.split('\n')) for weight in weight_strings]  # Convert to NumPy arrays

    # Reshape and set weights in the layer
    original_shapes = [w.shape for w in layer.get_weights()]  # Save original shapes
    reshaped_weights = [weight.reshape(shape) for weight, shape in zip(weight_arrays, original_shapes)]
    layer.set_weights(reshaped_weights)
