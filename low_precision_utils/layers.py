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
    def __init__(self, in_features, out_features, rank, bias=True, device=None, dtype=None, quant_scheme=None):
        super(QuantLinearSVD, self).__init__(in_features, out_features, bias=bias, device=device, dtype=dtype)

        self.rank = rank

        # Initialize parameters for U and V matrices
        self.U = nn.Parameter(torch.empty(out_features, rank, device=device, dtype=dtype))
        self.V = nn.Parameter(torch.empty(rank, in_features, device=device, dtype=dtype))

        # Initialize weights and quantization scheme
        self.quant_scheme = quant_scheme

    @classmethod
    def from_full_precision(cls, module, rank, quant_scheme):
        l = QuantLinearSVD(module.in_features, module.out_features, rank, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme)
        # Decompose the weight matrix into U and V
        U, V = compute_uv(module.weight.data, rank)
        l.U.data.copy_(U)
        l.V.data.copy_(V)
        if module.bias is not None:
            l.bias.data.copy_(module.bias.data)
        return l

    def forward(self, input):
        return functional.quant_linear_svd.apply(input, self.U, self.V, self.bias, self.quant_scheme)



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

class QuantSelfAttention(nn.Module):
    def __init__(self, embed_dim, num_heads, quant_scheme=None, dropout=0.0):
        super(QuantSelfAttention, self).__init__()
        self.embed_dim = embed_dim
        self.num_heads = num_heads
        self.head_dim = embed_dim // num_heads
        assert self.head_dim * num_heads == embed_dim, "Embedding dimension must be divisible by number of heads"

        # Define the quantization scheme
        self.quant_scheme = quant_scheme

        # Create quantized linear layers for query, key, and value projections
        self.q_proj = QuantLinear(embed_dim, embed_dim, quant_scheme=quant_scheme)
        self.k_proj = QuantLinear(embed_dim, embed_dim, quant_scheme=quant_scheme)
        self.v_proj = QuantLinear(embed_dim, embed_dim, quant_scheme=quant_scheme)

        # Output projection layer
        self.out_proj = QuantLinear(embed_dim, embed_dim, quant_scheme=quant_scheme)

        # Dropout layer
        self.dropout = nn.Dropout(dropout)

    def forward(self, query, key, value, attn_mask=None):
        # Compute query, key, and value projections
        query = self.q_proj(query)
        key = self.k_proj(key)
        value = self.v_proj(value)

        # Reshape into (batch_size, num_heads, seq_len, head_dim)
        batch_size, seq_length, _ = query.size()
        query = query.view(batch_size, seq_length, self.num_heads, self.head_dim).transpose(1, 2)
        key = key.view(batch_size, seq_length, self.num_heads, self.head_dim).transpose(1, 2)
        value = value.view(batch_size, seq_length, self.num_heads, self.head_dim).transpose(1, 2)

        # Compute attention scores
        attn_scores = torch.matmul(query, key.transpose(-2, -1)) / self.head_dim ** 0.5

        # Apply attention mask if provided
        if attn_mask is not None:
            attn_scores = attn_scores.masked_fill(attn_mask == 0, float('-inf'))

        # Compute attention weights
        attn_weights = F.softmax(attn_scores, dim=-1)
        attn_weights = self.dropout(attn_weights)

        # Compute attention output
        attn_output = torch.matmul(attn_weights, value)

        # Reshape back to (batch_size, seq_length, embed_dim)
        attn_output = attn_output.transpose(1, 2).contiguous().view(batch_size, seq_length, self.embed_dim)

        # Output projection
        attn_output = self.out_proj(attn_output)
        return attn_output

    @classmethod
    def from_full_precision(cls, module, quant_scheme):
        # Create a new QuantSelfAttention module with quantized sub-layers
        qsa = cls(module.embed_dim, module.num_heads, quant_scheme=quant_scheme, dropout=module.dropout.p)
        
        # Copy weights and biases from full precision module
        qsa.q_proj = QuantLinear.from_full_precision(module.q_proj, quant_scheme)
        qsa.k_proj = QuantLinear.from_full_precision(module.k_proj, quant_scheme)
        qsa.v_proj = QuantLinear.from_full_precision(module.v_proj, quant_scheme)
        qsa.out_proj = QuantLinear.from_full_precision(module.out_proj, quant_scheme)
        
        return qsa

# Assuming functional.quant_linear is defined elsewhere in your project or replace it with your own quantization operation.


