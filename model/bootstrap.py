import numpy as np
import pandas as pd
import random
df = pd.read_excel('美团数据.xlsx')
sample_mean_list1=[]
for i in range(10000):
    index = np.random.choice(range(71),71)
    sample_mean_list1.append(np.mean(df.v[index]))
print ('通过bootstrap方法估计出来的骑行速度总体均值为：',np.mean(sample_mean_list1))
sample_mean_list2=[]
for i in range(10000):
    index = np.random.choice(range(71),71)
    sample_mean_list2.append(np.mean(df.s[index]))
print ('通过bootstrap方法估计出来的骑行距离总体均值为：',np.mean(sample_mean_list2))
sample_mean_list3=[]
for i in range(10000):
    index = np.random.choice(range(71),71)
    sample_mean_list3.append(np.mean(df.t[index]))
print ('通过bootstrap方法估计出来的配送时间总体均值为：',np.mean(sample_mean_list3))