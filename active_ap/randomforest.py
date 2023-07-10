from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np
import pandas as pd

import ast

# Load the 3D input data list of arrays

df = pd.read_csv('experiment.csv')
columns = df[['csi_data']].values.tolist()

    
     
data = []
for column in columns:
        data.append(ast.literal_eval(column[0]))
        # print(ast.literal_eval(column[0]))
        

test_data=[np.array([22, 22, 19, 19, 20, 18, 2, 18, 18, 17, 21, 16, 18, 17, 18, 20, 21, 20, 19, 22, 20, 20, 19, 17, 18, 16, 19, 17, 17, 17, 21, 16, 18, 17, 16, 19, 21, 20, 18, 20, 20, 18, 16, 16, 17, 16, 17, 16, 15, 15, 18, 14, 15, 15, 14, 16, 18, 16, 15, 18, 20, 19, 17, 17, 19, 17, 19, 16, 16, 18, 20, 15, 16, 16, 16, 19, 19, 18, 18, 19, 15, 16, 16, 15, 16, 13, 15, 12, 14, 14, 17, 14, 14, 14, 14, 16, 16, 16, 14, 17, 'D'])]
temp=[]
x_test=[]
# Extract the feature columns and target column
for x in data:
        temp.append(x[0:-1])
for x in test_data:
        x_test.append(x[0:-1].tolist())

# X = [x[0:-1]for x in data]
y = [x[-1]for x in data]
y_test = [x[-1]for x in test_data]




# X = np.concatenate(X)
# y = np.concatenate(y)


# print(temp)
print(y)
# print(x_test)
# print(y_test)


# # Initialize the Random Forest classifier
rf = RandomForestClassifier(n_estimators=5)

# # Train the model on the training data
rf.fit(temp, y)

# # Make predictions on the testing data
y_pred = rf.predict(x_test)
print(y_pred)
# # Calculate the accuracy of the model
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy*100)