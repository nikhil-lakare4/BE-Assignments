
# coding: utf-8

# In[88]:

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn.preprocessing import MinMaxScaler

import re
from IPython.display import Image
#get_ipython().magic('matplotlib inline')


# In[89]:

path="diabetes.csv"
df=pd.read_csv(path)


# In[90]:

print(df.head())


# In[91]:

print(df.tail())


# In[92]:

print(df.describe(include='all'))


# In[93]:

print(df.info())


# In[94]:

print(df.hist())
print(plt.show())


# In[95]:

print(df.boxplot())
print(plt.show())


# In[96]:

df.shape


# In[97]:

df.isnull().sum()


# In[98]:

df['Glucose'].isnull().sum()


# In[99]:

df['Age'].isnull().sum()


# In[100]:

df['Outcome'].isnull().sum()


# In[101]:

df['Insulin'].isnull().sum()


# In[102]:

newdf = df.dropna()
newdf


# In[103]:

scaler = MinMaxScaler()
print(scaler.fit(df))


# In[104]:

print(scaler.data_max_)


# In[105]:

print(scaler.transform(df))


# In[106]:

X = df.drop(['Outcome'],axis=1)
X


# In[107]:

x = df.drop(['Outcome'],axis=1)
x


# In[108]:

y=df['Outcome']
y


# In[109]:

from sklearn.model_selection import train_test_split

x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.25,random_state=0)


# In[110]:

from sklearn.naive_bayes import GaussianNB


# In[111]:

classifier=GaussianNB()


# In[112]:

classifier.fit(x_train,y_train)


# In[113]:

y_pred=classifier.predict(x_test)
y_pred


# In[114]:

from sklearn.metrics import confusion_matrix
CM=confusion_matrix(y_test,y_pred)
print ('Confusion Matrix : ')
print(CM)


# In[115]:

from sklearn.metrics import accuracy_score 
print ('Accuracy Score : ')
print(accuracy_score(y_test, y_pred))


# In[116]:

from sklearn.metrics import classification_report 
print ('Report : ')
print (classification_report(y_test, y_pred))


# In[117]:

import seaborn as sns
class_names=[0,1] # name  of classes
fig, ax = plt.subplots()
tick_marks = np.arange(len(class_names))
plt.xticks(tick_marks, class_names)
plt.yticks(tick_marks, class_names)
# create heatmap
sns.heatmap(pd.DataFrame(CM), annot=True, cmap="YlGnBu" ,fmt='g')
ax.xaxis.set_label_position("top")
plt.tight_layout()
plt.title('Confusion matrix', y=1.1)
plt.ylabel('Actual label')
plt.xlabel('Predicted label')


# In[118]:

tn, fp, fn, tp = CM.ravel()
precision = tp/(tp+fp) # 81/(81+23)
recall = tp/(tp+fn) # 81/(81+30)
print('Precision:',precision,'\nRecall: ', recall)


# In[ ]:



