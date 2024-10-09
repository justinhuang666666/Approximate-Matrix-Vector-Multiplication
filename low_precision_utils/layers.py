from torch import nn
from . import functional
from . import quant 
import torch

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

        self.rank = rank

        # Initialize parameters for U and V matrices
        self.U = nn.parameter(torch.empty(out_features, rank, device=device, dtype=dtype))
        self.V = nn.parameter(torch.empty(rank, in_features, device=device, dtype=dtype))

        # Initialize weights and quantization scheme
        self.quant_scheme = quant_scheme

    def forward(self, input):
        print("forward from QuantLinearSVD")
        return functional.quant_linear_svd.apply(input, self.U, self.V, self.bias, self.quant_scheme)

    @classmethod
    def from_full_precision(self, module, rank, quant_scheme):
        print(module)
        print(module.out_features)
        l = QuantLinearSVD(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme, rank)
        # Decompose the weight matrix into U and V
        U, V = compute_uv(module.weight.data, rank)
        l.U.data.copy_(U)
        l.V.data.copy_(V)

        print(l.U)
        print(l.V)
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


