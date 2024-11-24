# from torch import nn
# from . import functional
# from . import quant 
import torch

import os
import sys

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(parent_dir)
from low_precision_utils import functional
from low_precision_utils import quant

def quant_svd(u,v,quant_scheme):

    qu = quant_scheme.weight.quant(u)
    qv = quant_scheme.weight.quant(v)

    reconstructed_matrix = torch.ger(qu, qv)

    print(f"iterative u: {u[0:5].numpy()}")
    print(f"iterative u quant: {qu[0:5].numpy()}")
    
    print(f"iterative v: {v[0:5].numpy()}")
    print(f"iterative v quant: {qv[0:5].numpy()}")

    return reconstructed_matrix

def quantisation(input,quant_scheme):
    quant_input = quant_scheme.weight.quant(input)

    return quant_input


def asymmetric_quantization(tensor, q_min=0, q_max=255):
    """
    Perform asymmetric quantization on a tensor.

    Args:
        tensor (torch.Tensor): Input tensor to quantize.
        q_min (int): Minimum quantized value (e.g., 0 for unsigned 8-bit).
        q_max (int): Maximum quantized value (e.g., 255 for unsigned 8-bit).

    Returns:
        quantized (torch.Tensor): Quantized tensor.
        scale (float): Scale factor used in quantization.
        zero_point (int): Zero-point used in quantization.
    """
    # Compute the scale factor and zero-point
    x_min, x_max = tensor.min(), tensor.max()
    scale = (x_max - x_min) / (q_max - q_min)
    zero_point = round(q_min - x_min / scale)

    # Quantize the tensor
    quantized = torch.round(tensor / scale + zero_point).clamp(q_min, q_max).to(torch.int)

    # Dequantize the tensor
    dequantized = scale * (quantized - zero_point)

    return quantized, dequantized, scale, zero_point

# Example usage
tensor = torch.tensor([0.0, 1.5, 3.2, 5.6, 10.0], dtype=torch.float32)

# Perform asymmetric quantization
quantized, dequantized, scale, zero_point = asymmetric_quantization(tensor, q_min=0, q_max=255)

print("Original Tensor:", tensor)
print("Quantized Tensor:", quantized)
print("Dequantized Tensor:", dequantized)
print("Scale Factor:", scale)
print("Zero Point:", zero_point)
