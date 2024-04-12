import numpy as np

def set_layer_weight(layer,original_layer,weight_array):

    input_len = original_layer[0].shape[0]

    approximated_recurrent_kernel = np.hstack([weight_array[0][:,input_len:].T,weight_array[1][:,input_len:].T,weight_array[2][:,input_len:].T,weight_array[3][:,input_len:].T])
    approximated_kernel = np.hstack([weight_array[0][:,:input_len].T,weight_array[1][:,:input_len].T,weight_array[2][:,:input_len].T,weight_array[3][:,:input_len].T])

    approximated_weight = [approximated_kernel,approximated_recurrent_kernel,original_layer[2]]
    
    layer.set_weights(approximated_weight)