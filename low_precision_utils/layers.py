from torch import nn
# from . import functional
# from . import quant 
import torch
from copy import deepcopy


import os
import sys

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)

# Add utility directories dynamically
sys.path.append(parent_dir)
from low_precision_utils import functional
from low_precision_utils import quant

class QuantLinear(nn.Linear):
    def __init__(self, in_features, out_features, bias=True, device=None, dtype=None, quant_scheme:"quant.QuantScheme" = None):
        super(QuantLinear, self).__init__(in_features, out_features, bias, device, dtype)
        self.quant_scheme = quant_scheme

    def forward(self, input):
        return functional.quant_linear.apply(input, self.weight, self.bias, self.quant_scheme)

    @classmethod
    def from_full_precision(self, module, quant_scheme):
        l = QuantLinear(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme)
        l.weight.data.copy_(module.weight.data)
        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l
    
# Assume compute_uv is a function that decomposes the weight matrix into U and V
def compute_uv(weight, rank):
    # Example SVD decomposition, you might want to refine this as needed
    U, S, V = torch.svd(weight)
    U = U[:, :rank]
    V = torch.mm(torch.diag(S[:rank]), V.t()[:rank, :])
    return U, V

class QuantLinearSVD(nn.Linear):
    def __init__(self, in_features, out_features, bias=True, device=None, dtype=None, quant_scheme:"quant.QuantScheme" = None, rank=0):
        super(QuantLinearSVD, self).__init__(in_features, out_features, bias, device, dtype)

        # Initialize parameters for U and V matrices
        self.U = nn.Parameter(torch.empty(out_features, rank, device=device, dtype=dtype))
        self.V = nn.Parameter(torch.empty(rank, in_features, device=device, dtype=dtype))
        # Initialize weights and quantization scheme
        self.quant_scheme = quant_scheme

        self.rank = rank

    def forward(self, input):
        input_shape = input.shape

        input = input.view(-1, input_shape[-1])
        input_type = input.dtype
        
        # Quantization
        qinput = self.quant_scheme.act.quant(input)
        qu = self.quant_scheme.weight.quant(self.U)
        qv = self.quant_scheme.weight.quant(self.V)

        print(qu.shape)
        print(qv.shape)
        

        # Convert bias to a compatible data type
        if self.bias is not None:
            bias = self.bias.to(torch.bfloat16)

        # Initialize output to zero tensor of correct shape and dtype
        qoutput = torch.zeros(input.shape[0], qu.shape[0], dtype=input_type, device=input.device)
        output = torch.zeros(input.shape[0], qu.shape[0], dtype=input_type, device=input.device)
        print(qinput.shape)

        # Initialize qoutput and output as zero tensors of the correct shape
        qoutput = torch.zeros(input.shape[0], qu.shape[0], dtype=input_type, device=input.device)
        output = torch.zeros(input.shape[0], qu.shape[0], dtype=input_type, device=input.device)

        for i in range(qu.shape[1]):
            # Perform matrix multiplication for each i
            vx = torch.matmul(qinput, qv[i, :].unsqueeze(1))  # qv[i, :].unsqueeze(1) to ensure [512, 1]
            print("vx shape:", vx.shape)  # Expected [15, 1]
            print("qu[:, i] shape:", qu[:, i].shape)  # Expected [512]

            qvx = self.quant_scheme.weight.quant(vx.squeeze(-1))  # Quantize vx and remove extra dimension
            output[:, i] = torch.matmul(qvx, qu[:, i])  # Multiply by qu[:, i] directly

        qoutput += self.quant_scheme.weight.quant(output)  # Quantize and accumulate in qoutput


        print(output.shape)
        # Add bias if provided
        if self.bias is not None:
            output += self.bias

        output = self.quant_scheme.weight.quant(output) ################

        return output.view(*input_shape[:-1], -1)

    @classmethod
    def from_full_precision(self, module, rank, quant_scheme):
        l = QuantLinearSVD(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme,rank)
        # Deep copy the weight and assign it
        l.weight = module.weight
        
        # Compute U, V and deep copy their values without nn.Parameter
        U, V = compute_uv(module.weight, rank)
        l.U = nn.Parameter(U)  # Wrap U as a torch.nn.Parameter
        l.V = nn.Parameter(V)

        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l
    
    @classmethod
    def from_full_precision1(self, module, U, V, rank, quant_scheme):
        l = QuantLinearSVD(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme,rank)
        l.weight = module.weight
        l.U = nn.Parameter(U)  # Wrap U as a torch.nn.Parameter
        l.V = nn.Parameter(V)  # Wrap V as a torch.nn.Parameter

        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l

class QuantConv1d(nn.Conv1d):
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, 
                 padding=0, dilation=1, groups=1, bias=True, padding_mode='zeros', 
                 device=None, dtype=None, quant_scheme:"quant.QuantScheme" = None):
        super(QuantConv1d, self).__init__(in_channels, out_channels, kernel_size, stride, padding, dilation, groups, bias, padding_mode, device, dtype)
        self.quant_scheme = quant_scheme

    def forward(self, input):
        return functional.quant_conv1d.apply(input, self.weight, self.bias, self.stride, self.padding, self.dilation, self.groups,
                                  self.quant_scheme)
    
    @classmethod
    def from_full_precision(self, module, quant_scheme):
        l = QuantConv1d(module.in_channels, module.out_channels, module.kernel_size, 
                        module.stride, module.padding, module.dilation, 
                        module.groups, module.bias is not None, module.padding_mode,
                        module.weight.device, module.weight.dtype, quant_scheme=quant_scheme)
        l.weight.data.copy_(module.weight.data)
        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l

class QuantConv2d(nn.Conv2d):
    def __init__(self, in_channels, out_channels, kernel_size, stride=1, 
                 padding=0, dilation=1, groups=1, bias=True, padding_mode='zeros', 
                 device=None, dtype=None, quant_scheme:"quant.QuantScheme" = None):
        super(QuantConv2d, self).__init__(in_channels, out_channels, kernel_size, stride, padding, dilation, groups, bias, padding_mode, device, dtype)
        self.quant_scheme = quant_scheme

    def forward(self, input):
        return functional.quant_conv2d.apply(input, self.weight, self.bias, self.stride, self.padding, self.dilation, self.groups,
                                    self.quant_scheme)

    @classmethod
    def from_full_precision(self, module, quant_scheme):
        l = QuantConv2d(module.in_channels, module.out_channels, module.kernel_size, 
                        module.stride, module.padding, module.dilation, 
                        module.groups, module.bias is not None, module.padding_mode,
                        module.weight.device, module.weight.dtype, quant_scheme=quant_scheme)
        l.weight.data.copy_(module.weight.data)
        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l


