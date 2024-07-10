# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"
import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code/main')

import numpy as np
from utils.mse import *
from utils.mask_gen import *
from utils.load_matrix import *
from utils.generate_groupings import *

import math

class IterativeApproximation:
    def __init__(self,weight,method,threshold,NZr,NZc,Tr,Tc):

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

        if method == 'weight':
            self.original_weight = np.vstack(weight)
            self.current_residual_weight = np.vstack(weight)
            self.current_reconstructed_weight = np.vstack([np.zeros_like(W) for W in weight])
            self.padding_weight()
            self.cal_memory_footprint_baseline_weight()

            self.U_S_Vt_storage = []
            self.mask_storage = []

            
        else: # method == 'array'
            self.original_weight_array = weight  # Initialize the weight attribute
            self.current_residual_weight_array = weight 
            self.current_reconstructed_weight_array = [np.zeros_like(W) for W in weight]
            self.padding_array()

            self.U_S_Vt_storage = [[] for _ in range(len(weight))]
            self.mask_storage = [[] for _ in range(len(weight))]

            self.cal_memory_footprint_baseline_array()
    
    def init_precision(self, precision):
        self.precision = precision

    def iterative_approximation_step1(self):
        residual_weight_array = self.current_residual_weight_array
        reconstructed_weight_array = self.current_reconstructed_weight_array

        residual_weight_array_step = [np.zeros_like(W) for W in residual_weight_array]
        reconstructed_weight_array_step = [np.zeros_like(W) for W in reconstructed_weight_array]

        for idx, (Wi, RWi) in enumerate(zip(residual_weight_array, reconstructed_weight_array)):
            # Update SVD on the error matrix
            U_n, S_n, Vt_n = np.linalg.svd(Wi, full_matrices=False)
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, self.NZc, self.Tc)
            Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, self.NZr, self.Tr)

            # self.U_S_Vt_storage.append((Fi_u_n * u1_n, sigma1_n, Fi_v_n * v1_n))
            # self.mask_storage.append((compressed_Fi_u_n, compressed_Fi_v_n))

            self.U_S_Vt_storage[idx].append((Fi_u_n * u1_n, sigma1_n, Fi_v_n * v1_n))
            self.mask_storage[idx].append((compressed_Fi_u_n, compressed_Fi_v_n))

            # Update the weight matrix approximation
            reconstructed = RWi + sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
            residual = Wi - sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)

            reconstructed_weight_array_step[idx] = reconstructed
            residual_weight_array_step[idx] = residual
        
        self.current_reconstructed_weight_array = reconstructed_weight_array_step
        self.current_residual_weight_array = residual_weight_array_step
        self.steps += 1

        self.num_group.append(4)

        self.cal_memory_footprint_compressed_array()
        
        return [W[0:self.R, 0:self.C] for W in reconstructed_weight_array_step]

    def cal_memory_footprint_baseline_array(self):     
        self.memory_footprint_baseline = len(self.original_weight_array) * self.R * self.C * self.precision 
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_baseline_weight(self):     
        self.memory_footprint_baseline = 4 * self.R * self.C * self.precision 
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed_array(self):
        self.memory_footprint_compressed += (self.num_group[-1] * (self.NZr * self.Tr + self.NZc * self.Tc) + len(self.original_weight_array)) * self.precision + (self.num_group[-1] * (math.ceil(self.C/self.Tc) + math.ceil(self.R/self.Tr)))
    
    def cal_memory_footprint_compressed_weight(self):
        self.memory_footprint_compressed += ((4 * self.NZr * self.Tr + self.NZc * self.Tc) + 1) * self.precision + ((math.ceil(self.C/self.Tc) + math.ceil(4*self.R/self.Tr)))

    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed

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


file_path = '../../LSTM-Human-Activity-Recognition-master/weights/W1_i.txt'
W1_i = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/W1_f.txt'
W1_f = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/W1_o.txt'
W1_o = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/W1_c.txt'
W1_c = load_matrix(file_path)

file_path = '../../LSTM-Human-Activity-Recognition-master/weights/H1_i.txt'
H1_i = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/H1_f.txt'
H1_f = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/H1_o.txt'
H1_o = load_matrix(file_path)
file_path = '../../LSTM-Human-Activity-Recognition-master/weights/H1_c.txt'
H1_c = load_matrix(file_path)

weight_array = [np.hstack([W1_i.T,H1_i.T]),np.hstack([W1_i.T,H1_i.T]),np.hstack([W1_i.T,H1_i.T]),np.hstack([W1_i.T,H1_i.T]),np.hstack([W1_i.T,H1_i.T])]


