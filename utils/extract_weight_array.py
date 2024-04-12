import numpy as np

def extract_weight_array(layer):
    kernel, recurrent_kernel, bias = layer.get_weights()

    I = np.hstack([kernel[:, :layer.units].T,recurrent_kernel[:, :layer.units].T])
    F = np.hstack([kernel[:, :layer.units].T,recurrent_kernel[:, :layer.units].T])
    O = np.hstack([kernel[:, :layer.units].T,recurrent_kernel[:, :layer.units].T])
    C = np.hstack([kernel[:, :layer.units].T,recurrent_kernel[:, :layer.units].T])
    return [I,F,O,C]
    