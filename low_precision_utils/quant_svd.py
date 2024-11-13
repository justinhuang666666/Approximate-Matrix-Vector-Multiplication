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
    print(f"u: {u[0:5].numpy()}")
    print(f"v: {v[0:5].numpy()}")

    qu = quant_scheme.weight.quant(u)
    qv = quant_scheme.weight.quant(v)

    reconstructed_matrix = torch.ger(qu, qv)

    print(f"u quant: {u[0:5].numpy()}")
    print(f"v quant: {v[0:5].numpy()}")

    return reconstructed_matrix

def quantisation(input,quant_scheme):
    quant_input = quant_scheme.weight.quant(input)

    return quant_input
