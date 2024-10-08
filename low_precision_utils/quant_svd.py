import torch
import torch.nn as nn
from torch.autograd import Function
from . import quant

class QuantLinearSVDFunction(Function):
    @staticmethod
    def forward(ctx, input, U, V, bias=None, quant_scheme=None):
        """
        Forward pass for quantized linear transformation using SVD.

        Parameters:
            ctx: Context to save tensors for backward computation.
            input: Input tensor.
            U: Left singular matrix.
            V: Right singular matrix.
            bias: Optional bias tensor.
            quant_scheme: Quantization scheme for activations and weights.

        Returns:
            output: Transformed tensor after applying SVD-based linear layer.
        """
        # Save the matrices for backward pass
        ctx.save_for_backward(input, U, V, bias)
        ctx.quant_scheme = quant_scheme

        # Shape and data type handling
        input_shape = input.shape
        input = input.view(-1, input_shape[-1])

        # Quantization
        qinput = quant_scheme.act.quant(input)
        qu = quant_scheme.weight.quant(U)
        qv = quant_scheme.weight.quant(V)

        # Convert bias to a compatible data type
        if bias is not None:
            bias = bias.to(torch.bfloat16)

        # Perform matrix multiplication
        qvx = torch.matmul(qinput, qv.T)  # qv.T to match dimensions for multiplication
        qvx = quant_scheme.weight.quant(qvx)
        output = torch.matmul(qvx, qu.T)  # Multiplying by qu

        # Add bias if provided
        if bias is not None:
            output += bias

        return output.view(*input_shape[:-1], -1)

    @staticmethod
    def backward(ctx, grad_output):
        """
        Backward pass for quantized linear transformation using SVD.

        Parameters:
            ctx: Context with saved tensors from the forward pass.
            grad_output: Gradient of the loss with respect to the output.

        Returns:
            grad_input: Gradient of the loss with respect to the input.
            grad_U: Gradient of the loss with respect to U matrix.
            grad_V: Gradient of the loss with respect to V matrix.
            grad_bias: Gradient of the loss with respect to the bias.
            None: Placeholder for quant_scheme (not differentiable).
        """
        input, U, V, bias = ctx.saved_tensors
        quant_scheme = ctx.quant_scheme

        # Reshape grad_output to match the shape of qvx
        grad_output = grad_output.view(-1, grad_output.shape[-1])

        # Gradients for U, V, and input
        grad_qvx = torch.matmul(grad_output, U)  # Gradient w.r.t. qvx
        grad_input = torch.matmul(grad_qvx, V)  # Gradient w.r.t. input

        grad_U = torch.matmul(grad_output.T, grad_qvx)
        grad_V = torch.matmul(grad_qvx.T, input)

        # Gradient for bias if exists
        grad_bias = grad_output.sum(0) if bias is not None else None

        # Return gradients in the same order as inputs to forward
        return grad_input, grad_U, grad_V, grad_bias, None

# Usage example:
# Define the layer and set its weights
l = QuantLinearSVD(module.in_features, module.out_features, module.bias is not None, module.weight.device, module.weight.dtype, quant_scheme)
l.U.data.copy_(quantised_u)
l.V.data.copy_(quantised_v)
l.weight.data.copy_(module.weight.data)