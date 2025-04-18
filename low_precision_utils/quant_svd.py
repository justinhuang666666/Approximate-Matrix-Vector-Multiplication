# from torch import nn
# from . import functional
# from . import quant 
import torch
import torch.nn.functional as F

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

# Range-Based Scaling
def quantisation_range_based_scaling(tensor, num_bits):
    # Determine the quantization range for signed integers
    quantization_range = 2 ** (num_bits - 1) - 1  # For signed quantization

    # Find the maximum absolute value of the tensor
    max_val = tensor.abs().max()

    # Avoid division by zero
    scale = quantization_range / max_val if max_val != 0 else 1.0

    # Quantize the tensor
    quantized = torch.round(tensor * scale).clamp(-quantization_range, quantization_range)

    # Dequantize the tensor (optional, for comparison or further processing)
    dequantized = quantized / scale

    return quantized, dequantized, scale

def quantisation_mean_based_scaling(tensor, num_bits):
    # Determine the quantization range for signed integers
    quantization_range = 2 ** (num_bits - 1) - 1  # For signed quantization

    # Compute the mean absolute value of the tensor
    mean_val = tensor.abs().mean()
    std_val = tensor.abs().std()

    # Avoid division by zero
    scale = quantization_range / (mean_val+std_val) if mean_val != 0 else 1.0

    # Quantize the tensor
    quantized = torch.round(tensor * scale).clamp(-quantization_range, quantization_range)

    # Dequantize the tensor (optional, for comparison or further processing)
    dequantized = quantized / scale

    return quantized, dequantized, scale



def quantisation_log2_based_scaling(tensor, num_bits):
    # Determine the quantization range for signed integers
    quantization_range = 2 ** (num_bits - 1) - 1  # For signed quantization

    # Find the maximum absolute value of the tensor
    max_val = tensor.abs().max()

    # Avoid division by zero
    if max_val == 0:
        scale = 1.0  # Default scale for zero tensor
    else:
        # Log2-based scaling: Find the nearest power of 2 that aligns the scale
        log2_scale = torch.ceil(torch.log2(max_val / quantization_range))
        scale = 2 ** log2_scale  # Scale factor is a power of 2

    # Quantize the tensor
    quantized = torch.round(tensor / scale).clamp(-quantization_range, quantization_range)

    # Dequantize the tensor (optional, for comparison or further processing)
    dequantized = quantized * scale

    return quantized, dequantized, 1/scale

def quantisation_loss_aware_scaling(tensor, num_bits):

    # Determine the quantization range for signed integers
    quantization_range = 2 ** (num_bits - 1) - 1  # For signed quantization

    # Initialize the scaling factor (can start with range-based scaling or another heuristic)
    scale_init = tensor.abs().max() / quantization_range if tensor.abs().max() != 0 else 1.0
    scale = torch.tensor(scale_init, requires_grad=True)

    # Define an optimization process to minimize MSE
    optimizer = torch.optim.LBFGS([scale], lr=0.1)

    def closure():
        optimizer.zero_grad()
        # Quantize and dequantize using the current scale
        quantized = torch.round((tensor / scale)).clamp(-quantization_range, quantization_range)
        dequantized = quantized * scale
        # Compute the MSE between the original and dequantized tensor
        loss = F.mse_loss(tensor, dequantized)
        loss.backward()
        return loss

    # Optimize the scale
    for _ in range(40):  # Adjust the number of iterations if necessary
        optimizer.step(closure)

    # Final quantization with optimized scale
    quantized = torch.round((tensor / scale.item())).clamp(-quantization_range, quantization_range)
    dequantized = quantized * scale

    return quantized.detach(), dequantized.detach(), scale.item()*quantization_range


def quantisation_wrapper(tensor, num_bits, method="range_based"):
    """
    Wrapper function for different quantization methods.
    Args:
        tensor (torch.Tensor): Input tensor to be quantized.
        num_bits (int): Number of bits for quantization.
        method (str): Quantization method to use.
            Options: "range_based", "mean_based", "log2_based", "loss_aware"
    Returns:
        torch.Tensor: Quantized tensor.
        torch.Tensor: Dequantized tensor.
        float: Scaling factor.
    """
    if method == "range_based":
        return quantisation_range_based_scaling(tensor, num_bits)
    elif method == "mean_based":
        return quantisation_mean_based_scaling(tensor, num_bits)
    elif method == "log2_based":
        return quantisation_log2_based_scaling(tensor, num_bits)
    elif method == "loss_aware":
        return quantisation_loss_aware_scaling(tensor, num_bits)
    else:
        raise ValueError(f"Unsupported quantization method: {method}")



def asymmetric_quantization_range_based_scaling(tensor, num_bits):
    q_min = 0
    q_max = 2 ** (num_bits) - 1

    # Compute the scale factor and zero-point
    x_min, x_max = tensor.min(), tensor.max()
    scale = (x_max - x_min) / (q_max - q_min)
    zero_point = x_min / scale

    # Quantize the tensor
    quantized = torch.round(tensor / scale + zero_point).clamp(q_min, q_max).to(torch.int)

    # Dequantize the tensor
    dequantized = scale * (quantized - zero_point)

    return quantized, dequantized, scale, zero_point

def asymmetric_quantization_mean_based_scaling(tensor, num_bits):
    q_min = 0
    q_max = 2 ** (num_bits) - 1

    # Compute the mean and standard deviation of the tensor
    mean = tensor.mean()
    std_dev = tensor.std()

    # Define the scaling range based on mean and a factor of standard deviation
    x_min = mean - std_dev
    x_max = mean + std_dev

    # Compute scale and zero-point
    scale = (x_max - x_min) / (q_max - q_min)
    zero_point = q_min - x_min / scale

    # Quantize the tensor
    quantized = torch.round(tensor / scale + zero_point).clamp(q_min, q_max).to(torch.int)

    # Dequantize the tensor
    dequantized = scale * (quantized - zero_point)

    return quantized, dequantized, scale, zero_point


# tensor = torch.tensor([1.5, 3.2, 5.6, 10.0], dtype=torch.float32)
# print("Original Tensor:", tensor)

# quantized1, dequantized1, scale1 = quantisation_range_based_scaling(tensor, 8)
# quantized2, dequantized2, scale2 = quantisation_mean_based_scaling(tensor, 8)
# quantized3, dequantized3, scale3 = quantisation_log2_based_scaling(tensor, 8)
# quantized4, dequantized4, scale4 = quantisation_loss_aware_scaling(tensor, 8)

# print("Dequantized Tensor (Range Based):", dequantized1)
# print("Scaling (Range Based):", scale1)

# print("Dequantized Tensor (Mean Based):", dequantized2)
# print("Scaling (Mean Based):", scale2)

# print("Dequantized Tensor (Log2 Based):", dequantized3)
# print("Scaling (Log2 Based):", scale3)

# print("Dequantized Tensor (Loss Aware):", dequantized4)
# print("Scaling (Loss Aware):", scale4)