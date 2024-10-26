# from torch import nn
# from . import functional
# from . import quant 
# import torch

import sys
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(current_dir)

from functional import *
from quant import *

def quant_svd(u,v,quant_scheme):
    qu = quant_scheme.weight.quant(u)
    qv = quant_scheme.weight.quant(v)

    reconstructed_matrix = qu @ qv

    quant_reconstructed_matrix = quant_scheme.weight.quant(reconstructed_matrix)

    return quant_reconstructed_matrix

def quantisation(input,quant_scheme):
    quant_input = quant_scheme.weight.quant(input)

    return quant_input
