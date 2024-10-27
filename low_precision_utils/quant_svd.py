# from torch import nn
# from . import functional
# from . import quant 
import torch

import os
import sys

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(parent_dir)
from low_precision_utils import functional
from low_precision_utils import quant

def quant_svd(u,v,quant_scheme):
    qu = quant_scheme.weight.quant(u)
    qv = quant_scheme.weight.quant(v)

    reconstructed_matrix = torch.ger(u, v)

    quant_reconstructed_matrix = quant_scheme.weight.quant(reconstructed_matrix)

    return quant_reconstructed_matrix

def quantisation(input,quant_scheme):
    quant_input = quant_scheme.weight.quant(input)

    return quant_input
