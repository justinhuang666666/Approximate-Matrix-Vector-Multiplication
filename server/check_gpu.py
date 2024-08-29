import torch

print(torch.cuda.is_available())  # Should return True if GPU is available
print(torch.cuda.device_count())  # Should return the number of GPUs
print(torch.cuda.current_device())  # Should return the index of the current GPU
print(torch.cuda.get_device_name(0))  # Should return the name of the GPU

print(torch.__version__)  # PyTorch version
print(torch.version.cuda)  # CUDA version