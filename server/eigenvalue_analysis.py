import torch
from transformers import MarianTokenizer, MarianMTModel
import numpy as np
import pandas as pd

# Load the model and tokenizer
model_name = "Helsinki-NLP/opus-mt-en-de"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)
model.eval()

# Check if GPU is available and move model to GPU if possible
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Device:", device)
model.to(device)

# Dictionary to store eigenvalues grouped by layers
eigenvalues_dict = {}

# Loop through each layer in the encoder
for idx, layer in enumerate(model.model.encoder.layers):
    layer_name = f"Encoder_Layer_{idx+1}"
    eigenvalues_dict[layer_name] = {}
    
    # Extract the k_proj, q_proj, v_proj weight matrices
    k_proj_weights = layer.self_attn.k_proj.weight.detach().cpu().numpy()
    q_proj_weights = layer.self_attn.q_proj.weight.detach().cpu().numpy()
    v_proj_weights = layer.self_attn.v_proj.weight.detach().cpu().numpy()
    
    # Compute eigenvalues and their magnitudes
    k_proj_eigenvalues = np.abs(np.linalg.eigvals(k_proj_weights))
    q_proj_eigenvalues = np.abs(np.linalg.eigvals(q_proj_weights))
    v_proj_eigenvalues = np.abs(np.linalg.eigvals(v_proj_weights))
    
    # Store eigenvalue magnitudes in the dictionary
    eigenvalues_dict[layer_name]['k_proj'] = k_proj_eigenvalues
    eigenvalues_dict[layer_name]['q_proj'] = q_proj_eigenvalues
    eigenvalues_dict[layer_name]['v_proj'] = v_proj_eigenvalues

    print(f"Processed {layer_name}")

# Convert eigenvalues dictionary into a DataFrame for better visualization and storage
eigenvalues_data = []

for layer, projections in eigenvalues_dict.items():
    for proj_type, eigenvalues in projections.items():
        for value in eigenvalues:
            eigenvalues_data.append({
                "Layer": layer,
                "Projection": proj_type,
                "Eigenvalue Magnitude": value
            })

eigenvalues_df = pd.DataFrame(eigenvalues_data)

# Save the results to a CSV file
eigenvalues_df.to_csv("encoder_eigenvalues.csv", index=False)

print("Eigenvalues recorded and saved to 'encoder_eigenvalues.csv'.")
