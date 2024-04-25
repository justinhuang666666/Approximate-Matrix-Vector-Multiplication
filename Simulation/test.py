# Implementation of paper "Synthesis and Optimization of 2D Filter Designs for Heterogeneous FPGAs"

import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
import numpy as np
from utils.mse import *
from utils.mask_gen import *
from utils.load_matrix import *
from utils.generate_groupings import *
from iterative_approximation.Algorithm2 import *

class WeightArrayStepPruning:
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

        if method:
            self.original_weight = np.vstack(weight)
            self.current_residual_weight = np.vstack(weight)
            self.current_reconstructed_weight = np.vstack([np.zeros_like(W) for W in weight])
            self.padding1()
            self.cal_memory_footprint_baseline2()
            
        else:
            self.original_weight_array = weight  # Initialize the weight attribute
            self.current_residual_weight_array = weight 
            self.current_reconstructed_weight_array = [np.zeros_like(W) for W in weight]
            self.padding()

            self.cal_memory_footprint_baseline()
        
    
    def init_precision(self, precision):
        self.precision = precision
    ############################################################################################
    # stacking weight matrices of 4 gates
    def iterative_approximation_step3(self):

        residual_weight_array_step = [np.zeros_like(W) for W in self.current_residual_weight]
        reconstructed_weight_array_step = [np.zeros_like(W) for W in self.current_reconstructed_weight]

        residual_weight = np.vstack(self.current_residual_weight)
        reconstructed_weight = np.vstack(self.current_reconstructed_weight)

        # Update SVD on the error matrix
        U_n, S_n, Vt_n = np.linalg.svd(residual_weight, full_matrices=False)
        sigma1_n = S_n[0]
        u1_n = U_n[:, 0]
        v1_n = Vt_n[0, :]

        # Update the binary mask matrix Fi
        Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, self.NZc, self.Tc)
        Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, self.NZr, self.Tr)

        # Update the weight matrix approximation
        reconstructed = reconstructed_weight + sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        residual = residual_weight - sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
        
        self.current_reconstructed_weight = reconstructed
        self.current_residual_weight = residual
        self.steps += 1

        self.num_group.append(4)

        self.cal_memory_footprint_compressed2()
        
        return reconstructed[0:4*self.R,0:self.C]
    
    ############################################################################################

    def cal_memory_footprint_baseline(self):     
        self.memory_footprint_baseline = len(self.original_weight_array) * self.R * self.C * self.precision
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_baseline2(self):     
        self.memory_footprint_baseline = 4* self.R * self.C * self.precision
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed(self):
        self.memory_footprint_compressed += (self.num_group[-1] * (self.NZr * self.Tr + self.NZc * self.Tc) + len(self.original_weight_array)) * self.precision
    
    def cal_memory_footprint_compressed2(self):
        self.memory_footprint_compressed += ((4 * self.NZr * self.Tr + self.NZc * self.Tc) + 1) * self.precision
    
    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed

    def average_mse(self):  
        return mean_square_error_array1(self.original_weight_array,self.current_reconstructed_weight_array) 
    
    def individual_mse(self):  
        return mean_square_error_array(self.original_weight_array,self.current_reconstructed_weight_array) 
    
    def padding(self):
        Tr = self.Tr
        Tc = self.Tc

        # Add padding if needed
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

    def padding1(self):
        Tr = self.Tr
        Tc = self.Tc

        # Add padding if needed
        pad_rows = self.R % Tr
        pad_cols = self.C % Tc

        # Pad rows if the number of rows is not a multiple of Tr
        if pad_rows > 0:
            self.current_reconstructed_weight = np.vstack((self.current_reconstructed_weight, np.zeros((pad_rows, self.C))))
            self.current_residual_weight = np.vstack((self.current_residual_weight, np.zeros((pad_rows, self.C))))

        # Pad columns if the number of columns is not a multiple of Tc
        if pad_cols > 0:
            self.current_reconstructed_weight= np.hstack((self.current_reconstructed_weight, np.zeros((self.current_reconstructed_weight.shape[0], Tc - pad_cols))))
            self.current_residual_weight= np.hstack((self.current_residual_weight, np.zeros((self.current_residual_weight.shape[0], Tc - pad_cols))))


file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_i.txt'
W1_i = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_f.txt'
W1_f = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_o.txt'
W1_o = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_c.txt'
W1_c = load_matrix(file_path)

file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_i.txt'
H1_i = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_f.txt'
H1_f = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_o.txt'
H1_o = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_c.txt'
H1_c = load_matrix(file_path)

weight_array = [np.hstack([W1_i.T,H1_i.T]), np.hstack([W1_f.T,H1_f.T]), np.hstack([W1_o.T,H1_f.T]), np.hstack([W1_c.T,H1_c.T])]
W = WeightArrayStepPruning(weight_array,1,0.0001,7,41,5,1)
WW = W.iterative_approximation_step3()
WW = W.iterative_approximation_step3()
WW = W.iterative_approximation_step3()

print(mean_square_error_matrix(W.original_weight,WW))
print(W.current_residual_weight.shape)
print(W.memory_footprint_compressed)