# Import the required libraries.
import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/main')
from iterative_approximation.Algorithm1 import *

import statistics

import os
import math
import random
import numpy as np
import datetime as dt
import tensorflow as tf
import seaborn as sn
from collections import deque
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn import metrics
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
import pandas as pd

from sklearn.model_selection import train_test_split

from tensorflow.keras.layers import *
from tensorflow.keras.models import Sequential
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.callbacks import EarlyStopping
from tensorflow.keras.utils import plot_model
from tensorflow.keras.models import save_model
from tensorflow.keras.models import load_model


features_train = np.load('data/features_train.npy')
features_test = np.load('data/features_test.npy')
labels_train = np.load('data/labels_train.npy')
labels_test = np.load('data/labels_test.npy')

lrcn = load_model('model/LRCN_model___Date_Time_2024_03_06__17_12_56___Loss_0.4536501467227936___Accuracy_0.8638743162155151.keras')

y_test = np.argmax(labels_test, axis=-1)
y_pred = np.argmax(lrcn(features_test), axis=1)
accuracy = accuracy_score(y_test, y_pred)

print(accuracy)

def approximate_weight2_step(Nsteps, NZ, Tr, Tc, layer):

    # For standard Keras LSTM layers, the ordering within these is [input_gate, forget_gate, cell_state, output_gate]
    kernel, recurrent_kernel, bias = layer.get_weights()

    input_len = kernel[:, :layer.units].shape[0]

    # Input gate weights and biases
    i = Weight()
    i.init_weight(np.vstack((kernel[:, :layer.units],recurrent_kernel[:, :layer.units])))
    i_approximated = i.iterative_approximation_step(NZ, Nsteps, Tc, Tr)

    W_i_approximated = i_approximated[:,:input_len]
    H_i_approximated = i_approximated[:,input_len:]

    f = Weight()
    f.init_weight(np.vstack((kernel[:, layer.units:layer.units*2],recurrent_kernel[:, layer.units:layer.units*2])))
    f_approximated = f.iterative_approximation_step(NZ, Nsteps, Tc, Tr)

    W_f_approximated = f_approximated[:,:input_len]
    H_f_approximated = f_approximated[:,input_len:]


    o = Weight()
    o.init_weight(np.vstack((kernel[:, layer.units*2:layer.units*3],recurrent_kernel[:, layer.units*2:layer.units*3])))
    o_approximated = o.iterative_approximation_step(NZ, Nsteps, Tc, Tr)

    W_o_approximated = o_approximated[:,:input_len]
    H_o_approximated = o_approximated[:,input_len:]

    c = Weight()
    c.init_weight(np.vstack((kernel[:, layer.units*3:],recurrent_kernel[:, layer.units*3:])))
    c_approximated = c.iterative_approximation_step(NZ, Nsteps, Tc, Tr)

    W_c_approximated = c_approximated[:,:input_len]
    H_c_approximated = c_approximated[:,input_len:]

    W_compression_ratio= statistics.mean([i.compression_ratio(), f.compression_ratio(), o.compression_ratio(), c.compression_ratio()])
    H_compression_ratio= statistics.mean([i.compression_ratio(), f.compression_ratio(), o.compression_ratio(), c.compression_ratio()])

    approximated_kernel = np.hstack((np.transpose(W_i_approximated), np.transpose(W_f_approximated), np.transpose(W_o_approximated), np.transpose(W_c_approximated)))
    approximated_recurrent_kernel = np.hstack((np.transpose(H_i_approximated), np.transpose(H_f_approximated), np.transpose(H_o_approximated), np.transpose(H_c_approximated)))

    return approximated_kernel, approximated_recurrent_kernel, W_compression_ratio, H_compression_ratio

def approximate_weight4_2_step(Nsteps, NZ, Tr, Tc, layer):

    # For standard Keras LSTM layers, the ordering within these is [input_gate, forget_gate, cell_state, output_gate]
    
    kernel, recurrent_kernel, bias = layer.get_weights()

    input_len = kernel[:, :layer.units].shape[0]

    input_hidden_len = input_len + recurrent_kernel[:, :layer.units].shape[0]

    w = np.vstack([kernel[:, :layer.units],recurrent_kernel[:, :layer.units]])
    f = np.vstack([kernel[:, layer.units:layer.units*2],recurrent_kernel[:, layer.units:layer.units*2]])
    o = np.vstack([kernel[:, layer.units*2:layer.units*3],recurrent_kernel[:, layer.units*2:layer.units*3]])
    c = np.vstack([kernel[:, layer.units*3:],recurrent_kernel[:, layer.units*3:]])

    # Input gate weights and biases
    W = Weight()
    W.init_weight(np.hstack([w,f,o,c]))
    W_approximated = W.iterative_approximation_step(NZ, Nsteps, Tc, Tr)

    i_approximated = W_approximated[:input_hidden_len,:]

    W_i_approximated = i_approximated[:,:input_len]
    H_i_approximated = i_approximated[:,input_len:]

    f_approximated = W_approximated[input_hidden_len:input_hidden_len*2,:]

    W_f_approximated = f_approximated[:,:input_len]
    H_f_approximated = f_approximated[:,input_len:]


    o_approximated = W_approximated[input_hidden_len*2:input_hidden_len*3,:]

    W_o_approximated = o_approximated[:,:input_len]
    H_o_approximated = o_approximated[:,input_len:]

    c_approximated = W_approximated[input_hidden_len*3:,:]

    W_c_approximated = c_approximated[:,:input_len]
    H_c_approximated = c_approximated[:,input_len:]

    W_compression_ratio= W.compression_ratio()
    H_compression_ratio= W.compression_ratio()

    approximated_kernel = np.hstack((np.transpose(W_i_approximated), np.transpose(W_f_approximated), np.transpose(W_o_approximated), np.transpose(W_c_approximated)))
    approximated_recurrent_kernel = np.hstack((np.transpose(H_i_approximated), np.transpose(H_f_approximated), np.transpose(H_o_approximated), np.transpose(H_c_approximated)))

    return approximated_kernel, approximated_recurrent_kernel, W_compression_ratio, H_compression_ratio


original_weights = lrcn.layers[-2].get_weights()

Tr = 1
Tc = 1

NZ_list = list(range(6, 96 + 1, 6))

# Initialize an empty DataFrame to store Nstep, NZ, Tr, and Tc
parameters_table = pd.DataFrame(columns=['NZ', 'Nstep', 'Accuracy'])

for NZ in NZ_list:
    Nstep = 3
    accuracy = 0

    while accuracy < 0.85:
        # Reset to original weights before each approximation
        lrcn.layers[-2].set_weights(original_weights)

        # Perform weight approximation
        approximated_kernel, approximated_recurrent_kernel, W_compression_ratio, H_compression_ratio = approximate_weight4_2_step(Nstep, NZ, Tr, Tc, lrcn.layers[-2])

        # Set the approximated weights
        approximated_weights = [approximated_kernel, approximated_recurrent_kernel, original_weights[2]]
        lrcn.layers[-2].set_weights(approximated_weights)

        # Make predictions and evaluate the model with approximated weights
        y_test = np.argmax(labels_test, axis=-1)
        y_pred = np.argmax(lrcn(features_test), axis=1)
        accuracy = accuracy_score(y_test, y_pred)

        Nstep = Nstep + 1
        if Nstep > 30:
            break

    # Append the current set of parameters to the DataFrame
    parameters_table = parameters_table._append({'NZ': NZ, 'Nstep': Nstep, 'Accuracy': accuracy}, ignore_index=True)
# Restore original weights after all approximations
lrcn.layers[-2].set_weights(original_weights)

# Display the table
print(parameters_table)

parameters_table.to_csv('collective.csv', index=False)