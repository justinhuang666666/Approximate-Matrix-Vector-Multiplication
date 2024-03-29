import sys
sys.path.append('/Users/justin/Desktop/Year 4/FYP/main')
from iterative_approximation.Algorithm2 import *
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


fashion_lstm = load_model('model/Fashion_LSTM___Date_Time_2024_03_16__23_42_18___Loss_0.38376548886299133___Accuracy_0.8604999780654907.h5')
LSTM_right_layer = fashion_lstm.get_layer('LSTM_right')
original_weights_right = LSTM_right_layer.get_weights()
kernel, recurrent_kernel, bias = original_weights_right
print(kernel.shape)