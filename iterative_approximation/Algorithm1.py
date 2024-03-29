import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
import numpy as np
from utils.mse import *
from utils.mask_gen import *

class Weight:
    def __init__(self):
        self.weight = None  # Initialize the weight attribute

        self.required_steps = 0
        self.precision = 32
        self.memory_footprint_baseline = 0
        self.memory_footprint_compressed = 0
    
    def init_weight(self, weight):
        self.weight = weight
        self.transpose()
        self.cal_memory_footprint_baseline()
    
    def init_precision(self, precision):
        self.precision = precision

    def parse_weight(self, file_path):
        """Parse weight matrix from a file and store it in a NumPy array."""
        # Assuming the file contains a matrix in a format that NumPy can read directly
        self.weight = np.genfromtxt(file_path, delimiter=' ', invalid_raise=False) 
        self.weight = np.transpose(self.weight)
        self.cal_memory_footprint_baseline()

    def return_weight(self):
        return self.weight
    
    def transpose(self):
        self.weight = np.transpose(self.weight)

    def iterative_approximation(self, mse_threshold, NZ, Nsteps, Tc, Tr):
        Wi = self.weight
        num_rows, num_cols = Wi.shape

        if NZ > num_cols:
            raise ValueError("NZ must not be greater than C")

        # Add padding if needed
        pad_rows = num_rows % Tr

        if pad_rows > 0:
            Wi = np.vstack((Wi, np.zeros((Tr - pad_rows, Wi.shape[1]))))

        R = Wi.shape[0]
        C = Wi.shape[1]

        # Perform SVD on Wi
        U, S, Vt = np.linalg.svd(Wi, full_matrices=False)
        sigma1 = S[0]
        u1 = U[:, 0]
        v1 = Vt[0, :]

        # Initialize the binary mask matrix Fi
        Fi, compressed_Fi = create_mask_vector(v1, NZ, 1)
        sigma1_v1 = sigma1 * v1
 
        # Apply the mask and create the initial low-rank approximation
        Wi_hat = sigma1 * np.outer(u1, Fi * v1)

        for n in range(2, Nsteps+1):
            # Compute the error matrix
            E = Wi - Wi_hat

            # Update SVD on the error matrix
            U_n, S_n, Vt_n = np.linalg.svd(E, full_matrices=False)
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_n, compressed_Fi_n = create_mask_vector(v1_n, NZ, 1)
            

            # Update the weight matrix approximation
            Wi_hat += sigma1_n * np.outer(u1_n, Fi_n * v1_n)
            sigma1_v1_n = sigma1_n * v1_n

            if(mean_square_error_matrix(self.weight,Wi_hat[0:self.weight.shape[0],0:self.weight.shape[1]]) < mse_threshold):
                self.required_steps = n
                break
        
        self.cal_memory_footprint_baseline()
        self.cal_memory_footprint_compressed(NZ, R, C)
        return Wi_hat[0:self.weight.shape[0],0:self.weight.shape[1]]
    
    def iterative_approximation_step(self, NZ, Nsteps, Tc, Tr):
        Wi = self.weight
        num_rows, num_cols = Wi.shape

        if NZ > num_cols:
            raise ValueError("NZ must not be greater than C")

        # Add padding if needed
        pad_rows = num_rows % Tr

        if pad_rows > 0:
            Wi = np.vstack((Wi, np.zeros((Tr - pad_rows, Wi.shape[1]))))

        R = Wi.shape[0]
        C = Wi.shape[1]

        # Perform SVD on Wi
        U, S, Vt = np.linalg.svd(Wi, full_matrices=False)
        sigma1 = S[0]
        u1 = U[:, 0]
        v1 = Vt[0, :]

        # Initialize the binary mask matrix Fi
        Fi, compressed_Fi = create_mask_vector(v1, NZ, 1)
        sigma1_v1 = sigma1 * v1

        # self.tile_array[0] = [self.tiling(sigma1_v1, Tc)]
        # self.tile_array[1] = [self.tiling(u1, Tr)]
        # self.tile_array[2] = [compressed_Fi]
 
        # Apply the mask and create the initial low-rank approximation
        Wi_hat = sigma1 * np.outer(u1, Fi * v1)

        for n in range(2, Nsteps):
            # Compute the error matrix
            E = Wi - Wi_hat

            # Update SVD on the error matrix
            U_n, S_n, Vt_n = np.linalg.svd(E, full_matrices=False)
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_n, compressed_Fi_n = create_mask_vector(v1_n, NZ, 1)
            

            # Update the weight matrix approximation
            Wi_hat += sigma1_n * np.outer(u1_n, Fi_n * v1_n)
            sigma1_v1_n = sigma1_n * v1_n

            # self.tile_array[0].append(self.tiling(sigma1_v1_n, Tc))
            # self.tile_array[1].append(self.tiling(u1_n, Tr))
            # self.tile_array[2].append(compressed_Fi_n) 
        
        self.required_steps = Nsteps

        self.cal_memory_footprint_baseline()
        self.cal_memory_footprint_compressed(NZ, R, C)
        
        return Wi_hat[0:self.weight.shape[0],0:self.weight.shape[1]]
    
    def iterative_approximation_step2(self, NZ_u, NZ_v, Nsteps, Tc, Tr):
        Wi = self.weight
        num_rows, num_cols = Wi.shape

        # Add padding if needed
        pad_rows = num_rows % Tr
        pad_cols = num_cols % Tc

        # Pad rows if the number of rows is not a multiple of Tr
        if pad_rows > 0:
            Wi = np.vstack((Wi, np.zeros((Tr - pad_rows, num_cols))))

        # Pad columns if the number of columns is not a multiple of Tc
        if pad_cols > 0:
            Wi = np.hstack((Wi, np.zeros((Wi.shape[0], Tc - pad_cols))))

        R = Wi.shape[0]
        C = Wi.shape[1]

        # Perform SVD on Wi
        U, S, Vt = np.linalg.svd(Wi, full_matrices=False)
        sigma1 = S[0]
        u1 = U[:, 0]
        v1 = Vt[0, :]

        # Initialize the binary mask matrix Fi
        Fi_v, compressed_Fi_v = create_mask_vector(v1, NZ_v, Tc)
        Fi_u, compressed_Fi_u = create_mask_vector(u1, NZ_u, Tr)
        sigma1_v1 = sigma1 * v1

        # self.tile_array[0] = [self.tiling(sigma1_v1, Tc)]
        # self.tile_array[1] = [self.tiling(u1, Tr)]
        # self.tile_array[2] = [compressed_Fi]
 
        # Apply the mask and create the initial low-rank approximation
        Wi_hat = sigma1 * np.outer(Fi_u * u1, Fi_v * v1)

        for n in range(2, Nsteps):
            # Compute the error matrix
            E = Wi - Wi_hat

            # Update SVD on the error matrix
            U_n, S_n, Vt_n = np.linalg.svd(E, full_matrices=False)
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1_n, NZ_v, Tc)
            Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1_n, NZ_u, Tr)           

            # Update the weight matrix approximation
            Wi_hat += sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
            sigma1_v1_n = sigma1_n * v1_n

            # self.tile_array[0].append(self.tiling(sigma1_v1_n, Tc))
            # self.tile_array[1].append(self.tiling(u1_n, Tr))
            # self.tile_array[2].append(compressed_Fi_n) 
        
        self.required_steps = Nsteps

        self.cal_memory_footprint_baseline()
        self.cal_memory_footprint_compressed2(NZ_u, NZ_v, R, C, Tr, Tc)
        
        return Wi_hat[0:self.weight.shape[0],0:self.weight.shape[1]]
    
    def iterative_approximation_step3(self, NZ_u, NZ_v, Nsteps):
        Wi = self.weight
        num_rows, num_cols = Wi.shape

        if NZ_v > num_cols:
            raise ValueError("NZ_v must not be greater than C")
        
        if NZ_u > num_rows:
            raise ValueError("NZ_u must not be greater than R")

        R = Wi.shape[0]
        C = Wi.shape[1]

        # Perform SVD on Wi
        U, S, Vt = np.linalg.svd(Wi, full_matrices=False)
        sigma1 = S[0]
        u1 = U[:, 0]
        v1 = Vt[0, :]

        # Initialize the binary mask matrix Fi
        Fi_v, compressed_Fi_v = create_mask_vector(v1, NZ_v, 1)
        Fi_u, compressed_Fi_u = create_mask_vector(u1, NZ_u, 1)
        sigma1_v1 = sigma1 * v1
 
        # Apply the mask and create the initial low-rank approximation
        Wi_hat = sigma1 * np.outer(Fi_u * u1, Fi_v * v1)

        for n in range(2, Nsteps):
            # Compute the error matrix
            E = Wi - Wi_hat

            # Update SVD on the error matrix
            U_n, S_n, Vt_n = np.linalg.svd(E, full_matrices=False)
            sigma1_n = S_n[0]
            u1_n = U_n[:, 0]
            v1_n = Vt_n[0, :]

            # Update the binary mask matrix Fi
            Fi_v_n, compressed_Fi_v_n = create_mask_vector(v1, NZ_v, 1)
            Fi_u_n, compressed_Fi_u_n = create_mask_vector(u1, NZ_u, 1)

            # Update the weight matrix approximation
            Wi_hat += sigma1_n * np.outer(Fi_u_n * u1_n, Fi_v_n * v1_n)
            sigma1_v1_n = sigma1_n * v1_n
        
        self.required_steps = Nsteps

        self.cal_memory_footprint_baseline()
        self.cal_memory_footprint_compressed3(NZ_u, NZ_v, R, C)
        
        return Wi_hat[0:self.weight.shape[0],0:self.weight.shape[1]]
    
    def cal_memory_footprint_baseline(self):
        self.memory_footprint_baseline = self.weight.shape[0] * self.weight.shape[1] * self.precision
        return self.memory_footprint_baseline
    
    def cal_memory_footprint_compressed(self, NZ, R, C):
        self.memory_footprint_compressed = self.required_steps * (NZ + R) * self.precision + int(C)
        return self.memory_footprint_compressed
    
    def cal_memory_footprint_compressed2(self, NZ_u, NZ_v, R, C, Tr, Tc):
        self.memory_footprint_compressed = self.required_steps * (NZ_u * Tr + NZ_v * Tc) * self.precision + int(R/Tr) + int(C/Tc)
        return self.memory_footprint_compressed
    
    def cal_memory_footprint_compressed3(self, NZ_u, NZ_v, R, C):
        self.memory_footprint_compressed = self.required_steps * (NZ_u + NZ_v) * self.precision + int(R) + int(C)
        return self.memory_footprint_compressed
    
    def tiling(self,vector, unroll_factor):
        tile_array = [vector[i:i + unroll_factor] for i in range(0, len(vector), unroll_factor)]
        return tile_array
    
    def compression_ratio(self):
        return self.memory_footprint_baseline / self.memory_footprint_compressed
    
    

