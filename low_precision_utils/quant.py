from abc import abstractmethod
import json
import torch
from torch import nn
import numpy as np

import argparse
import qtorch
import qtorch.quant
import copy

import os
import sys

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(parent_dir)
from low_precision_utils import layers
sys.path.append(os.path.join(parent_dir, 'iterative_approximation'))
from iterative_approximation_quant import *
sys.path.append(os.path.join(parent_dir, 'server'))
from utils import *
sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
from quant_svd import *


import torch.autograd
import torch.nn.grad
from dataclasses import dataclass



SCALING=True
TEST_NAN = False

def assert_nan(x):
    if not TEST_NAN:
        return x
    if x.isnan().any():
        print(x)
    assert torch.all(x.isnan() == False)
    assert torch.all(x.isinf() == False)
    return x

import torch

def add_argparse(parser : argparse.ArgumentParser):
    parser.add_argument("--quant_scheme", type=json.loads, default="{}")
    return parser

class QuantMethod:
    @abstractmethod
    def quant(self, x):
        pass

    @classmethod
    def _from_dict(cls, json_dict: dict):
        return cls(**json_dict)

    @classmethod
    def from_dict(cls, json_dict: dict):
        number_type = json_dict.get("number_type", "fp")
        json_dict["number_type"] = number_type
        json_dict = json_dict.copy()
        del json_dict["number_type"]

        if number_type == "fp":
            return FPQuant._from_dict(json_dict)
        elif number_type == "int":
            return IntQuant._from_dict(json_dict)
        elif number_type == "block":
            return BlockQuant._from_dict(json_dict)
        elif number_type == "scaled_int":
            return ScaledIntQuant._from_dict(json_dict)
        else:
            raise ValueError(f"number_type {number_type} not recognized")

# quant method strategy
@dataclass(frozen=True)
class FPQuant(QuantMethod):
    exp : int = 8
    man : int = 23
    round_mode : str = "stochastic"

    def quant(self, x):
        if self.exp == 8 and self.man == 23:
            return x
        return qtorch.quant.float_quantize(x, self.exp, self.man, self.round_mode)

@dataclass(frozen=True)
class IntQuant(QuantMethod):
    wl : int = 16
    fl : int = 8
    clamp : bool = True
    symmetric : bool = False
    round_mode : str = "stochastic"

    def quant(self, x):
        return qtorch.quant.fixed_point_quantize(x, self.wl, self.fl, self.clamp, self.symmetric, self.round_mode)

@dataclass(frozen=True)
class BlockQuant(QuantMethod):
    wl : int = 8
    dim : int = 8
    round_mode : str = "stochastic"

    def quant(self, x):
        return qtorch.quant.block_quantize(x, self.wl, self.dim, self.round_mode)

@dataclass(frozen=True)
class ScaledIntQuant(QuantMethod):
    fl : int = 8
    clamp : bool = True
    symmetric : bool = False
    round_mode : str = "stochastic"

    def quant(self, x):
        x_scale = x.abs().max()
        x = x / x_scale
        result =  qtorch.quant.fixed_point_quantize(x, self.fl + 1, self.fl, self.clamp, self.symmetric, self.round_mode)
        return result * x_scale

@dataclass(frozen=True)
class QuantScheme:
    act: QuantMethod = FPQuant()
    weight: QuantMethod = FPQuant()
    bact: QuantMethod = FPQuant()
    bweight: QuantMethod = FPQuant()
    goact: QuantMethod = FPQuant()
    goweight: QuantMethod = FPQuant()
    same_input: bool = False
    same_weight: bool = False

    @classmethod
    def from_args(cls, args: argparse.Namespace):
        json_dict = args.quant_scheme
        fp_default = {"number_type":"fp"}
        return QuantScheme(
            act=QuantMethod.from_dict( json_dict.get("act", fp_default)),
            weight=QuantMethod.from_dict( json_dict.get("weight", fp_default)),
            bact=QuantMethod.from_dict( json_dict.get("bact", fp_default)),
            bweight=QuantMethod.from_dict( json_dict.get("bweight", fp_default)),
            goact=QuantMethod.from_dict( json_dict.get("goact", fp_default)),
            goweight=QuantMethod.from_dict( json_dict.get("goweight", fp_default)),
            same_input=json_dict.get("same_input", False),
            same_weight=json_dict.get("same_weight", False)
        )

    def __str__(self):
        return self.__dict__.__str__()

FP32 = FPQuant()
FP32_SCHEME = QuantScheme(FP32, FP32, FP32, FP32, FP32, FP32, same_input=True, same_weight=True)

class QuantWrapper(nn.Module):
    def __init__(self, module, quant_scheme):
        super(QuantWrapper, self).__init__()
        module = replace_with_quantized(module, quant_scheme)
        self.quant_scheme = quant_scheme
        self.module = module

    def apply_quant_scheme(self, quant_scheme, filter=None):
        apply_quant_scheme(self, quant_scheme, filter)

    def forward(self, *args, **kw):
        return self.module(*args, **kw)

    def loss_acc(self, X, y):
        return self.module.loss_acc(X, y)

def apply_quant_scheme(network, quant_scheme, filter=None):
    for name, module in network.named_modules():
        if hasattr(module, "quant_scheme"):
            if filter is None:
                module.quant_scheme = quant_scheme
            elif filter(name, module):
                module.quant_scheme = quant_scheme
    return network

# def replace_with_quantized(network, quant_scheme):
#     to_replace = []
#     for name, module in network.named_children():
#         if isinstance(module, nn.Linear):
#             new_module = layers.QuantLinear.from_full_precision(module, quant_scheme)
#             to_replace.append((name, new_module))
#         elif isinstance(module, nn.Conv2d):
#             new_module = layers.QuantConv2d.from_full_precision(module, quant_scheme)
#             to_replace.append((name, new_module))
#         elif isinstance(module, nn.Conv1d):
#             new_module = layers.QuantConv1d.from_full_precision(module, quant_scheme)
#             to_replace.append((name, new_module))
#         else:
#             replace_with_quantized(module, quant_scheme)
    
#     for name, new_module in to_replace:
#         setattr(network, name, new_module)

#     return network

def replace_with_quantized(network, quant_scheme, wl, method, filter):
    # List to keep track of layers to be replaced
    to_replace = []
    
    for name, module in network.named_children():
        # Check if the module is the specific self-attention layer of the encoder
        if isinstance(module, filter):
            # Access the self-attention layer within the MarianEncoderLayer
            self_attn = module.self_attn
            
            # Replace k_proj, q_proj, v_proj with quantized versions, but keep out_proj unchanged
            self_attn.k_proj = layers.QuantLinear.from_full_precision(self_attn.k_proj, quant_scheme, wl, method)
            self_attn.q_proj = layers.QuantLinear.from_full_precision(self_attn.q_proj, quant_scheme, wl, method)
            self_attn.v_proj = layers.QuantLinear.from_full_precision(self_attn.v_proj, quant_scheme, wl, method)
            
            # Add the modified self-attention back to the encoder layer
            module.self_attn = self_attn
        else:
            # Recursively search within child modules
            replace_with_quantized(module, quant_scheme, wl, method, filter)
    
    # Replace identified layers
    for name, new_module in to_replace:
        setattr(network, name, new_module)
    
    return network

# def compute_u_v_array(weight_array, rank, word_length, method):
#     u_array = []
#     v_array = []
    
#     for i in range(len(weight_array)):
#         # Get the weight matrix and convert to NumPy for SVD
#         weight = weight_array[i].cpu().detach().numpy()
        
#         # Perform SVD using numpy to get U, S, V matrices
#         u, s, v_t = np.linalg.svd(weight)  # v_t is already transposed in numpy
        
#         # Reduce U, S, and V matrices to the specified rank
#         u_reduced = u[:, :rank]
#         s_reduced = np.diag(s[:rank])
#         v_reduced = v_t[:rank, :]
        
#         # Compute the rank-r approximation in numpy
#         u_approx = u_reduced @ s_reduced    # U * S
#         v_approx = v_reduced  # V^T is already transposed from np.linalg.svd

#         # Convert results back to PyTorch tensors if needed
#         u_approx = torch.tensor(u_approx)
#         v_approx = torch.tensor(v_approx)

#         # Initialize an empty list to store quantized columns for u_approx
#         quantized_columns = []

#         # Quantize each column of u_approx
#         for i in range(u_approx.size(1)):  # Assuming u_approx is 2D (rows, columns)
#             column = u_approx[:, i]  # Extract the i-th column
#             _, quantized_column, _ = quantisation_wrapper(column, word_length, method)  # Apply quantization
#             quantized_columns.append(quantized_column)  # Collect the quantized column

#         # Merge the quantized columns back into a tensor
#         u_approx_quant = torch.stack(quantized_columns, dim=1)

#         # Initialize an empty list to store quantized rows for v_approx
#         quantized_rows = []

#         # Quantize each row of v_approx
#         for i in range(v_approx.size(0)):  # Assuming v_approx is 2D (rows, columns)
#             row = v_approx[i, :]  # Extract the i-th row
#             _, quantized_row, _ = quantisation_wrapper(row, word_length, method)  # Apply quantization
#             quantized_rows.append(quantized_row)  # Collect the quantized row

#         # Merge the quantized rows back into a tensor
#         v_approx_quant = torch.stack(quantized_rows, dim=0)

#         # Append the approximations to the arrays
#         u_array.append(u_approx_quant)
#         v_array.append(v_approx_quant)
    
#     return u_array, v_array

from scipy.linalg import svd

def compute_u_v_array(weight_array, rank, word_length, method):
    u_array = []
    v_array = []
    
    for i in range(len(weight_array)):
        # Get the weight matrix and convert to NumPy for SVD with higher precision
        weight = weight_array[i].cpu().detach().numpy().astype(np.float64)
        
        # Perform SVD using numpy to get U, S, V matrices
        u, s, v_t = svd(weight, full_matrices=False)  # v_t is already transposed in numpy
        
        # Reduce U, S, and V matrices to the specified rank
        u_reduced = u[:, :rank].astype(np.float64)
        s_reduced = np.diag(s[:rank].astype(np.float64))
        v_reduced = v_t[:rank, :].astype(np.float64)
        
        # Compute the rank-r approximation in numpy
        u_approx = np.dot(u_reduced, s_reduced)    # U * S
        v_approx = v_reduced  # V^T is already transposed from svd

        # Convert results back to PyTorch tensors with higher precision
        u_approx = torch.tensor(u_approx, dtype=torch.float64)
        v_approx = torch.tensor(v_approx, dtype=torch.float64)

        # Initialize an empty list to store quantized columns for u_approx
        quantized_columns = []

        # Quantize each column of u_approx
        for j in range(u_approx.size(1)):  # Assuming u_approx is 2D (rows, columns)
            column = u_approx[:, j]  # Extract the j-th column
            _, quantized_column, _ = quantisation_wrapper(column, word_length, method)  # Apply quantization
            quantized_columns.append(quantized_column)  # Collect the quantized column

        # Merge the quantized columns back into a tensor
        u_approx_quant = torch.stack(quantized_columns, dim=1)

        # Initialize an empty list to store quantized rows for v_approx
        quantized_rows = []

        # Quantize each row of v_approx
        for k in range(v_approx.size(0)):  # Assuming v_approx is 2D (rows, columns)
            row = v_approx[k, :]  # Extract the k-th row
            _, quantized_row, _ = quantisation_wrapper(row, word_length, method)  # Apply quantization
            quantized_rows.append(quantized_row)  # Collect the quantized row

        # Merge the quantized rows back into a tensor
        v_approx_quant = torch.stack(quantized_rows, dim=0)

        # Append the approximations to the arrays
        u_array.append(u_approx_quant)
        v_array.append(v_approx_quant)
    
    return u_array, v_array

# def compute_u_v_iterative(weight, rank, word_length, method):
#     if isinstance(weight, torch.Tensor):
#         weight = weight.cpu().detach().numpy()  # Convert to NumPy if PyTorch tensor

#     # Validate rank
#     if rank > min(weight.shape):
#         raise ValueError(f"Rank ({rank}) cannot exceed the minimum dimension of the weight matrix {weight.shape}.")

#     u_approx_list = []
#     v_approx_list = []

#     residual = weight.copy()  # Create a copy of the weight matrix for residual calculations

#     for i in range(rank):
#         # Perform SVD on the current weight matrix to get the first singular vector and value
#         u, s, v_t = np.linalg.svd(residual)

#         # Select the first singular value/vector (rank-1 approximation)
#         sigma = s[0]  # The largest singular value
#         u_1 = u[:, 0].reshape(-1, 1)  # Column vector for U
#         v_1 = v_t[0, :].reshape(1, -1)  # Row vector for V (already transposed in np.linalg.svd)

#         # Convert results back to PyTorch tensors if needed
#         u_approx = torch.tensor(u_1 * sigma)
#         v_approx = torch.tensor(v_1)
        
#         # Quantize the matrices based on the quant_scheme if required
#         _, u_approx_quant, _ = quantisation_wrapper(u_approx, word_length, method)
#         _, v_approx_quant, _ = quantisation_wrapper(v_approx, word_length, method)

#         # Compute the rank-1 approximation and append to lists
#         u_approx_list.append(u_approx_quant)
#         v_approx_list.append(v_approx_quant)

#         # Subtract the rank-1 approximation from weight to get the residual
#         residual -= (u_approx_quant @ v_approx_quant).numpy()  # Convert to NumPy for subtraction

#     # Stack the rank-1 approximations to form the final reduced U and V
#     u_approx = torch.tensor(np.hstack(u_approx_list))  # Convert back to PyTorch tensor
#     v_approx = torch.tensor(np.vstack(v_approx_list))  # Convert back to PyTorch tensor

#     return u_approx, v_approx

def compute_u_v_iterative(weight, rank, word_length, method):
    # Convert weight to NumPy array with higher precision if it's a PyTorch tensor
    if isinstance(weight, torch.Tensor):
        weight = weight.cpu().detach().numpy().astype(np.float64)

    # Validate rank
    if rank > min(weight.shape):
        raise ValueError(f"Rank ({rank}) cannot exceed the minimum dimension of the weight matrix {weight.shape}.")

    u_approx_list = []
    v_approx_list = []

    residual = weight.copy()  # Create a copy of the weight matrix for residual calculations

    for i in range(rank):
        # Perform SVD on the current residual matrix
        u, s, v_t = np.linalg.svd(residual, full_matrices=False)

        # Select the first singular value/vector (rank-1 approximation)
        sigma = s[0]  # The largest singular value
        u_1 = u[:, 0].reshape(-1, 1).astype(np.float64)  # Column vector for U
        v_1 = v_t[0, :].reshape(1, -1).astype(np.float64)  # Row vector for V

        # Convert results to PyTorch tensors with higher precision
        u_approx = torch.tensor(u_1 * sigma, dtype=torch.float64)
        v_approx = torch.tensor(v_1, dtype=torch.float64)

        # Quantize the matrices based on the quant_scheme if required
        _, u_approx_quant, _ = quantisation_wrapper(u_approx, word_length, method)
        _, v_approx_quant, _ = quantisation_wrapper(v_approx, word_length, method)

        # Compute the rank-1 approximation and append to lists
        u_approx_list.append(u_approx_quant)
        v_approx_list.append(v_approx_quant)

        # Subtract the rank-1 approximation from the residual
        residual -= (u_approx_quant.numpy() @ v_approx_quant.numpy()).astype(np.float64)

    # Stack the rank-1 approximations to form the final reduced U and V
    u_approx = torch.tensor(np.hstack(u_approx_list), dtype=torch.float64)  # Convert back to PyTorch tensor
    v_approx = torch.tensor(np.vstack(v_approx_list), dtype=torch.float64)  # Convert back to PyTorch tensor

    return u_approx, v_approx

def replace_with_quantized_svd(network, rank, quant_scheme, wl, method, filter):
    # List to keep track of layers to be replaced
    to_replace = []

    # Iterate through the modules in the network
    for name, module in network.named_children():
        # Check if the module matches the specified filter type
        if isinstance(module, filter):
            self_attn = module.self_attn

            weight_array = [self_attn.k_proj.weight, self_attn.q_proj.weight, self_attn.v_proj.weight]
            
            u_array, v_array = compute_u_v_array(weight_array, rank, wl, method)
            # Replace k_proj, q_proj, v_proj with QuantLinearSVD versions, but keep out_proj unchanged
            self_attn.k_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.k_proj, u_array[0], v_array[0], rank, quant_scheme)
            self_attn.q_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.q_proj, u_array[1], v_array[1], rank, quant_scheme)
            self_attn.v_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.v_proj, u_array[2], v_array[2], rank, quant_scheme)

            # Assign the modified self-attention back to the module
            module.self_attn = self_attn

        # Recursively apply replacements to submodules
        else:
            replace_with_quantized_svd(module, rank, quant_scheme, wl, method, filter)

    # Replace identified layers with their quantized versions
    for name, new_module in to_replace:
        setattr(
            network, name, new_module)

    return network


def replace_with_quantized_iterative_svd(network, rank, quant_scheme, wl, method, filter):
    # List to keep track of layers to be replaced
    to_replace = []

    # Iterate through the modules in the network
    for name, module in network.named_children():
        # Check if the module matches the specified filter type
        if isinstance(module, filter):
            self_attn = module.self_attn

            weight_array = [self_attn.k_proj.weight, self_attn.q_proj.weight, self_attn.v_proj.weight]

            u_array = []
            v_array = []
            
            for i in range(len(weight_array)):
                u, v = compute_u_v_iterative(weight_array[i], rank, wl, method)
                u_array.append(u)
                v_array.append(v)
            
            # Replace k_proj, q_proj, v_proj with QuantLinearSVD versions, but keep out_proj unchanged
            self_attn.k_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.k_proj, u_array[0], v_array[0], rank, quant_scheme)
            self_attn.q_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.q_proj, u_array[1], v_array[1], rank, quant_scheme)
            self_attn.v_proj = layers.QuantLinearSVD.from_full_precision1(self_attn.v_proj, u_array[2], v_array[2], rank, quant_scheme)

            # Assign the modified self-attention back to the module
            module.self_attn = self_attn

        # Recursively apply replacements to submodules
        else:
            replace_with_quantized_iterative_svd(module, rank, quant_scheme, wl, method, filter)

    # Replace identified layers with their quantized versions
    for name, new_module in to_replace:
        setattr(
            network, name, new_module)

    return network

def replace_with_quantized_svd_wrapper(network, rank, quant_scheme, wl, method, filter):
    local_network = copy.deepcopy(network)
    local_network = replace_with_quantized_svd(local_network, rank, quant_scheme, wl, method, filter)
    return local_network

def replace_with_quantized_iterative_svd_wrapper(network, rank, quant_scheme, wl, method, filter):
    local_network = copy.deepcopy(network)
    local_network = replace_with_quantized_iterative_svd(local_network, rank, quant_scheme, wl, method, filter)
    return local_network


class ModelEma(nn.Module):
    def __init__(self, model, decay=0.9999, device=None):
        super(ModelEma, self).__init__()
        # make a copy of the model for accumulating moving average of weights
        self.module = copy.deepcopy(model)
        self.module.eval()
        self.decay = decay
        self.device = device  # perform ema on different device from model if set
        if self.device is not None:
            self.module.to(device=device)

    def _update(self, model, update_fn):
        with torch.no_grad():
            for ema_v, model_v in zip(self.module.state_dict().values(), model.state_dict().values()):
                if self.device is not None:
                    model_v = model_v.to(device=self.device)
                ema_v.copy_(update_fn(ema_v, model_v))

    def update(self, model):
        self._update(model, update_fn=lambda e, m: self.decay * e + (1. - self.decay) * m)

    def set(self, model):
        self._update(model, update_fn=lambda e, m: m)
