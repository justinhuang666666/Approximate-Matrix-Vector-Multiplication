import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
from iterative_approximation.Algorithm2 import *
from iterative_approximation.Algorithm1 import *
import itertools
from utils.generate_groupings import *
import matplotlib.cm as cm

file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_i.txt'
W1_i = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_f.txt'
W1_f = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_o.txt'
W1_o = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/W1_c.txt'
W1_c = load_matrix(file_path)

file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_i.txt'
H1_i = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_f.txt'
H1_f = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_o.txt'
H1_o = load_matrix(file_path)
file_path = '../LSTM-Human-Activity-Recognition-master/weights/H1_c.txt'
H1_c = load_matrix(file_path)

weight_array = [np.hstack([W1_i.T,H1_i.T]), np.hstack([W1_f.T,H1_f.T]), np.hstack([W1_o.T,H1_f.T]), np.hstack([W1_c.T,H1_c.T])]

print(weight_array[0].shape)

def evaluation1(weight_array):
    W = WeightArray(weight_array)
    Nsteps = range(1, 100)

    MSE_values = {}  # Dictionary to hold MSE values for different thresholds
    threshold_list = [0.00001, 0.0001, 0.001, 0.01, 0.1]

    for threshold in threshold_list:
        MSE_values[threshold] = []  # Initialize an empty list for each threshold
        for Nstep in Nsteps:
            # Your function to get a reconstructed matrix
            reconstructed = W.iterative_approximation_step(Nstep, threshold)
            # Your function to calculate MSE
            MSE = mean_square_error_array(reconstructed, weight_array)
            MSE_values[threshold].append(np.mean(MSE))  # Store the average MSE for this threshold and Nstep

    # Plotting
    plt.figure(figsize=(10, 6))
    for threshold, mse_list in MSE_values.items():
        plt.plot(Nsteps, mse_list, label=f'Threshold = {threshold:.5f}')

    plt.xlabel('Nstep')
    plt.ylabel('Mean Squared Error')
    plt.yscale('log')
    plt.title('Average MSE vs Nstep for Different Thresholds')
    plt.legend()
    plt.grid(True)
    plt.show()

def evaluation2(weight_array, yscale='normal'):
    W = WeightArray(weight_array)
    Nsteps = range(1, 100)

    MSE_values = []  # List to hold MSE values for different Nsteps
    compression_ratio = []  # List to hold compression ratios for different Nsteps

    threshold = 0.0001

    for Nstep in Nsteps:
        # Your function to get a reconstructed matrix
        reconstructed = W.iterative_approximation_step(Nstep, threshold)
        # Your function to calculate MSE
        MSE = mean_square_error_array(reconstructed, weight_array)
        MSE_values.append(MSE)  # Store the MSE for this Nstep
        compression_ratio.append(W.compression_ratio())  # Store the compression ratio for this Nstep

    # Creating a figure to hold both subplots
    plt.figure(figsize=(20, 6))

    # Subplot 1: MSE vs Nstep
    plt.subplot(1, 2, 1)  # 1 row, 2 columns, 1st subplot
    colors = plt.cm.viridis(np.linspace(0, 1, len(weight_array)))
    for idx, weight in enumerate(weight_array):
        # Extract the MSE series for the current weight across all Nsteps
        mse_series = [MSE_values[step][idx] for step in range(len(Nsteps))]
        plt.plot(Nsteps, mse_series, color=colors[idx], label=f'Weight {idx + 1}')

    plt.xlabel('Nstep')
    plt.ylabel('Mean Squared Error')
    plt.title('MSE vs Nstep for Different Weights')
    if yscale == 'log':
        plt.yscale('log')
        plt.title('MSE vs Nstep for Different Weights (Log Scale)')
    plt.legend()
    plt.grid(True)

    # Subplot 2: Compression Ratio vs Nstep
    plt.subplot(1, 2, 2)  # 1 row, 2 columns, 2nd subplot
    plt.plot(Nsteps, compression_ratio, label='Compression Ratio', color='blue')
    plt.xlabel('Nstep')
    plt.ylabel('Compression Ratio')
    plt.title('Compression Ratio vs Nstep')
    plt.axhline(y=1, color='r', linestyle='--', label='Baseline Compression Ratio')  
    plt.grid(True)

    plt.show()

def evaluation3(weight_array):
    W1 = WeightArray(weight_array)

    W2 = Weight()
    weight = np.vstack([w for w in weight_array])
    W2.init_weight(weight)

    threshold = 0.0001

    MSE_list = np.linspace(0.001,0.05,50)
    compression_ratio1 = []
    compression_ratio2 = []

    for MSE in MSE_list:
        reconstructed = W1.iterative_approximation(MSE, 500, threshold)
        compression_ratio1.append(W1.compression_ratio())

        reconstructed = W2.iterative_approximation(MSE, 41, 500, 1, 1)
        compression_ratio2.append(W2.compression_ratio())

    # Now, plot the compression ratio against MSE
    plt.figure(figsize=(10, 6))
    plt.plot(MSE_list, compression_ratio1, marker='o', linestyle='-', color='blue', label='Algorithm 2 Compression Ratio')
    plt.plot(MSE_list, compression_ratio2, marker='o', linestyle='-', color='orange', label='Algorithm 1 Compression Ratio')
    plt.axhline(y=1, color='r', linestyle='--', label='Baseline Compression Ratio')  
    plt.xlabel('Mean Squared Error (MSE)')
    plt.ylabel('Compression Ratio')
    plt.title('Compression Ratio vs. MSE')
    plt.grid(True)
    plt.legend()
    plt.show()

def evaluation4(weight_array):
    matrix_idx_list = [0,1,2,3]
    threshold = 0.0001
    MSE_list = np.linspace(0.001,0.05,50)
    groupings = generate_groupings(matrix_idx_list)
    colors = cm.viridis(np.linspace(0, 1, len(groupings)))
    fig, ax = plt.subplots()
    for idx, group in enumerate(groupings):  # Skip the first grouping as per your original code
        average_compression_ratio = []
        for MSE in MSE_list:
            compression_ratio = []
            for subset in group:
                weight = [weight_array[i] for i in subset]
                W = WeightArray(weight)  # Assuming this is defined elsewhere
                W.iterative_approximation(MSE, 500, threshold)  # Assuming this modifies `W` in-place
                compression_ratio.append(W.compression_ratio())
            average_compression_ratio.append(np.mean(compression_ratio))
        
        # Plotting with a unique color and a label indicating the grouping
        ax.plot(MSE_list, average_compression_ratio, marker='o', linestyle='-', color=colors[idx], label='Grouping ' + str(group))

    ax.set_xlabel('MSE')  # Set X-axis label
    ax.set_ylabel('Average Compression Ratio')  # Set Y-axis label
    ax.set_title('Compression Ratios for Different Groupings')  # Set title
    ax.legend(loc='best', fontsize='small', title="Groupings")  # Add a legend with a title
    plt.show()

# def evaluation5(weight_array,step):
#     matrix_idx_list = [0,1,2,3]
#     threshold = 0.0001
#     W = WeightArray(weight_array)  # Assuming this is defined elsewhere
#     reconstructed_weight_array = [np.zeros_like(W) for W in weight_array]
#     weight_array_step1, reconstructed_weight_array_step1 = W.iterative_approximation_step_incremental(weight_array,reconstructed_weight_array,step,threshold)
#     compression_ratio_step1 = W.compression_ratio()
#     MSE_step1 = mean_square_error_array1(weight_array,reconstructed_weight_array_step1)

#     groupings = generate_groupings(matrix_idx_list)
#     colors = cm.viridis(np.linspace(0, 1, len(groupings)))
#     fig, ax = plt.subplots()

#     MSE_mem_ratio = []

#     fig, axs = plt.subplots(2, 1, figsize=(12, 5))  # Creating two subplots side by side
#     for idx, group in enumerate(groupings):  # Skip the first grouping as per your original code
#         average_compression_ratio = [compression_ratio_step1]
#         average_MSE = [MSE_step1]
#         MSE = []
       
#         for subset in group:
#             weight = [weight_array_step1[i] for i in subset]
#             reconstructed_weight_array_group = [reconstructed_weight_array_step1[i] for i in subset]
#             W1 = WeightArray(weight_array)  # Assuming this is defined elsewhere
#             W1.set_memory_footprint_compressed(32*step*(41+32+4))
#             weight_array_step2,reconstructed_weight_array_step2 = W1.iterative_approximation_step_incremental(weight,reconstructed_weight_array_group,1,threshold)
#             MSE.append(mean_square_error_array1([weight_array[i] for i in subset],reconstructed_weight_array_step2))
#         compression_ratio = 4*(32*41)/((32+41)*len(group)+4+(32+41+4)*step)
#         average_compression_ratio.append(compression_ratio)
#         average_MSE.append(np.mean(MSE))

#         MSE_mem_ratio.append((average_MSE[0] - average_MSE[1]) / ((32 + 41) * len(group) + 4))

#         axs[0].plot(average_MSE, average_compression_ratio, marker='o', linestyle='-', color=colors[idx], label='Grouping ' + str(group))

#     axs[0].set_xlabel('MSE')  # Set X-axis label
#     axs[0].set_ylabel('Average Compression Ratio')  # Set Y-axis label
#     axs[0].set_title('Compression Ratios vs MSE for Different Groupings')  # Set title
#     axs[0].legend(loc='best', fontsize='small', title="Groupings")  # Add a legend with a title

#     axs[1].bar(range(len(groupings)), MSE_mem_ratio, color=colors)
#     axs[1].set_xlabel('Group')
#     axs[1].set_ylabel('MSE per Mem Access')
#     axs[1].set_title('Ratio of MSE to Mem Access')
#     axs[1].set_xticks(range(len(groupings)))
#     axs[1].set_xticklabels([str(group) for group in groupings])
#     plt.show()

# def evaluation6(weight_array, yscale='normal'):
#     W1 = WeightArray(weight_array)
#     W = WeightArray(weight_array)
#     Nsteps = range(1, 30)

#     MSE_values = []  # List to hold MSE values for different Nsteps
#     MSE_values_hybrid = []  

#     threshold = 0.0001

#     compression_ratio = []
#     compression_ratio_hybrid = []  
#     for Nstep in Nsteps:
#         # Your function to get a reconstructed matrix
#         reconstructed = W.iterative_approximation_step(Nstep, threshold)
#         reconstructed_hybrid = W1.hybrid_iterative_approximation_step(Nstep, threshold)
#         # Your function to calculate MSE
#         MSE = mean_square_error_array1(reconstructed, weight_array)
#         MSE_values.append(MSE)  # Store the MSE for this Nstep
                
#         MSE_hybrid = mean_square_error_array1(reconstructed_hybrid, weight_array)
#         MSE_values_hybrid.append(MSE_hybrid)  # Store the MSE for this Nstep

#         compression_ratio.append(W.compression_ratio())
#         compression_ratio_hybrid.append(W1.compression_ratio())
#     # Creating a figure to hold both subplots
#     plt.figure(figsize=(20, 6))


#     plt.plot(Nsteps, MSE_values_hybrid, color='red', label=f'Hybrid')
#     plt.plot(Nsteps, MSE_values, color='blue', label=f'Normal')

#     plt.xlabel('Nstep')
#     plt.ylabel('Mean Squared Error')
#     plt.title('MSE vs Nstep for Different Weights')
#     if yscale == 'log':
#         plt.yscale('log')
#         plt.title('MSE vs Nstep for Different Weights (Log Scale)')
#     plt.legend()
#     plt.grid(True)
#     plt.show()
    
def evaluation6(weight_array, yscale='normal'):
    W1 = WeightArray(weight_array)
    W = WeightArray(weight_array)
    Nsteps = range(1, 30)

    MSE_values = []  # List to hold MSE values for different Nsteps
    MSE_values_hybrid = []  
    compression_ratio = []  # List to hold compression ratios for normal approximation
    compression_ratio_hybrid = []  # List to hold compression ratios for hybrid approximation
    threshold = 0.0001

    for Nstep in Nsteps:
        # Your function to get a reconstructed matrix
        reconstructed = W.iterative_approximation_step(Nstep, threshold)
        reconstructed_hybrid = W1.hybrid_iterative_approximation_step(Nstep, threshold)
        # Your function to calculate MSE
        MSE = mean_square_error_array1(reconstructed, weight_array)
        MSE_values.append(MSE)  # Store the MSE for this Nstep
        MSE_hybrid = mean_square_error_array1(reconstructed_hybrid, weight_array)
        MSE_values_hybrid.append(MSE_hybrid)  # Store the MSE for hybrid approximation

        compression_ratio.append(W.compression_ratio())  # Store compression ratio for this Nstep
        compression_ratio_hybrid.append(W1.compression_ratio())  # Store compression ratio for hybrid

    fig, axs = plt.subplots(1, 2, figsize=(20, 6))  # Creating two subplots

    # First subplot for MSE
    axs[0].plot(Nsteps, MSE_values_hybrid, color='red', label='Hybrid')
    axs[0].plot(Nsteps, MSE_values, color='blue', label='Normal')
    axs[0].set_xlabel('Nstep')
    axs[0].set_ylabel('Mean Squared Error')
    axs[0].set_title('MSE vs Nstep for Different Approximation Methods')
    if yscale == 'log':
        axs[0].set_yscale('log')
        axs[0].set_title('MSE vs Nstep (Log Scale)')
    axs[0].legend()
    axs[0].grid(True)

    # Second subplot for Compression Ratio
    axs[1].plot(Nsteps, compression_ratio_hybrid, color='red', label='Hybrid')
    axs[1].plot(Nsteps, compression_ratio, color='blue', label='Normal')
    axs[1].set_xlabel('Nstep')
    axs[1].set_ylabel('Compression Ratio')
    axs[1].set_title('Compression Ratio vs Nstep for Different Approximation Methods')
    axs[1].legend()
    axs[1].grid(True)

    plt.tight_layout()
    plt.show()

def evaluation7(weight_array):
    W = WeightArray(weight_array)
    Nsteps = range(1, 51)

    W.hybrid_iterative_approximation_step(50, 0.0001)
        
    # Get a color map and generate a color for each bar
    colors = cm.viridis(np.linspace(0, 1, len(Nsteps)))

    plt.figure(figsize=(10, 6))
    plt.bar(Nsteps, W.num_group, color=colors)
    plt.xlabel('Nstep')
    plt.ylabel('Number of Groups')
    plt.title('Number of Groups vs Nstep')
    plt.show()
        
# Average MSE vs Nstep for Different Thresholds
# evaluation1(weight_array)

# MSE vs Nstep for the Same Thresholds
# evaluation2(weight_array)

# MSE vs Nstep for the Same Thresholds (Log Scale)
# evaluation2(weight_array,'log')
    
# Compression Ratio across Different MSE value (collective approch using algorithm1 vs algorithm2)
# evaluation3(weight_array)

# Compression Ratio across Different MSE value (algorithm2 with different groupings)
# evaluation4(weight_array)
    
# Ratio of MSE to Mem Access Step1
# evaluation5(weight_array,1)
    
# Ratio of MSE to Mem Access Step1
# evaluation5(weight_array,1)

# Hybrid vs Normal
evaluation6(weight_array,'log')
    
# evaluation7(weight_array)


