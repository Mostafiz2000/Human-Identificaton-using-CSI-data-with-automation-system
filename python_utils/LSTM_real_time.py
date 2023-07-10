# -------------------------------------------LSTM----------------------------------------

from pandas.tseries.offsets import YearEnd
import numpy as np
import tensorflow as tf
# from google.colab import drive
from sklearn import metrics
import matplotlib.pyplot as plt
from sklearn.metrics import precision_score, recall_score, f1_score, accuracy_score
# drive.mount('/content/drive')

from keras.models import Sequential
from keras.layers import LSTM, Dense
from keras.utils import to_categorical
import pandas as pd
from keras.models import load_model
import pickle
PIK = "lstm_model.pkl"
# a=[[[-75  84 -64   4   0   0   0   0   0   0   0   0   0   1 -25  -1 -24
#      0 -23   1 -24   3 -25   1 -24   2 -24   6 -24   6 -22   4 -23   4
#    -22   5 -21   5 -22   5 -21   6 -22   6 -21   7 -22   5 -20   5 -21
#      8 -20   8 -22   5 -20   8 -18   5 -17   6 -19   5 -20   0   0   5
#    -18   8 -19   5 -17   6 -18   3 -18   5 -17   4 -17   6 -19   4 -21
#      4 -19   0 -15   0 -16   1 -16   4 -17   3 -17   3 -18   1 -19   3
#    -18   3 -19   4 -17   3 -18   3 -18   3 -19   2 -17   0 -18   1 -17
#      0   0   0   0   0   0   0   0   0   0]]]


name_list=['sakib','mamun','siddik','babul','picchi','mostafiz']

def fun2(a):
    if(len(a)<20):

        return "Invalid data"
    new_list2=[[int(num) for num in a]]
    
    
    a=new_list2
    a=np.array(a)
    print(a)
    X = np.reshape(a, (a.shape[0], 1, a.shape[1]))
    model = load_model('model.h5')
    predicted_labels = model.predict(X)
    predicted_class = np.argmax(predicted_labels)
    print(name_list[predicted_class])
    return name_list[predicted_class]