# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"

import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
import numpy as np
from utils.mse import *
from utils.mask_gen import *
from utils.load_matrix import *
from utils.generate_groupings import *
import matplotlib.pyplot as plt

class WeightArray:
    def __init__(self,weight):
        self.weight_array = weight  # Initialize the weight attribute
        
        self.required_steps = 0
        self.precision = 32
        self.memory_footprint_baseline = 0
        self.memory_footprint_compressed = 0   
        self.num_group = []
    
    def init_precision(self, precision):
        self.precision = precision

    def reset_memory_footprint_compressed(self):
        self.memory_footprint_compressed = 0

    def iterative_approximation(self, mse_threshold, Nsteps, threshold):
        weight_array = self.weight_array

        R = weight_array[0].shape[0]
        C = weight_array[0].shape[1]

        reconstructed_weight_array = [np.zeros_like(W) for W in weight_array]

        for j in range(1, Nsteps+1):
            summation_matrix = sum(W @ W.T for W in weight_array)

            # Perform SVD on the summation matrix
            U, S, Vt = np.linalg.svd(summation_matrix, full_matrices=False)
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in weight_array])
            U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            v = Vt[0,:]

            u_previous = np.zeros_like(u)
            v_previous = np.zeros_like(v)
            u_diff = threshold + 1
            v_diff = threshold + 1

            count = 0

            # Iterative approximation
            while u_diff > threshold or v_diff > threshold:
                # print('1')
                W_hat = np.column_stack([W @ v for W in weight_array])

                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                u = U[:, 0]

                W_hat = np.column_stack([W.T @ u for W in weight_array])
                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                v = Vt[0,:]

                u_diff = mean_square_error_vector(u, u_previous)
                v_diff = mean_square_error_vector(v, v_previous)

                u_previous = u
                v_previous = v
                count = count + 1
                if count > 500:
                    break

            A_j = np.outer(u_previous, v_previous)
            lambda_i_array = [v_previous.T @ W.T @ u_previous for W in weight_array]
            weight_array = [W - lmbda * A_j for W, lmbda in zip(weight_array, lambda_i_array)]

            # Accumulate the reconstructed weights
            reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]
            if np.mean(mean_square_error_array(self.weight_array,reconstructed_weight_array)) < mse_threshold:
                self.required_steps = j
                break

        self.cal_memory_footprint_baseline(R,C)
        self.cal_memory_footprint_compressed(R,C)
        
        return reconstructed_weight_array

    def iterative_approximation_step(self, Nsteps, threshold):
        self.reset_memory_footprint_compressed()
        weight_array = self.weight_array

        R = weight_array[0].shape[0]
        C = weight_array[0].shape[1]

        reconstructed_weight_array = [np.zeros_like(W) for W in weight_array]

        for j in range(1, Nsteps+1):
            summation_matrix = sum(W @ W.T for W in weight_array)

            # Perform SVD on the summation matrix
            U, S, Vt = np.linalg.svd(summation_matrix, full_matrices=False)
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in weight_array])
            U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            v = Vt[0,:]

            u_previous = np.zeros_like(u)
            v_previous = np.zeros_like(v)
            u_diff = threshold + 1
            v_diff = threshold + 1

            count = 0

            # Iterative approximation
            while u_diff > threshold or v_diff > threshold:
                # print('1')
                W_hat = np.column_stack([W @ v for W in weight_array])

                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                u = U[:, 0]

                W_hat = np.column_stack([W.T @ u for W in weight_array])
                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                v = Vt[0,:]

                u_diff = mean_square_error_vector(u, u_previous)
                v_diff = mean_square_error_vector(v, v_previous)

                u_previous = u
                v_previous = v
                count = count + 1
                if count > 500:
                    break

            A_j = np.outer(u_previous, v_previous)
            lambda_i_array = [v_previous.T @ W.T @ u_previous for W in weight_array]
            weight_array = [W - lmbda * A_j for W, lmbda in zip(weight_array, lambda_i_array)]

            # Accumulate the reconstructed weights
            reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        self.required_steps = Nsteps
        self.cal_memory_footprint_baseline(R,C)
        self.memory_footprint_compressed = Nsteps * (R + C + 4) * self.precision
        
        return reconstructed_weight_array
    
    def iterative_approximation_step_incremental(self, previous_weight_array, previous_reconstructed_weight_array, Nsteps, threshold):
        weight_array = previous_weight_array

        R = weight_array[0].shape[0]
        C = weight_array[0].shape[1]

        reconstructed_weight_array = previous_reconstructed_weight_array

        for j in range(1, Nsteps+1):
            summation_matrix = sum(W @ W.T for W in weight_array)

            # Perform SVD on the summation matrix
            U, S, Vt = np.linalg.svd(summation_matrix, full_matrices=False)
            u = U[:, 0]

            W_hat = np.column_stack([W.T @ u for W in weight_array])
            U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
            v = Vt[0,:]

            u_previous = np.zeros_like(u)
            v_previous = np.zeros_like(v)
            u_diff = threshold + 1
            v_diff = threshold + 1

            count = 0

            # Iterative approximation
            while u_diff > threshold or v_diff > threshold:
                # print('1')
                W_hat = np.column_stack([W @ v for W in weight_array])

                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                u = U[:, 0]

                W_hat = np.column_stack([W.T @ u for W in weight_array])
                U, S, Vt = np.linalg.svd(W_hat @ W_hat.T, full_matrices=False)
                v = Vt[0,:]

                u_diff = mean_square_error_vector(u, u_previous)
                v_diff = mean_square_error_vector(v, v_previous)

                u_previous = u
                v_previous = v
                count = count + 1
                if count > 500:
                    break

            A_j = np.outer(u_previous, v_previous)
            lambda_i_array = [v_previous.T @ W.T @ u_previous for W in weight_array]
            weight_array = [W - lmbda * A_j for W, lmbda in zip(weight_array, lambda_i_array)]

            # Accumulate the reconstructed weights
            reconstructed_weight_array = [RW + lmbda * A_j for RW, lmbda in zip(reconstructed_weight_array, lambda_i_array)]

        self.required_steps = Nsteps
        self.cal_memory_footprint_baseline(R,C)
        self.cal_memory_footprint_compressed(R,C)
        
        return weight_array, reconstructed_weight_array
    
    def hybrid_iterative_approximation_step(self, Nsteps, threshold):
        self.reset_memory_footprint_compressed()

        matrix_idx_list = [0,1,2,3]

        original_weight_array = self.weight_array

        R = original_weight_array[0].shape[0]
        C = original_weight_array[0].shape[1]

        weight_array_step = original_weight_array 
        reconstructed_weight_array_step = [np.zeros_like(W) for W in original_weight_array]

        # print(len(weight_array_step))
        # print(len(reconstructed_weight_array_step))
        for j in range(1, Nsteps+1):
            groupings = generate_groupings(matrix_idx_list)
            for idx, group in enumerate(groupings):
                # print('group')
                # print(group)
                weight_array_group = [np.zeros_like(W) for W in original_weight_array]
                reconstructed_weight_array_group = [np.zeros_like(W) for W in original_weight_array]
                for subset in group:
                    # print('subset')
                    # print(subset)
                    weight_array_subset = [weight_array_step[i] for i in subset]
                    reconstructed_weight_array_subset = [reconstructed_weight_array_step[i] for i in subset]
                    W1 = WeightArray(weight_array_subset)
                    weight_array_subset1,reconstructed_weight_array_subset1 = W1.iterative_approximation_step_incremental(weight_array_subset,reconstructed_weight_array_subset,1,threshold)
                    for i in range(len(subset)):
                        weight_array_group[subset[i]] = weight_array_subset1[i]
                        reconstructed_weight_array_group[subset[i]] = reconstructed_weight_array_subset1[i]
                previous_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array_step)
                current_MSE = mean_square_error_array1(original_weight_array,reconstructed_weight_array_group)
                current_ratio_MSE_mem = (previous_MSE-current_MSE)/(4+len(group)*(R+C))

                if idx == 0:
                    reconstructed_weight_array_step = reconstructed_weight_array_group
                    weight_array_step = weight_array_group
                    max_ratio_MSE_mem = current_ratio_MSE_mem
                    num_group_step = len(group)
                else:
                    if(current_ratio_MSE_mem > max_ratio_MSE_mem):
                        max_ratio_MSE_mem = current_ratio_MSE_mem
                        reconstructed_weight_array_step = reconstructed_weight_array_group
                        weight_array_step = weight_array_group
                        num_group_step = len(group)
            self.num_group.append(num_group_step)
            self.memory_footprint_compressed = self.memory_footprint_compressed + (num_group_step*(R+C) + 4) * self.precision

        self.cal_memory_footprint_baseline(R,C)
        return reconstructed_weight_array_step

    def transpose(self):
        self.weight = np.transpose(self.weight)

    def cal_memory_footprint_baseline(self, R, C):     
        self.memory_footprint_baseline = len(self.weight_array) * R * C * self.precision
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed(self, R, C):
        self.memory_footprint_compressed = (R + C + 4) * self.precision * self.required_steps
        return self.memory_footprint_compressed
    
    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed
    
    def set_memory_footprint_compressed(self,memory_footprint):
        self.memory_footprint_compressed = memory_footprint
    


    
    
    



    

