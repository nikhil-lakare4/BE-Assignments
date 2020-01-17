from sklearn.neighbors import KNeighborsClassifier
import pandas as pd
import numpy as np
from sklearn.metrics import accuracy_score,confusion_matrix,f1_score , classification_report
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score


data = pd.read_csv("kdata.csv")
#print(data)
x = data.drop('value',axis = 1)
#print(x)
y = data['value']
#print(y)

x_train,x_test,y_train,y_test = train_test_split(x,y,random_state=56,test_size=0.2)


classifier = KNeighborsClassifier(n_neighbors=3,weights='distance')
classifier.fit(x_train,y_train)

scores = cross_val_score(classifier,x,y,cv =2)
print(scores)
# x_test = np.array([4,6])
# y_pred = classifier.predict([x_test])
# print(y_pred)
y_pred = classifier.predict(x_test)

print("Accuracy : ",accuracy_score(y_test,y_pred))
print("confusion_matrix : ",confusion_matrix(y_test,y_pred))
print("f1_score : ",f1_score(y_test,y_pred,average=None))
print("classification_report : \n",classification_report(y_test,y_pred))
