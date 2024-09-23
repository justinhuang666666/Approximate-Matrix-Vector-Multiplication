import torch
import os
import sys

def quant_svd(u, s, v, quant_scheme: "quant.QuantScheme" = None):

    # Ensure that u, s, and v are quantized using the provided quantization scheme
    input_type = u.dtype
    device = u.device

    print(u)
    print(s)
    print(v)

    qu = quant_scheme.weight.quant(u)    # Quantize U (left singular vector)
    qv = quant_scheme.weight.quant(v)    # Quantize V (right singular vector)
    qs = quant_scheme.weight.quant(s)
    # Adjust the dimensions of S to match the dimensions of qu and qv
    S = torch.diag(torch.full((qu.size(0),), qs)).to(device) 
    
    print(qu)
    print(qv)
    print(S)

    qreconstructed = S.mv(qu).vv(qv.t()).to(input_type)

    return qreconstructed

# import argparse
# import warnings
# # Suppress all warnings
# warnings.filterwarnings("ignore")

# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.dirname(current_dir)

# # Add utility directories dynamically
# sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
# from quant import *

# # Create a mock argument namespace to simulate input arguments
# args_int = argparse.Namespace()

# wl = 8
# frac = 4
# symmetric = True
# round_mode = 'nearest'

# # Define the quantization scheme dictionary with IntQuant settings
# args_int.quant_scheme = {
#     "act": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "weight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "bact": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "bweight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "goact": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "goweight": {"number_type": "int", "wl": wl, "fl": frac, "clamp": True, "symmetric": symmetric, "round_mode": round_mode},
#     "same_input": True,
#     "same_weight": True
# }

# # Create the quantization scheme using the from_args method
# quant_scheme_int = QuantScheme.from_args(args_int)

# # Test case setup
# def test_quant_svd():
#     # Generate random tensors for u and v (vectors), and s as a scalar
#     u = torch.randn(2, 1)  # A 4x1 vector
#     v = torch.randn(2, 1)  # A 4x1 vector
#     s = torch.tensor(1.12418129739)  # A scalar value

#     print('U:',u)
#     print('V:',v)
#     print('S:',s)

#     # Perform quantized SVD reconstruction
#     qreconstructed = quant_svd(u, s, v, quant_scheme_int)

#     # Display the reconstructed quantized matrix
#     print("Quantized Reconstructed Matrix:")
#     print(qreconstructed)
#     print(qreconstructed.dtype)



# test_quant_svd()