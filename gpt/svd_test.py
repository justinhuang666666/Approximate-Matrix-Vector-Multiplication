import torch

def rank1_full_svd(A):
    # Full SVD decomposition
    U, S, Vh = torch.linalg.svd(A, full_matrices=False)
    sigma = S[0]
    u1 = U[:, 0].reshape(-1, 1) * torch.sqrt(sigma)
    v1 = Vh[0, :].reshape(1, -1) * torch.sqrt(sigma)
    A_approx = u1 @ v1
    return A_approx, u1, v1, sigma

def rank1_lowrank_svd(A):
    # Approximate rank-1 SVD
    U, S, V = torch.svd_lowrank(A, q=1, niter=2)
    sigma = S[0]
    u1 = U[:, 0].reshape(-1, 1) * torch.sqrt(sigma)
    v1 = V[0, :].reshape(1, -1) * torch.sqrt(sigma)
    A_approx = u1 @ v1
    return A_approx, u1, v1, sigma

# Generate a random 2048 x 2048 matrix
torch.manual_seed(0)
M1 = torch.randn(32, 32, dtype=torch.float64)
M2 = torch.randn(32, 32, dtype=torch.float64)

# Create 16x16 tiles = 512x512
tiles = []
for i in range(16):
    row = []
    for j in range(16):
        block = M1 if (i + j) % 2 == 0 else M2
        row.append(block)
    tiles.append(torch.cat(row, dim=1))
A = torch.cat(tiles, dim=0)

print("Shape of composed matrix:", A.shape)  # (512, 512)

# Method 1: Full SVD
A1, u1, v1, sigma1 = rank1_full_svd(A)

# Method 2: Low-rank SVD
A2, u2, v2, sigma2 = rank1_lowrank_svd(A)

print("u1",u1[0:40,0])
print("u2",u2[0:40,0])

# Print Frobenius norm difference between methods
print("Frobenius norm ||A1 - A2||:", torch.norm(A1 - A2).item())
