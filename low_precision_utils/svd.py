import torch
import os
import sys

def quant_svd(u, s, v, quant_scheme: "quant.QuantScheme" = None):
    # Ensure that u, s, and v are quantized using the provided quantization scheme
    u_type = u.dtype
    device = u.device

    qu = quant_scheme.weight.quant(u)    # Quantize U (left singular vector)
    qv = quant_scheme.weight.quant(v)    # Quantize V (right singular vector)
    # Adjust the dimensions of S to match the dimensions of qu and qv
    S = torch.diag(torch.full((qu.size(0),), s)).to(device) 
    qs = quant_scheme.weight.quant(S).to(device)

    qus = qs.mv(qu) #.mv(qv.t()).to(u_type)
    qreconstructed = qus @ qv.t()

    qqreconstructed = quant_scheme.weight.quant(qreconstructed).to(u_type)

    return qqreconstructed
