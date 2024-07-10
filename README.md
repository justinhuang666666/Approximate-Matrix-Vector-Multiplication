# Reconfigurable Computing for Approximate Matrix-Vector Multiplication
## A Hardware-Software Co-Design Approach

## Abstract
Matrix-vector multiplications are fundamental to a wide range of computational tasks, particularly in machine learning and scientific computing. When deployed on FPGA, these operations can become memory-bound when a large volume of matrices cannot be stored on-chip and has to be retrieved from off-chip. The project aims to address this challenge through a hardware-software co-design framework. Utilising various compression techniques, the framework aims to exploit the inherent redundancies in the given matrices to reduce memory requirements while considering the computational structure of the operations. From a hardware perspective, the framework employs a library of compression-aware and parametrisable compute engines to generate an accelerator that optimises hardware utilisation and computation latency. Given a set of matrix-vector multiplications with matrices and their input vectors, certain application accuracy requirements, and a target FPGA platform, the framework generates matrix decompositions and their corresponding hardware accelerators that minimise the latency of computing these matrix-vector products under hardware resource constraints.

## Directory Structure
Simualtion/ contains simulation files and results for this project
des_result/ contains design space exploration .csv files
iterative_approximation/ contains source code for a library of iterative approximation methods used in the project
utils/ contains utility scripts for matrix approximation
hardware/ contains hardware source code and related files (under development)

## Iterative Approximation

## Hardware Architecture

## Framework
