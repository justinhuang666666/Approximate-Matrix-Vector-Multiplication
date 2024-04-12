import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/Code')
from iterative_approximation.Algorithm2 import *
from iterative_approximation.Algorithm1 import *
from iterative_approximation.Algorithm2Step import *
from iterative_approximation.Algorithm2StepPruning import *
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


def evaluation1(weight_array):
    W = WeightArrayStep(weight_array, 0.001)
    W1 = WeightArrayStep(weight_array, 0.001)
    W2 = WeightArrayStep(weight_array, 0.001)
    W3 = WeightArrayStep(weight_array, 0.001)
    W4 = WeightArrayStep(weight_array, 0.001)
    W5 = WeightArrayStep(weight_array, 0.001)
    W6 = WeightArrayStep(weight_array, 0.001)

    colors = plt.cm.viridis(np.linspace(0, 1, 7))  

    Nsteps = range(1, 20)

    plt.figure(figsize=(10, 6))  # Set the figure size for better visibility

    # Initialize lists to store data points for plotting
    W_memory_footprints = []
    W_mses = []
    W1_memory_footprints = []
    W1_mses = []
    W2_memory_footprints = []
    W2_mses = []
    W3_memory_footprints = []
    W3_mses = []
    W4_memory_footprints = []
    W4_mses = []
    W5_memory_footprints = []
    W5_mses = []
    W6_memory_footprints = []
    W6_mses = []

    for step in Nsteps:
        W.iterative_approximation_step()
        # Accumulate data points
        W_memory_footprints.append(W.memory_footprint_compressed)
        W_mses.append(W.average_mse())

        W1.hybrid_iterative_approximation_step(1)
        W1_memory_footprints.append(W1.memory_footprint_compressed)
        W1_mses.append(W1.average_mse())

        W2.hybrid_iterative_approximation_step(2)
        W2_memory_footprints.append(W2.memory_footprint_compressed)
        W2_mses.append(W2.average_mse())

        W3.hybrid_iterative_approximation_step(3)
        W3_memory_footprints.append(W3.memory_footprint_compressed)
        W3_mses.append(W3.average_mse())
        
        W4.hybrid_iterative_approximation_step(4)
        W4_memory_footprints.append(W4.memory_footprint_compressed)
        W4_mses.append(W4.average_mse())

        W5.hybrid_iterative_approximation_step(5)
        W5_memory_footprints.append(W5.memory_footprint_compressed)
        W5_mses.append(W5.average_mse())

        W6.hybrid_iterative_approximation_step(6)
        W6_memory_footprints.append(W6.memory_footprint_compressed)
        W6_mses.append(W6.average_mse())

    # Plotting
    plt.plot(W_memory_footprints, W_mses, color=colors[0], label='Group of 4')
    plt.plot(W1_memory_footprints, W1_mses, color=colors[1], label='Hybrid Strategy 1')
    plt.plot(W2_memory_footprints, W2_mses, color=colors[2], label='Hybrid Strategy 2')
    plt.plot(W3_memory_footprints, W3_mses, color=colors[3], label='Hybrid Strategy 3')
    plt.plot(W4_memory_footprints, W4_mses, color=colors[4], label='Hybrid Strategy 4')
    plt.plot(W5_memory_footprints, W5_mses, color=colors[5], label='Hybrid Strategy 5')
    plt.plot(W6_memory_footprints, W6_mses, color=colors[6], label='Hybrid Strategy 6')

    # Adding labels, title, and legend
    plt.xlabel('Memory Footprint (Compressed)')
    plt.ylabel('Average MSE')
    plt.title('Evaluation of Approximation Strategies')
    plt.legend()

    # Display the plot
    plt.show()


def evaluation3(weight_array):
    W = WeightArrayStep(weight_array,0.0001)
    Nsteps = range(1, 51)
    
    for step in Nsteps:
        W.hybrid_iterative_approximation_step(6)
        
    # Get a color map and generate a color for each bar
    colors = cm.viridis(np.linspace(0, 1, len(Nsteps)))

    plt.figure(figsize=(10, 6))
    plt.bar(Nsteps, W.num_group, color=colors)
    plt.xlabel('Nstep')
    plt.ylabel('Number of Groups')
    plt.title('Number of Groups vs Nstep')
    plt.show()


def evaluation1(weight_array):
    W = WeightArrayStepPruning(weight_array,0.0001,7,9,5,5)
    W1 = WeightArrayStepPruning(weight_array,0.0001,7,9,5,5)

    colors = plt.cm.viridis(np.linspace(0, 1, 7))  

    Nsteps = range(0, 120)
    Nsteps1 = range(0, 30)

    plt.figure(figsize=(10, 6))  # Set the figure size for better visibility

    # Initialize lists to store data points for plotting
    W_memory_footprints = []
    W_mses = []
    W1_memory_footprints = []
    W1_mses = []

    for step in Nsteps1:
        W.iterative_approximation_step1()
        # Accumulate data points
        W_memory_footprints.append(W.memory_footprint_compressed)
        W_mses.append(W.average_mse())

    for step in Nsteps:

        W1.iterative_approximation_step2()
        W1_memory_footprints.append(W1.memory_footprint_compressed)
        W1_mses.append(W1.average_mse())

    # Plotting
    plt.plot(W_memory_footprints, W_mses, color=colors[0], label='Group of 4')
    plt.plot(W1_memory_footprints, W1_mses, color=colors[6], label='Group of 1')
    # Adding labels, title, and legend
    plt.xlabel('Memory Footprint (Compressed)')
    plt.ylabel('Average MSE')
    plt.title('Evaluation of Approximation Strategies')
    plt.legend()

    # Display the plot
    plt.show()

# evaluation1(weight_array)


weight_array = [np.hstack([W1_i.T,H1_i.T]), np.hstack([W1_f.T,H1_f.T]), np.hstack([W1_o.T,H1_f.T]), np.hstack([W1_c.T,H1_c.T])]

W = WeightArrayStepPruning(weight_array,'array',0.001,8,10,4,4)
WW = W.iterative_approximation_step2()
# WW = W.iterative_approximation_step2()

print(mean_square_error_array1(weight_array,WW))

