import torch
import numpy as np

import sys
sys.path.append('/Users/justin/Desktop/Imperial/Year 4/FYP/Code/main')
from quantize.integer import *

# Example input tensor
x = torch.tensor([0.1, 0.25, 0.5, 0.75, 1.0], dtype=torch.float32)

# Specify the quantization parameters
width = 8  # 8-bit quantization
frac_width = 4  # 4 bits for the fractional part
is_signed = True  # Signed quantization

# Perform integer quantization
quantized_x = integer_quantizer(x, width=width, frac_width=frac_width, is_signed=is_signed)

print("Original Tensor:", x)
print("Quantized Tensor:", quantized_x)
