# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"

import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
import numpy as np
from utils.mse import *
from utils.mask_gen import *
from utils.load_matrix import *
from utils.generate_groupings import *
from iterative_approximation.Algorithm2 import *

class WeightArrayStep:
    def __init__(self,weight,threshold):
        self.original_weight_array = weight  # Initialize the weight attribute
        self.R = weight[0].shape[0]
        self.C = weight[0].shape[1]

        self.precision = 32 # Initialize the precision (by default 32 bits per operand) and threshold
        self.threshold = threshold

        self.memory_footprint_baseline = 0

        self.memory_footprint_compressed = 0   
        self.num_group = [] # Array to store the num_group per approximation step
        self.steps = 0 # Counter of current step

        self.current_residual_weight_array = weight 
        self.current_reconstructed_weight_array = [np.zeros_like(W) for W in weight]

        self.cal_memory_footprint_baseline()
    
    def init_precision(self, precision):
        self.precision = precision

    def iterative_approximation_step(self):
        residual_weight_array = self.current_residual_weight_array

        reconstructed_weight_array = self.current_reconstructed_weight_array

        summation_matrix = sum(W @ W.T for W in residual_weight_array)

        # Perform SVD on the summation matrix
        U, S, Vt = np.linalg.svd(summation_matrix, full_matrices=False)
        u = U[:, 0]

        W_hat = np.column_stack([W.T @ u for W in residual_weight_array])
        U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
        v = Vt[0,:]

        u_previous = np.zeros_like(u)
        v_previous = np.zeros_like(v)

        threshold = self.threshold

        u_diff = threshold + 1
        v_diff = threshold + 1

        count = 0

        while u_diff > threshold or v_diff > threshold:
            W_hat = np.column_stack([W @ v for W in residual_weight_array])

            U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in residual_weight_array])
            U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            v = Vt[0,:]

            u_diff = mean_square_error_vector(u, u_previous)
            v_diff = mean_square_error_vector(v, v_previous)

            u_previous = u
            v_previous = v
            count = count + 1
            if count > 200:
                break

        A_j = np.outer(u_previous, v_previous)
        lambda_i_array = [v_previous.T @ W.T @ u_previous for W in residual_weight_array]
        residual_weight_array = [W - lmbda * A_j for W, lmbda in zip(residual_weight_array, lambda_i_array)]

        # Accumulate the reconstructed weights
        reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        self.current_reconstructed_weight_array = reconstructed_weight_array
        self.current_residual_weight_array = residual_weight_array
        self.steps += 1

        self.num_group.append(1)

        self.cal_memory_footprint_compressed()
        
        return reconstructed_weight_array
    
    def hybrid_iterative_approximation_step(self,strategy):
        threshold = self.threshold
    
        matrix_idx_list = list(range(len(self.original_weight_array)))

        original_weight_array = self.original_weight_array

        residual_weight_array = self.current_residual_weight_array 
        reconstructed_weight_array = self.current_reconstructed_weight_array

        groupings = generate_groupings(matrix_idx_list)

        for idx, group in enumerate(groupings):
            weight_array_group = [np.zeros_like(W) for W in original_weight_array]
            reconstructed_weight_array_group = [np.zeros_like(W) for W in original_weight_array]
            for subset in group:
                weight_array_subset = [residual_weight_array[i] for i in subset]
                reconstructed_weight_array_subset = [reconstructed_weight_array[i] for i in subset]
                W1 = WeightArray(weight_array_subset)
                weight_array_subset1,reconstructed_weight_array_subset1 = W1.iterative_approximation_step_incremental(weight_array_subset,reconstructed_weight_array_subset,1,threshold)
                for i in range(len(subset)):
                    weight_array_group[subset[i]] = weight_array_subset1[i]
                    reconstructed_weight_array_group[subset[i]] = reconstructed_weight_array_subset1[i]

            match strategy:
                case 1:
                    # Average MSE per mem access optimisation strategy
                    previous_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array)
                    current_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array_group)
                    current_ratio_MSE_mem = (previous_MSE-current_MSE) / (len(self.original_weight_array) + len(group) * (self.R + self.C))
                case 2:
                    # Large average MSE optimisation strategy
                    previous_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array)
                    current_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array_group)
                    current_ratio_MSE_mem = (previous_MSE-current_MSE)
                case 3:
                    # Prioritise largest matrix MSE per mem access optimisation strategy
                    previous_MSE = mean_square_error_array(original_weight_array,reconstructed_weight_array)
                    current_MSE = mean_square_error_array(original_weight_array,reconstructed_weight_array_group)
                    squared_MSE_diff = [(prev - curr)**2 for prev, curr in zip(previous_MSE, current_MSE)]
                    current_ratio_MSE_mem = sum(squared_MSE_diff) / (len(self.original_weight_array) + len(group) * (self.R + self.C))
                case 4:
                    # Prioritise largest matrix MSE optimisation strategy
                    previous_MSE = mean_square_error_array(original_weight_array,reconstructed_weight_array)
                    current_MSE = mean_square_error_array(original_weight_array,reconstructed_weight_array_group)
                    squared_MSE_diff = [(prev - curr)**2 for prev, curr in zip(previous_MSE, current_MSE)]
                    current_ratio_MSE_mem = sum(squared_MSE_diff)
                case 5:
                    # Fine-grained average MSE per mem access optimisation strategy
                    incremental_MSE_decrement = 0
                    for subset in group:
                        subset_reconstructed = [reconstructed_weight_array_group[i] for i in subset]
                        subset_original = [self.original_weight_array[i] for i in subset]
                        incremental_MSE_decrement += mean_square_error_array1(subset_original,subset_reconstructed)/(len(subset)+(self.R + self.C))
                    current_ratio_MSE_mem =  incremental_MSE_decrement 
                case 6:
                    current_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array_group)
                    current_ratio_MSE_mem = (0.01 - current_MSE) /((len(self.original_weight_array) + len(group) * (self.R + self.C)) + self.memory_footprint_compressed)

                case _:
                    print("Unknown Optimization Strategy")
            if idx == 0:
                reconstructed_weight_array_step = reconstructed_weight_array_group
                residual_weight_array_step = weight_array_group
                max_ratio_MSE_mem = current_ratio_MSE_mem
                num_group_step = len(group)
            else:
                if(current_ratio_MSE_mem > max_ratio_MSE_mem):
                    max_ratio_MSE_mem = current_ratio_MSE_mem
                    reconstructed_weight_array_step = reconstructed_weight_array_group
                    residual_weight_array_step = weight_array_group
                    num_group_step = len(group)


        self.num_group.append(num_group_step)
        self.steps += 1

        self.cal_memory_footprint_compressed()

        self.current_residual_weight_array = residual_weight_array_step
        self.current_reconstructed_weight_array = reconstructed_weight_array_step

        return reconstructed_weight_array_step

    def cal_memory_footprint_baseline(self):     
        self.memory_footprint_baseline = len(self.original_weight_array) * self.R * self.C * self.precision
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed(self):
        self.memory_footprint_compressed += (self.num_group[-1] * (self.R + self.C) + len(self.original_weight_array)) * self.precision
    
    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed

    def average_mse(self):  
        return mean_square_error_array1(self.original_weight_array,self.current_reconstructed_weight_array) 
    
    def individual_mse(self):  
        return mean_square_error_array(self.original_weight_array,self.current_reconstructed_weight_array) 


