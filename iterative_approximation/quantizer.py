import torch
from torch import Tensor
import numpy as np
from numpy import ndarray

from logging import getLogger
from math import ceil
from typing import List

logger = getLogger(__name__)

# Forced torch gradient overrider
class MyClamp(torch.autograd.Function):
    @staticmethod
    def forward(ctx, input, min, max):
        return input.clamp(min=min, max=max)

    @staticmethod
    def backward(ctx, grad_output):
        grad_input = grad_output.clone()
        return grad_input, None, None


class MyRound(torch.autograd.Function):
    @staticmethod
    def forward(ctx, input):
        ctx.input = input
        return input.round()

    @staticmethod
    def backward(ctx, grad_output):
        grad_input = grad_output.clone()
        return grad_input


class MyFloor(torch.autograd.Function):
    @staticmethod
    def forward(ctx, input):
        ctx.input = input
        return input.floor()

    @staticmethod
    def backward(ctx, grad_output):
        grad_input = grad_output.clone()
        return grad_input


def integer_quantize(
    x: Tensor | ndarray | float | int, width: int, frac_width: int = None, is_signed: bool = True
):
    """
    - Do linear quantization to input according to a scale and number of bits
    - Note that `bias` can be negative or larger than `bits`
    """

    if frac_width is None:
        frac_width = width // 2

    if is_signed:
        int_min = -(2 ** (width - 1))
        int_max = 2 ** (width - 1) - 1
    else:
        int_min = 0
        int_max = 2**width - 1

    scale = 2**frac_width

    if isinstance(x, Tensor):
        return MyClamp.apply(MyRound.apply(x.mul(scale)), int_min, int_max).div(scale)
    elif isinstance(x, ndarray):
        # Convert ndarray to tensor for processing
        x = torch.from_numpy(x)
        result = MyClamp.apply(MyRound.apply(x.mul(scale)), int_min, int_max).div(scale)
        return result.numpy()  # Convert back to ndarray
    elif isinstance(x, (float, int)):
        # Perform quantization directly for scalar values
        quantized = MyClamp.apply(MyRound.apply(torch.tensor(x * scale)), int_min, int_max).item()
        return quantized / scale
    else:
        raise TypeError("Input must be a Tensor, ndarray, float, or int")
    
# x = np.array([0.7088208,0.45907321,0.99719009,0.18432462,0.31998074,0.57178874])
# quantized = integer_quantize(x, width=8, frac_width=8-4, is_signed=True)
# print(quantized)


# import unittest

# class TestIntegerQuantize(unittest.TestCase):
#     def test_tensor_quantization(self):
#         x = torch.tensor([0.25, 0.5, 0.75, 1.0])
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=True)
#         expected = torch.tensor([0.25, 0.5, 0.75, 1.0])
#         torch.testing.assert_close(quantized, expected, rtol=1e-2, atol=1e-2)

#     def test_ndarray_quantization(self):
#         x = np.array([0.25, 0.5, 0.75, 1.0])
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=True)
#         expected = np.array([0.25, 0.5, 0.75, 1.0])
#         np.testing.assert_allclose(quantized, expected, rtol=1e-2, atol=1e-2)

#     def test_float_quantization(self):
#         x = 0.3125
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=True)
#         expected = 0.3125
#         self.assertAlmostEqual(quantized, expected, places=4)

#     def test_int_quantization(self):
#         x = 2
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=True)
#         expected = 2.0
#         self.assertEqual(quantized, expected)

#     def test_unsigned_quantization_tensor(self):
#         x = torch.tensor([0.25, 0.5, 0.75, 1.0])
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=False)
#         expected = torch.tensor([0.25, 0.5, 0.75, 1.0])
#         torch.testing.assert_close(quantized, expected, rtol=1e-2, atol=1e-2)

#     def test_unsigned_quantization_ndarray(self):
#         x = np.array([0.25, 0.5, 0.75, 1.0])
#         quantized = integer_quantize(x, width=8, frac_width=4, is_signed=False)
#         expected = np.array([0.25, 0.5, 0.75, 1.0])
#         np.testing.assert_allclose(quantized, expected, rtol=1e-2, atol=1e-2)

#     def test_input_type_error(self):
#         with self.assertRaises(TypeError):
#             integer_quantize("invalid_input", width=8, frac_width=4, is_signed=True)

# if __name__ == '__main__':
#     unittest.main()