from pandas import read_csv

path = "iris.csv"
data = read_csv(path)

'''

print(data.shape)
print()
print(data[:3])
print()
print(data.describe())
print()

count_class = data.groupby('sepal_length').size()

print(count_class)
print()

correlations = data.corr(method='pearson')

print(correlations)
print()

print(data.skew())
print()

from sklearn import preprocessing

array = data.iloc[:, 0:4].values

print(array)
print()

data_scaler = preprocessing.MinMaxScaler(feature_range=(0,1))
data_rescaled = data_scaler.fit_transform(array)

print(data_rescaled)
print()

from sklearn.preprocessing import Binarizer

binarizer = Binarizer(threshold = 0.5).fit(array)

data_binarizer = binarizer.transform(array)

print(data_binarizer[0:5])

'''

from sklearn.model_selection import train_test_split

x = data.drop("variety", axis=1)

y = data["variety"]

x_train, x_test, y_train, y_test = train_test_split(x,y,test_size=0.25, random_state=1000)

import numpy as np

X = np.random.uniform(0.0, 1.0, size=(150, 3))
Y = np.random.choice(("Setosa", "Versicolor", "Virginica"), size=150)

print(X[0])

from sklearn.preprocessing import LabelEncoder

le = LabelEncoder()
yt = le.fit_transform(Y)
print(yt)

from sklearn.preprocessing import LabelBinarizer

lb = LabelBinarizer()
yb = lb.fit_transform(Y)
