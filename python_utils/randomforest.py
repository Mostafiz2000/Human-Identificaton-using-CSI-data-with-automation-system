from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd

import ast

# Load the 3D input data list of arrays
def fun(a):
        a=np.array(a)
        df = pd.read_csv('experiment.csv')
        columns = df[['csi_data']].values.tolist()

        # print(a)
     
        data = []
        for column in columns:
                data.append(ast.literal_eval(column[0]))
        # print(ast.literal_eval(column[0]))
        

        test_data=a
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




        print(x_test)
        print(y_test)


# # # Initialize the Random Forest classifier
        rf = RandomForestClassifier(n_estimators=5)
        # log_reg = LogisticRegression()
# # # Train the model on the training data
        rf.fit(temp, y)
        # log_reg.fit(temp, y)

# # # Make predictions on the testing data
        y_pred = rf.predict(x_test)
        print(y_pred)
        
# # # Calculate the accuracy of the model
        # accuracy = accuracy_score(y_test, y_pred)
        # print("Accuracy:", accuracy*100)
        # predictions1 = log_reg.predict(x_test)
        # ans1=log_reg.predict_proba(x_test)
        # print(ans1*100)
        return y_pred