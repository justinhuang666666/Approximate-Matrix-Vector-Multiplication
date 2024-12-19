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
from low_precision_utils import quant_svd

class QuantLinear(nn.Linear):
    def __init__(self, in_features, out_features, bias=True, device=None, dtype=None, weight_wl = 8, weight_quant_method="range_based", act_wl = 8, act_quant_method="range_based"):
        super(QuantLinear, self).__init__(in_features, out_features, bias, device, dtype)
        self.weight_wl = weight_wl
        self.weight_quant_method = weight_quant_method
        self.act_wl = act_wl
        self.act_quant_method = act_quant_method

    def forward(self, input):
        return functional.quant_linear.apply(input, self.weight, self.bias, self.weight_wl, self.weight_quant_method, self.act_wl, self.act_quant_method)

    @classmethod
    def from_full_precision(self, module, weight_wl, weight_quant_method, act_wl, act_quant_method):
        l = QuantLinear(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, weight_wl, weight_quant_method, act_wl, act_quant_method)
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
    def __init__(self, in_features, out_features, bias=True, device=None, dtype=None, rank=512, weight_wl=8, weight_quant_method="range_based", act_wl=8, act_quant_method="range_based"):
        super(QuantLinearSVD, self).__init__(in_features, out_features, bias, device, dtype)

        # Initialize parameters for U and V matrices
        self.U_full = nn.Parameter(torch.empty(out_features, rank, device=device, dtype=dtype))
        self.V_full = nn.Parameter(torch.empty(rank, in_features, device=device, dtype=dtype))
        self.U = nn.Parameter(torch.empty(out_features, rank, device=device, dtype=dtype))
        self.V = nn.Parameter(torch.empty(rank, in_features, device=device, dtype=dtype))
        
        # Initialize weights and quantization scheme
        self.weight_wl = weight_wl
        self.weight_quant_method = weight_quant_method
        self.act_wl = act_wl
        self.act_quant_method = act_quant_method
        self.rank = rank

    def forward(self, input):
        qu = self.U
        qv = self.V

        input_shape = input.shape

        input = input.view(-1, input_shape[-1])
        input_type = input.dtype
        
        # Quantization
        # qinput = self.quant_scheme.act.quant(input)
        # qu = self.quant_scheme.weight.quant(self.U)
        # qv = self.quant_scheme.weight.quant(self.V)

        _, qinput, _ = quantisation_wrapper(input, self.act_wl, self.act_quant_method)

        # Convert bias to a compatible data type
        if self.bias is not None:
            bias = self.bias.to(torch.bfloat16)

        temp_output = qinput @ qv.T  # This will be of shape [15, 200]

        _, temp_output, _ = quantisation_wrapper(temp_output, self.act_wl, self.act_quant_method)


        output = temp_output @ qu.T  # This will be of shape [15, 512]

        # Add bias if provided
        if self.bias is not None:
            output += self.bias

        _, outupt, _ = quantisation_wrapper(outupt, self.act_wl, self.act_quant_method)

        return output.view(*input_shape[:-1], -1)
    
    @classmethod
    def from_full_precision1(self, module, U, V, rank, weight_wl, weight_quant_method, act_wl, act_quant_method):
        l = QuantLinearSVD(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, rank, weight_wl, weight_quant_method, act_wl, act_quant_method)
        l.weight = module.weight
        l.U_full = nn.Parameter(U.to(module.weight.device))  # Wrap U as a torch.nn.Parameter
        l.V_full = nn.Parameter(V.to(module.weight.device))  # Wrap V as a torch.nn.Parameter

        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l
    
    def change_rank(self, rank):
        self.U = nn.Parameter(self.U_full[:, 0:rank])  # Wrap U as a torch.nn.Parameter
        self.V = nn.Parameter(self.V_full[0:rank, :])  # Wrap V as a torch.nn.Parameter

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


