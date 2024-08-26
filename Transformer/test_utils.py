import onnx
import torch
import numpy as np
import thop
import matplotlib.pyplot as plt


# obtain a matrix of concatenated qkv-weights from an attention block
def get_attention_weights(atten_block):
    return np.array([atten_block.q_proj.weight.detach().clone().numpy(),
                     atten_block.k_proj.weight.detach().clone().numpy(),
                     atten_block.v_proj.weight.detach().clone().numpy()])

# plot number of macs and mse vs rank for a linear layer
def plot_macs_mse(layer, input_len=1, title=None):
    input_shape = (input_len, layer.in_features)
    svd_wrapper = SVDWrapper(layer)
    macs = []
    mse = []
    params = []
    ranks = list(range(1, svd_wrapper.max_rank+1))
    for rank in ranks:
        # macs.append(svd_wrapper.get_per_rank_macs() * rank * input_shape[0]) # * input_shape
        # mse.append(svd_wrapper.get_rank_mse(rank))
        # params.append(svd_wrapper.get_per_rank_params() * rank)
        macs.append(svd_wrapper.get_per_rank_macs() * rank * input_shape[0] / svd_wrapper.get_orignial_macs(input_shape)) # * input_shape
        mse.append(svd_wrapper.get_rank_mse(rank))
        params.append(svd_wrapper.get_per_rank_params() * rank / (layer.in_features * layer.out_features))

    # fig, ax = plt.subplots(1, 3, figsize=(15, 5))
    fig, ax = plt.subplots(1, 2, figsize=(15, 5))
    # plot macs & mse vs. ranks
    ax[0].plot(ranks, macs, label='macs')
    # ax[0].axhline(svd_wrapper.get_orignial_macs(input_shape), color='r', linestyle='--', label='original macs')
    ax[0].axhline(y=1, color='r', linestyle='--', label='original macs')
    ax[0].set_xlabel('rank')
    ax[0].set_ylabel('macs')
    sec_ax_0 = ax[0].twinx()
    sec_ax_0.plot(ranks, mse, '-g', label='mse')
    sec_ax_0.set_ylabel('mse')
    ax[0].legend()
    sec_ax_0.legend(loc=0)
    # plot params & mse vs. ranks
    ax[1].plot(ranks, params, label='params')
    # ax[1].axhline(layer.in_features * layer.out_features, color='r', linestyle='--', label='original params')
    ax[1].axhline(y=1, color='r', linestyle='--', label='original params')
    ax[1].set_xlabel('rank')
    ax[1].set_ylabel('params')
    sec_ax_1 = ax[1].twinx()
    sec_ax_1.plot(ranks, mse, '-g', label='mse')
    sec_ax_1.set_ylabel('mse')
    ax[1].legend()
    sec_ax_1.legend(loc=0)
    # # plot macs & params vs. ranks
    # ax[2].plot(ranks, macs, label='macs')
    # ax[2].axhline(svd_wrapper.get_orignial_macs(input_shape), color='r', linestyle='--', label='original macs')
    # ax[2].set_xlabel('rank')
    # ax[2].set_ylabel('macs')
    # sec_ax_2 = ax[2].twinx()
    # sec_ax_2.plot(ranks, params, label='params')
    # sec_ax_2.axhline(layer.in_features * layer.out_features, color='r', linestyle='--', label='original params')
    # title
    fig.suptitle(title)

def plot_decoder_layer_mse(layer, input_len=1, title=None, save_path=None):
    fig, ax = plt.subplots(2, 3, figsize=(15, 10))
    linear_layers = {
        'q': SVDWrapper(layer.self_attn.q_proj),
        'k': SVDWrapper(layer.self_attn.k_proj),
        'v': SVDWrapper(layer.self_attn.v_proj),
        'o': SVDWrapper(layer.self_attn.out_proj),
        'fc1': SVDWrapper(layer.fc1),
        'fc2': SVDWrapper(layer.fc2)
    }
    for i, (name, svd_wrapper) in enumerate(linear_layers.items()):
        input_shape = (input_len, svd_wrapper.in_features)
        macs_params = []
        mse = []
        ranks = list(range(1, svd_wrapper.max_rank+1))
        for rank in ranks:
            macs_params.append(svd_wrapper.get_per_rank_macs() * rank * input_shape[0] / svd_wrapper.get_orignial_macs(input_shape))
            mse.append(svd_wrapper.get_rank_mse(rank))

        ax[i//3, i%3].plot(ranks, macs_params, label='macs_params')
        ax[i//3, i%3].axhline(y=1, color='r', linestyle='--', label='original macs_params')
        ax[i//3, i%3].set_xlabel('rank')
        ax[i//3, i%3].set_ylabel('macs_params')
        sec_ax = ax[i//3, i%3].twinx()
        sec_ax.plot(ranks, mse, '-g', label='mse')
        sec_ax.set_ylabel('mse')
        ax[i//3, i%3].legend()
        sec_ax.legend(loc=0)
        ax[i//3, i%3].set_title(name)
    fig.suptitle(title)
    fig.tight_layout()
    if save_path is not None:
        plt.savefig(save_path)

def decompose_weight(unfolded_weight, rank_slice=None):
    
    if rank_slice is None:
        rank_slice = list(range(np.min(unfolded_weight.shape)))

    if(len(rank_slice) > np.min(unfolded_weight.shape)):
        print("Error: Rank slice is too large for rank")

    [u, s, vh] = np.linalg.svd(unfolded_weight, full_matrices=False)

    u_lowrank = u[ : , rank_slice]
    s_lowrank = s[rank_slice]
    vh_lowrank = vh[ rank_slice, : ]

    u_s_sqrt = np.zeros_like(u_lowrank)
    vh_s_sqrt = np.zeros_like(vh_lowrank)

    
    s_sqrt_diag = np.diag(np.sqrt(s_lowrank))
    u_s_sqrt = u_lowrank @ s_sqrt_diag
    vh_s_sqrt = s_sqrt_diag @ vh_lowrank

    return u_s_sqrt, vh_s_sqrt

class SVDWrapper():
    def __init__(self, original_matrix):
        if isinstance(original_matrix, np.ndarray):
            self.original_matrix = original_matrix
        if isinstance(original_matrix, torch.Tensor):
            self.original_matrix = original_matrix.detach().clone().numpy()
        elif isinstance(original_matrix, torch.nn.Linear):
            self.original_matrix = original_matrix.weight.detach().clone().numpy()
        else:
            print("Error: Unsupported input type")
        self.u_s_sqrt, self.vh_s_sqrt = decompose_weight(self.original_matrix)
        self.max_rank = np.min(self.original_matrix.shape)
        self.in_features = self.original_matrix.shape[1]

    def get_orignial_macs(self, input_len=1):
        # macs required for the original projection of an input
        if isinstance(input_len, int):
            shape = (input_len, self.original_matrix.shape[0])
        else:
            shape = input_len
        return shape[0] * self.original_matrix.shape[0] * self.original_matrix.shape[1]

    def get_per_rank_macs(self):
        # macs required to reconstruct a matrix (Do not reconstruct!)
        # return self.u_s_sqrt.shape[0] * 1 * self.vh_s_sqrt.shape[1]
        # x*u_s_sqrt_0*vh_s_sqrt_0 + x*u_s_sqrt_1*vh_s_sqrt_1 + ... + x*u_s_sqrt_R-1*vh_s_sqrt_R-1
        return self.u_s_sqrt.shape[0] + self.vh_s_sqrt.shape[1]
    
    def get_per_rank_params(self):
        # number of parameters in a rank
        return self.u_s_sqrt.shape[0] + self.vh_s_sqrt.shape[1]
    
    def get_rank_mse(self, rank):
        rank_slice = list(range(rank))
        return np.linalg.norm(self.u_s_sqrt[:, rank_slice] @ self.vh_s_sqrt[rank_slice, :] - self.original_matrix)
    
    