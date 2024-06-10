#!/usr/bin python3
# -*- coding: utf-8 -*-

import io
import pandas as pd
import numpy as np
from scipy.optimize import least_squares, minimize
whole_data = pd.read_csv('Data/kacleaned.csv')
dates = whole_data.iloc[1,:].unique()[2::]
threshold = 15
time_split = [85,56, 95, 75, 100, 90, 20, 100, 60, 60,  90 , 80, 68, 66, 72, 50,81,36, 69, 48, 96,
              96, 64, 47, 45, 56, 58, 83, 105, 64]
pred=[]
dist_data=[]
dates1=[]

for district_index in range(0,30):
    t0 =  time_split[district_index]
    district = whole_data['2'][district_index+2]
    
    i_data = np.take(whole_data.iloc[district_index+2,2:].values,np.arange(0,len(whole_data.iloc[district_index+2,2:]),3)).astype(int)
    
    valid_indices = i_data>=threshold
    i_data = i_data[valid_indices]
     
    
    i_data_before = i_data[0:t0]
    
    i_data_after = i_data[t0:len(i_data)]
    
    mu = 0.1
    # objective function for regression
    def objfn_itplusrt(param):
        itplusrt = []
        for i in range(0,len(i_data_before)):
            itplusrt.append(param[1]*((param[0]*np.exp((param[0]-mu)*i)-mu))/(param[0]-mu))  
        itplusrt = np.array(itplusrt)
        return (np.log10(itplusrt) - np.log10(i_data_before))
        #return sum((itplusrt - (i_data_before))**2)
    
    
    # regression on i(t)+r(t) 
    predicted_itplusrt = []
    param0=[0.002,threshold]
    
    # regression
    
    #const1 = ({'type':'ineq', 'fun': lambda x: -1*x[0]+10*x[1]}, \
    #{'type':'ineq', 'fun': lambda x: x[0]}, \
    #{'type':'ineq', 'fun': lambda x: x[1]}, \
    #{'type':'ineq', 'fun': lambda x: 1-x[0]}, \
    #{'type':'ineq', 'fun': lambda x: 1-x[1]})
    
    #res = minimize(objfn_itplusrt, param0, constraints = const1)
    res = least_squares(objfn_itplusrt, param0, bounds=([0,0],[1,np.inf])) 
    
    # predicted plot from regression 
    for i in range(0,t0):
        predicted_itplusrt.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*i)-mu))/(res.x[0]-mu))  
    
    
    # fit for tapering part param[1]-i(t_0) for this one, param[3] - t0
    def objfn_itplusrt_taper(param):
        itplusrt = []
        for i in range(t0,len(i_data)):
            itplusrt.append(param[1]*((param[0]*np.exp((param[0]-mu)*(i-t0))-mu))/(param[0]-mu))  
    
    #    print(len(itplusrt))
    #    print(len((i_data+r_data)[t0:len(i_data)]))
        itplusrt = np.array(itplusrt)
        return (np.log10(itplusrt) - np.log10(i_data_after))
        #return sum((itplusrt - (i_data_after))**2)
    
    predicted_itplusrt_taper=[]
    if len(i_data)>t0:
        param0 = [0.01, (i_data)[t0]]
    #    const2 = ({'type':'ineq', 'fun': lambda x: -1*x[0]+10*x[1]}, \
    #               {'type':'ineq', 'fun': lambda x: x[0]}, \
    #               {'type':'ineq', 'fun': lambda x: x[1]}, \
    #               {'type':'ineq', 'fun': lambda x: 1-x[0]}, \
    #               {'type':'ineq', 'fun': lambda x: 1-x[1]})
        #res_taper = minimize(objfn_itplusrt_taper, param0, constraints = const2)
        res_taper = least_squares(objfn_itplusrt_taper, param0, bounds=([0,0],[1,np.inf]))
        
    # predicted plot from regression
        for i in range(t0,len(i_data)+7):
            predicted_itplusrt_taper.append(res_taper.x[1]*((res_taper.x[0]*np.exp((res_taper.x[0]-mu)*(i-t0))-mu))/(res_taper.x[0]-mu))  
    
    prediction = predicted_itplusrt+predicted_itplusrt_taper
    
    # plot the actual time series and the dynamics with parameters obtained from regression
    dates_modified = dates[valid_indices]
    pred.append(prediction)
    dist_data.append(i_data)
    dates1.append(dates_modified[0])

df2=pd.DataFrame(dist_data)
df2.to_csv('Data/Output/Distdata.csv') 
