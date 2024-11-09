# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"
import sys
import os
import math
import numpy as np
import torch

import warnings
warnings.filterwarnings("ignore")

# Dynamically add paths relative to the current script's location
# This makes it more portable since it does not rely on hard-coded absolute paths
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(os.path.join(parent_dir, 'server'))
sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))

from quant_svd import *

from utils import *

class WeightArray:
    def __init__(self, weight, method, threshold, NZr, NZc, Tr, Tc, quant_scheme):
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")  # Use GPU if available
        self.num_weights = len(weight)

        self.R = weight[0].shape[0]
        self.C = weight[0].shape[1]

        self.NZc = NZc
        self.NZr = NZr

        self.Tr = Tr
        self.Tc = Tc

        self.quant_scheme = quant_scheme 
        self.precision = 32# Initialize the precision (by default 32 bits per operand) and threshold
        self.threshold = threshold

        self.memory_footprint_baseline = 0

        self.memory_footprint_compressed = 0   
        self.num_group = []  # Array to store the num_group per approximation step
        self.steps = 0  # Counter of current step

        self.method = method

        # Move weights to GPU
        weight = [torch.tensor(w, dtype=torch.float32, device=self.device) for w in weight]

        if self.method == 'weight':
            self.original_weight = torch.vstack(weight)
            self.current_residual_weight = torch.vstack(weight)
            self.current_reconstructed_weight = torch.vstack([torch.zeros_like(W) for W in weight])
            self.padding_weight()
            self.cal_memory_footprint_baseline_weight()
            
        else:  # method == 'array'
            self.original_weight_array = weight  # Initialize the weight attribute
            self.current_residual_weight_array = weight
            self.current_reconstructed_weight_array = [torch.zeros_like(W) for W in weight]
            self.padding_array()

            self.cal_memory_footprint_baseline_array()

    def iterative_approximation(self, method, norm='none'):
        unsupported_method_message = "Unsupported iterative approximation method."
        unsupported_norm_message = "Unsupported normalization method."

        # Mapping of methods to their respective functions
        method_mapping = {
            1: {
                'none': self.iterative_approximation_single,
                'fro': lambda: print("Single matrix approximation does not support normalization."),
                'spec': lambda: print("Single matrix approximation does not support normalization.")
            },
            2: {
                'none': self.iterative_approximation_group,
                'fro': lambda: self.iterative_approximation_group_norm('fro'),
                'spec': lambda: self.iterative_approximation_group_norm('spec')
            },
            3: {
                'none': self.iterative_approximation_stack,
                'fro': lambda: self.iterative_approximation_stack_norm('fro'),
                'spec': lambda: self.iterative_approximation_stack_norm('spec')
            }
        }

        if method in method_mapping:
            if norm in method_mapping[method]:
                return method_mapping[method][norm]()  # Call the appropriate function or action
            else:
                print(unsupported_norm_message)
        else:
            print(unsupported_method_message)
        
    def compute_uv(self, rank, method, norm='none'):
        # Initialize u_array and v_array with empty lists to hold stacked components
        u_array = [torch.tensor([]) for _ in range(self.num_weights)]
        v_array = [torch.tensor([]) for _ in range(self.num_weights)]
        
        for i in range(rank):
            # Perform single-step approximation to get u and v for current rank
            u, v = self.iterative_approximation(method,norm)

            # Stack each u and v vector into u_array and v_array
            for j in range(len(u)):
                # Use torch.hstack or torch.vstack to concatenate the vectors
                u_array[j] = torch.hstack((u_array[j], u[j].unsqueeze(1))) if u_array[j].numel() > 0 else u[j].unsqueeze(1)
                v_array[j] = torch.vstack((v_array[j], v[j].unsqueeze(0))) if v_array[j].numel() > 0 else v[j].unsqueeze(0)
        
        return u_array, v_array

                
    def iterative_approximation_single(self):
        residual_weight_array = self.current_residual_weight_array
        reconstructed_weight_array = self.current_reconstructed_weight_array

        residual_weight_array_step = [torch.zeros_like(W) for W in residual_weight_array]
        reconstructed_weight_array_step = [torch.zeros_like(W) for W in reconstructed_weight_array]

        u = [None] * len(residual_weight_array)  # Initialize u for singular vectors
        v = [None] * len(residual_weight_array)  # Initialize v for singular vectors

        for idx, (Wi, RWi) in enumerate(zip(residual_weight_array, reconstructed_weight_array)):
            # Update SVD on the error matrix using PyTorch
            U_n, S_n, Vt_n = torch.svd(Wi)
            
            sigma1_n = S_n[0]

            u1_n = U_n[:, 0]
            v1_n = Vt_n[:, 0]

            # Update the weight matrix approximation with all tensors on the same device
            reconstructed = RWi + torch.ger(sigma1_n * u1_n, v1_n) # quant_svd(sigma1_n * u1_n, v1_n, self.quant_scheme)
            residual = Wi - torch.ger(sigma1_n * u1_n, v1_n) # quant_svd(sigma1_n * u1_n, v1_n, self.quant_scheme)

            reconstructed_weight_array_step[idx] = reconstructed
            residual_weight_array_step[idx] = residual

            u[idx] = sigma1_n * u1_n #quantisation(sigma1_n * u1_n,self.quant_scheme)
            v[idx] = v1_n #quantisation(v1_n,self.quant_scheme)
        
        self.current_reconstructed_weight_array = reconstructed_weight_array_step
        self.current_residual_weight_array = residual_weight_array_step
        self.steps += 1

        self.num_group.append(self.num_weights)

        self.cal_memory_footprint_compressed_array()
        
        # return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array_step]
        return u, v
        
    def iterative_approximation_group(self):
        residual_weight_array = self.current_residual_weight_array

        reconstructed_weight_array = self.current_reconstructed_weight_array

        # Compute the summation matrix using GPU
        summation_matrix = sum(W @ W.T for W in residual_weight_array)

        # Perform SVD on the summation matrix
        U, S, Vt = torch.linalg.svd(summation_matrix, full_matrices=False)
        u = U[:, 0]

        # Compute W_hat on the GPU
        W_hat = torch.stack([W.T @ u for W in residual_weight_array], dim=1)
        U, S, Vt = torch.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
        v = Vt[0, :]

        # Initialize previous vectors and thresholds
        u_previous = torch.zeros_like(u)
        v_previous = torch.zeros_like(v)

        threshold = self.threshold
        u_diff = threshold + 1
        v_diff = threshold + 1

        count = 0

        # Iterative approximation loop
        while u_diff > threshold or v_diff > threshold:
            W_hat = torch.stack([W @ v for W in residual_weight_array], dim=1)
            U, S, Vt = torch.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            u = U[:, 0]

            W_hat = torch.stack([W.T @ u for W in residual_weight_array], dim=1)
            U, S, Vt = torch.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            v = Vt[0, :]

            # Compute mean square error using GPU tensors
            u_diff = torch.mean((u - u_previous) ** 2).item()
            v_diff = torch.mean((v - v_previous) ** 2).item()

            u_previous = u
            v_previous = v
            count += 1
            if count > 200:
                break

        # Compute A_j and lambda_i_array on GPU
        A_j = torch.outer(u_previous, v_previous)
        lambda_i_array = [v_previous.T @ W.T @ u_previous for W in residual_weight_array]

        # Update residual and reconstructed weight arrays on GPU
        residual_weight_array = [W - lmbda * A_j for W, lmbda in zip(residual_weight_array, lambda_i_array)]
        reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        # Update class variables
        self.current_reconstructed_weight_array = [RW for RW in reconstructed_weight_array]
        self.current_residual_weight_array = [W for W in residual_weight_array]
        self.steps += 1
        self.num_group.append(1)
        self.cal_memory_footprint_compressed_array()

        # Return reconstructed weight array, sliced to dimensions R and C
        return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array]

    def iterative_approximation_stack(self):
        # Ensure residual and reconstructed weights are on the GPU
        residual_weight = self.current_residual_weight.to('cuda')
        reconstructed_weight = self.current_reconstructed_weight.to('cuda')

        # Update SVD on the error matrix
        U_n, S_n, Vt_n = torch.linalg.svd(residual_weight, full_matrices=False)
        sigma1_n = S_n[0]
        u1_n = U_n[:, 0]
        v1_n = Vt_n[0, :]

        # Update the weight matrix approximation
        reconstructed = reconstructed_weight + sigma1_n * torch.ger(u1_n,v1_n)  # ger is the outer product in PyTorch
        residual = residual_weight - sigma1_n * torch.ger(u1_n,v1_n)

        # Update class attributes
        self.current_reconstructed_weight = reconstructed
        self.current_residual_weight = residual
        self.steps += 1
        self.num_group.append(self.num_weights)

        # Call the method to calculate memory footprint
        self.cal_memory_footprint_compressed_weight()

        return [reconstructed[i*self.R:(i+1)*self.R, 0:self.C] for i in range(self.num_weights)]
    
    def reconstructed_weight(self):
        return [self.current_reconstructed_weight[i*self.R:(i+1)*self.R, 0:self.C] for i in range(self.num_weights)]

    def cal_memory_footprint_baseline_array(self):     
        self.memory_footprint_baseline = len(self.original_weight_array) * self.R * self.C * self.precision 
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_baseline_weight(self):     
        self.memory_footprint_baseline = self.num_weights * self.R * self.C * self.precision 
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed_array(self):
        self.memory_footprint_compressed += (self.num_group[-1] * (self.NZr * self.Tr + self.NZc * self.Tc) + len(self.original_weight_array)) * self.precision + (self.num_group[-1] * (math.ceil(self.C/self.Tc) + math.ceil(self.R/self.Tr)))
    
    def cal_memory_footprint_compressed_weight(self):
        self.memory_footprint_compressed += ((self.num_weights * self.NZr * self.Tr + self.NZc * self.Tc) + 1) * self.precision + ((math.ceil(self.C/self.Tc) + math.ceil(self.num_weights*self.R/self.Tr)))

    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed
    
    def average_mse(self):
        if self.method == 'weight':
            return self.average_mse_weight()
        else:
            return self.average_mse_array()

    def average_mse_array(self):  
        return mean_square_error_array1(self.original_weight_array,self.current_reconstructed_weight_array) 
    
    def average_mse_weight(self):  
        return mean_square_error_matrix(self.original_weight,self.current_reconstructed_weight) 
    
    def padding_array(self):
        Tr = self.Tr
        Tc = self.Tc

        # Add padding_weight_array if needed
        pad_rows = self.R % Tr
        pad_cols = self.C % Tc

        if pad_rows > 0:
            self.original_weight_array = [np.vstack((W, np.zeros((Tr - pad_rows, W.shape[1])))) for W in self.original_weight_array]
            self.current_reconstructed_weight_array = [np.vstack((W, np.zeros((Tr - pad_rows, W.shape[1])))) for W in self.current_reconstructed_weight_array]
            self.current_residual_weight_array = [np.vstack((W, np.zeros((Tr - pad_rows, W.shape[1])))) for W in self.current_residual_weight_array]
        if pad_cols > 0:
            self.original_weight_array = [np.hstack((W, np.zeros((W.shape[0], Tc - pad_cols)))) for W in self.original_weight_array]
            self.current_reconstructed_weight_array = [np.hstack((W, np.zeros((W.shape[0], Tc - pad_cols)))) for W in self.current_reconstructed_weight_array]
            self.current_residual_weight_array = [np.hstack((W, np.zeros((W.shape[0], Tc - pad_cols)))) for W in self.current_residual_weight_array]
    
    def padding_weight(self):
        Tr = self.Tr
        Tc = self.Tc

        # Add padding if needed
        pad_rows = self.R % Tr
        pad_cols = self.C % Tc

        if pad_rows > 0:
            self.current_reconstructed_weight = np.vstack((self.current_reconstructed_weight, np.zeros((pad_rows, self.C))))
            self.current_residual_weight = np.vstack((self.current_residual_weight, np.zeros((pad_rows, self.C))))

        if pad_cols > 0:
            self.current_reconstructed_weight= np.hstack((self.current_reconstructed_weight, np.zeros((self.current_reconstructed_weight.shape[0], Tc - pad_cols))))
            self.current_residual_weight= np.hstack((self.current_residual_weight, np.zeros((self.current_residual_weight.shape[0], Tc - pad_cols))))

# import warnings

# import argparse
# import itertools
# import csv

# # Suppress all warnings
# warnings.filterwarnings("ignore")

# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.dirname(current_dir)

# # Add utility directories dynamically
# sys.path.append(os.path.join(parent_dir, 'low_precision_utils'))
# from quant import *

# # Suppress all warnings
# warnings.filterwarnings("ignore")

# current_dir = os.path.dirname(os.path.abspath(__file__))
# parent_dir = os.path.dirname(current_dir)


# def mse1(array1, array2, device='cpu'):
#     # Ensure that array1 and array2 are lists of PyTorch tensors
#     array1 = [torch.tensor(a, device=device, dtype=torch.float32) if isinstance(a, np.ndarray) else a.to(device, dtype=torch.float32) for a in array1]
#     array2 = [torch.tensor(a, device=device, dtype=torch.float32) if isinstance(a, np.ndarray) else a.to(device, dtype=torch.float32) for a in array2]
    
#     # Calculate mean squared error
#     mse = sum((a1 - a2).pow(2).mean().item() for a1, a2 in zip(array1, array2)) / len(array1)
#     return mse

# random_matrix1 = np.random.rand(512, 512)
# random_matrix2 = np.random.rand(512, 512)
# random_matrix3 = np.random.rand(512, 512)

# W = [random_matrix1,random_matrix2,random_matrix3]

# args_int = argparse.Namespace()

# wl = 32
# fl = 16

# # Define the quantization scheme dictionary with IntQuant settings
# args_int.quant_scheme = {
#     "act": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "weight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "same_input": True,
#     "same_weight": True
# }

# # Create the quantization scheme using the from_args method
# quant_scheme_int = QuantScheme.from_args(args_int)

# W32 = WeightArray(W,'array',0.001,1,1,512,512,quant_scheme_int)

# u_array, v_array = W32.compute_uv(200, 1)

# WW=[]
# for i in range(len(u_array)):
#     WW.append(u_array[i]@v_array[i])
# print(mse1(W,WW,WW[0].device))

# wl = 16
# fl = 8

# # Define the quantization scheme dictionary with IntQuant settings
# args_int.quant_scheme = {
#     "act": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "weight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "same_input": True,
#     "same_weight": True
# }

# # Create the quantization scheme using the from_args method
# quant_scheme_int = QuantScheme.from_args(args_int)

# W32 = WeightArray(W,'array',0.001,1,1,512,512,quant_scheme_int)

# u_array, v_array = W32.compute_uv(200, 1)

# WW=[]
# for i in range(len(u_array)):
#     WW.append(u_array[i]@v_array[i])
# print(mse1(W,WW,WW[0].device))

# wl = 8
# fl = 4

# # Define the quantization scheme dictionary with IntQuant settings
# args_int.quant_scheme = {
#     "act": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "weight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "bweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goact": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "goweight": {"number_type": "int", "wl": wl, "fl": fl, "clamp": True, "symmetric": True, "round_mode": 'nearest'},
#     "same_input": True,
#     "same_weight": True
# }

# # Create the quantization scheme using the from_args method
# quant_scheme_int = QuantScheme.from_args(args_int)

# W32 = WeightArray(W,'array',0.001,1,1,512,512,quant_scheme_int)

# u_array, v_array = W32.compute_uv(200, 1)

# WW=[]
# for i in range(len(u_array)):
#     WW.append(u_array[i]@v_array[i])
# print(mse1(W,WW,WW[0].device))
