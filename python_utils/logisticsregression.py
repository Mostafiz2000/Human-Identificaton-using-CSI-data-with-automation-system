import numpy as np
from sklearn.model_selection import train_test_split

from sklearn.linear_model import LogisticRegression
import pandas as pd
import numpy as np
import ast


df = pd.read_csv('experiment.csv')
columns = df[['csi_data']].values.tolist()
     
data = []
for column in columns:
    data.append(ast.literal_eval(column[0]))
test_data=a
temp=[]
x_test=[]
X_train=np.array([19, 16, 14, 17, 16, 18, 18, 17, 19, 15, 32, 18, 14, 14, 19, 18, 17, 18, 22, 17,7, 7, 8, 7, 5, 4, 6, 7, 12, 8, 3, 11, 8, 10, 10, 10, 14, 5, 3, 9, ])
X_test=np.array([19, 16, 14, 17, 16, 7, 7, 8, 7, 5])
y_train=np.array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ])
y_test=np.array([1, 1, 1, 1, 1,2, 2, 2, 2, 2 ])

log_reg = LogisticRegression()

log_reg.fit(X_train.reshape(-1, 1), y_train)

predictions1 = log_reg.predict(X_test.reshape(-1, 1))
ans1=log_reg.predict_proba(X_test.reshape(-1, 1))
print(ans1*100)

