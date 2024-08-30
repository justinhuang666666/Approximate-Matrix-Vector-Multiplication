# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"
import sys
sys.path.append('/Users/justin/Desktop/Imperial/Year 4/FYP/Code/main')

import numpy as np
from utils.mse import *
from utils.mask_gen import *
from utils.load_matrix import *
from utils.generate_groupings import *


sys.path.append('/Users/justin/Desktop/Imperial/Year 4/FYP/Code/main/iterative_approximation')
from quantizer import *

import math

from scipy.linalg import svd

class WeightArray:
    def __init__(self,weight,method,threshold,NZr,NZc,Tr,Tc):

        self.num_weights = len(weight)

        self.R = weight[0].shape[0]
        self.C = weight[0].shape[1]

        self.NZc = NZc
        self.NZr = NZr

        self.Tr = Tr
        self.Tc = Tc

        self.precision = 32 # Initialize the precision (by default 32 bits per operand) and threshold
        self.threshold = threshold

        self.memory_footprint_baseline = 0

        self.memory_footprint_compressed = 0   
        self.num_group = [] # Array to store the num_group per approximation step
        self.steps = 0 # Counter of current step

        self.method = method

        if self.method == 'weight':
            self.original_weight = np.vstack(weight)
            self.current_residual_weight = np.vstack(weight)
            self.current_reconstructed_weight = np.vstack([np.zeros_like(W) for W in weight])
            self.padding_weight()
            self.cal_memory_footprint_baseline_weight()
            
        else: # method == 'array'
            self.original_weight_array = weight  # Initialize the weight attribute
            self.current_residual_weight_array = weight 
            self.current_reconstructed_weight_array = [np.zeros_like(W) for W in weight]
            self.padding_array()

            self.cal_memory_footprint_baseline_array()
    
    def init_precision(self, precision):
        self.precision = precision

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
                method_mapping[method][norm]()  # Call the appropriate function or action
            else:
                print(unsupported_norm_message)
        else:
            print(unsupported_method_message)
                
    def iterative_approximation_single(self):
        residual_weight_array = self.current_residual_weight_array
        reconstructed_weight_array = self.current_reconstructed_weight_array

        residual_weight_array_step = [np.zeros_like(W) for W in residual_weight_array]
        reconstructed_weight_array_step = [np.zeros_like(W) for W in reconstructed_weight_array]

        for idx, (Wi, RWi) in enumerate(zip(residual_weight_array, reconstructed_weight_array)):
            # Update SVD on the error matrix
            # U_n, S_n, Vt_n = svd(Wi, full_matrices=False,lapack_driver='gesdd')
            U_n, S_n, Vt_n = svd(Wi, full_matrices=False,lapack_driver='gesdd')
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, self.NZc, self.Tc)
            Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, self.NZr, self.Tr)

            # Update the weight matrix approximation
            reconstructed = RWi + sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
            residual = Wi - sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)

            reconstructed_weight_array_step[idx] = reconstructed
            residual_weight_array_step[idx] = residual
        
        self.current_reconstructed_weight_array = reconstructed_weight_array_step
        self.current_residual_weight_array = residual_weight_array_step
        self.steps += 1

        self.num_group.append(self.num_weights)

        self.cal_memory_footprint_compressed_array()
        
        return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array_step]


    # 2D filter paper method: group of 4 matrices each approximation step
    def iterative_approximation_group(self, normalisation=False):
        residual_weight_array = self.current_residual_weight_array
        reconstructed_weight_array = self.current_reconstructed_weight_array
        summation_matrix = sum(W @ W.T for W in residual_weight_array)

        # Perform SVD on the summation matrix
        U, S, Vt = svd(summation_matrix, full_matrices=False,lapack_driver='gesdd')
        u = U[:, 0]

        W_hat = np.column_stack([W.T @ u for W in residual_weight_array])
        U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
        v = Vt[0,:]

        u_previous = np.zeros_like(u)
        v_previous = np.zeros_like(v)

        threshold = self.threshold

        u_diff = threshold + 1
        v_diff = threshold + 1

        count = 0

        while u_diff > threshold or v_diff > threshold:
            W_hat = np.column_stack([W @ v for W in residual_weight_array])

            U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in residual_weight_array])
            U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
            v = Vt[0,:]

            u_diff = mean_square_error_vector(u, u_previous)
            v_diff = mean_square_error_vector(v, v_previous)

            u_previous = u
            v_previous = v
            count = count + 1
            if count > 200:
                break

        Fi_v, compressed_Fi_v = create_mask_vector(v_previous, self.NZc, self.Tc)
        Fi_u, compressed_Fi_u = create_mask_vector(u_previous, self.NZr, self.Tr)

        A_j = np.outer(Fi_u * u_previous, Fi_v * v_previous)
        lambda_i_array = [v_previous.T @ W.T @ u_previous for W in residual_weight_array]
        residual_weight_array = [W - lmbda * A_j for W, lmbda in zip(residual_weight_array, lambda_i_array)]

        # Accumulate the reconstructed weights
        reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        self.current_reconstructed_weight_array = reconstructed_weight_array
        self.current_residual_weight_array = residual_weight_array
        self.steps += 1

        self.num_group.append(1)

        self.cal_memory_footprint_compressed_array()
        
        return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array]

    def iterative_approximation_group_norm(self, norm='fro'):
        residual_weight_array = self.current_residual_weight_array
        reconstructed_weight_array = self.current_reconstructed_weight_array
        normalised_residual_weight_array = [np.zeros_like(W) for W in residual_weight_array]
        
        # Normalize each weight matrix
        norms = []
        for i in range(len(residual_weight_array)):
            if norm == 'fro':
                current_norm = np.linalg.norm(residual_weight_array[i], 'fro')
            elif norm == 'spec':
                current_norm = np.linalg.norm(residual_weight_array[i], 2)
            else:
                raise ValueError("Unsupported norm type. Use 'fro' for Frobenius or 'spec' for spectral.")
            norms.append(current_norm)
            normalised_residual_weight_array[i] = residual_weight_array[i] / current_norm if current_norm != 0 else residual_weight_array[i]

        summation_matrix = sum(W @ W.T for W in normalised_residual_weight_array)

        # Perform SVD on the summation matrix
        U, S, Vt = svd(summation_matrix, full_matrices=False,lapack_driver='gesdd')
        u = U[:, 0]

        W_hat = np.column_stack([W.T @ u for W in normalised_residual_weight_array])
        U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
        v = Vt[0, :]

        u_previous = np.zeros_like(u)
        v_previous = np.zeros_like(v)

        threshold = self.threshold
        u_diff = threshold + 1
        v_diff = threshold + 1

        count = 0
        while u_diff > threshold or v_diff > threshold:
            W_hat = np.column_stack([W @ v for W in normalised_residual_weight_array])
            U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in normalised_residual_weight_array])
            U, S, Vt = svd(W_hat @ W_hat.T, full_matrices=False,lapack_driver='gesdd')
            v = Vt[0, :]

            u_diff = mean_square_error_vector(u, u_previous)
            v_diff = mean_square_error_vector(v, v_previous)

            u_previous = u
            v_previous = v
            count += 1
            if count > 200:
                break

        Fi_v, compressed_Fi_v = create_mask_vector(v_previous, self.NZc, self.Tc)
        Fi_u, compressed_Fi_u = create_mask_vector(u_previous, self.NZr, self.Tr)

        A_j = np.outer(Fi_u * u_previous, Fi_v * v_previous)
        lambda_i_array = [norm * v_previous.T @ W.T @ u_previous for norm, W in zip(norms,normalised_residual_weight_array)]
        residual_weight_array = [W - lmbda * A_j for W, lmbda in zip(residual_weight_array, lambda_i_array)]

        # Accumulate the reconstructed weights
        reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        self.current_reconstructed_weight_array = reconstructed_weight_array
        self.current_residual_weight_array = residual_weight_array
        self.steps += 1

        self.num_group.append(1)
        self.cal_memory_footprint_compressed_array()
        
        return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array]

    
    # stacking weight matrices of 4 gates
    def iterative_approximation_stack(self):
        residual_weight = self.current_residual_weight
        reconstructed_weight = self.current_reconstructed_weight

        # Update SVD on the error matrix
        U_n, S_n, Vt_n = svd(residual_weight, full_matrices=False,lapack_driver='gesdd')
        sigma1_n = S_n[0]
        u1_n = U_n[:, 0]
        v1_n = Vt_n[0, :]

        # Update the binary mask matrix Fi
        Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, self.NZc, self.Tc)
        Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, self.num_weights*self.NZr, self.Tr)


        # Update the weight matrix approximation
        reconstructed = reconstructed_weight + sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        residual = residual_weight - sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        
        self.current_reconstructed_weight = reconstructed
        self.current_residual_weight = residual
        self.steps += 1

        self.num_group.append(self.num_weights)

        self.cal_memory_footprint_compressed_weight()

        return [reconstructed[i*self.R:(i+1)*self.R,0:self.C] for i in range(self.num_weights)]

    
    def iterative_approximation_stack_norm(self, norm='fro'):
        residual_weight = self.current_residual_weight
        reconstructed_weight = self.current_reconstructed_weight

        residual_weight_array = [self.current_residual_weight[i*self.R:(i+1)*self.R,0:self.C] for i in range(self.num_weights)]

        normalised_residual_weight_array = [np.zeros_like(W) for W in residual_weight_array]
        normalised_residual_weight = np.zeros_like(residual_weight)

        # Normalize each weight matrix
        norms = []
        for i in range(len(residual_weight_array)):
            if norm == 'fro':
                current_norm = np.linalg.norm(residual_weight_array[i], 'fro')
            elif norm == 'spec':
                current_norm = np.linalg.norm(residual_weight_array[i], 2)
            else:
                raise ValueError("Unsupported norm type. Use 'fro' for Frobenius or 'spec' for spectral.")
            norms.append(current_norm)
            normalised_residual_weight_array[i] = residual_weight_array[i] / current_norm if current_norm != 0 else residual_weight_array[i]
        
        normalised_residual_weight[0:self.num_weights*self.R,0:self.C] = np.vstack([normalised_residual_weight_array[i] for i in range(self.num_weights)])

        # Update SVD on the error matrix
        U_n, S_n, Vt_n = svd(normalised_residual_weight, full_matrices=False,lapack_driver='gesdd')
        sigma1_n = S_n[0]
        u1_n = U_n[:, 0]
        v1_n = Vt_n[0, :]

        # Update the binary mask matrix Fi
        Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, self.NZc, self.Tc)
        Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, self.num_weights*self.NZr, self.Tr)

        for i in range(self.num_weights):
            u1_n[i*self.R:(i+1)*self.R] = norms[i] * u1_n[i*self.R:(i+1)*self.R]

        # Update the weight matrix approximation        
        self.current_reconstructed_weight = reconstructed_weight + sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        self.current_residual_weight = residual_weight - sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        self.steps += 1

        self.num_group.append(self.num_weights)

        self.cal_memory_footprint_compressed_weight()
        
        return [self.current_reconstructed_weight[i*self.R:(i+1)*self.R,0:self.C] for i in range(self.num_weights)]

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

# random_matrix1 = np.random.rand(512, 512)
# random_matrix2 = np.random.rand(512, 512)
# random_matrix3 = np.random.rand(512, 512)

# W = [random_matrix1,random_matrix2,random_matrix3]

# W32 = WeightArray(W,'weight',0.001,1,1,512,512)
# W32.init_precision(32)

# for i in range(10):
#     for j in range(10):
#         WW_32 = W32.iterative_approximation(3,'spec')

#     print(W32.average_mse_weight()) 
