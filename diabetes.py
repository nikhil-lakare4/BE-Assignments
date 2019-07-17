import pandas as pd
import numpy as np
#import matplotlib.pyplot as plt

path="/home/administrator/Desktop/diabetes.csv"
df=pd.read_csv(path,header=0)

df1 = df.replace(0, np.nan)

print(df1.isnull().sum())

m_features = ["glucose", "bloodpressure", "skinthickness", "insulin", "bmi"]

for c in m_features:
	avg = df[c].mean(axis=0)
	df[c].replace(0,avg,inplace=True)

print(df.isnull().sum())

from sklearn.preprocessing import MinMaxScaler
x = df.drop(['outcome'], axis=1)
y = df['outcome']
#x = df[:, 0:8]
#y = df[:, 8:]
scale = MinMaxScaler()
x_scale = scale.fit_transform(x)

print(x_scale)

from sklearn.model_selection import train_test_split

'''
print(df.info())
print(df.head())
print(df.tail())

x=df.iloc[:,:-1]		
y=df.iloc[:,-1]			

print(x.isnull())
print(y.isnull())
'''
'''
from sklearn.preprocessing import StandardScaler
Scaler_x=StandardScaler()
x=Scaler_x.fit_transform(x)

from sklearn.model_selection import train_test_split

x_train,y_train,x_test,y_test=train_test_split(x,y,test_size=0.25,random_state=0)

from sklearn.naive_bayes import GaussianNB
classifier=GaussianNB()
classifier.fit(x_train,y_train)

y_pred=classifier.predict(x_test)

from sklearn.matrices import confusion_matrix
cm=confusion_matrix(y_test,y_pred)
print(cm)
'''
