
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np
data = pd.read_csv('kdata.csv')
print(data)


# In[2]:

x = data.iloc[:,:-1]
y = data.iloc[:,-1]
print(x)


# In[3]:

print(y)


# In[4]:

from sklearn.neighbors import KNeighborsClassifier
classifier = KNeighborsClassifier(n_neighbors=3)
classifier.fit(x,y)
x_test=[[6,6]]
y_pred = classifier.predict(x_test)
print(y_pred)


# In[ ]:



