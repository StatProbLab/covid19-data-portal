#!/usr/bin python3
# -*- coding: utf-8 -*-

import io
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import least_squares
import os

directory_path = "/opt/lampp/htdocs/covid19-data-portal/Data/plots"

if not os.path.exists(directory_path):
    os.makedirs(directory_path)

dir_path = "/opt/lampp/htdocs/covid19-data-portal/Data/plots/daily"

if not os.path.exists(dir_path):
    os.makedirs(dir_path)

def prediction1():
    num_districts = 30
    initial_offset = 7
    predict_forward = 7
    locally_optimise = True
    dates1=[]
    
    whole_data = pd.read_csv('/opt/lampp/htdocs/covid19-data-portal/Data/kacleaned.csv')
    dates = whole_data.iloc[1,:].unique()[2::]
    threshold = 15
    
    predictions = [[] for x in range(0,num_districts)]
    std_error_1 = [[] for x in range(0,num_districts)]
    
    for district_index in range(0,num_districts):
        district = whole_data['2'][district_index+2]
        cum_i_data = np.take(whole_data.iloc[district_index+2,2:].values,np.arange(0,len(whole_data.iloc[district_index+2,2:]),3)).astype(int)
        cum_r_data = np.take(whole_data.iloc[district_index+2,3:].values,np.arange(0,len(whole_data.iloc[district_index+2,3:]),3)).astype(int)
        i_data=[]
        i_data.append(cum_i_data[0])
        r_data=cum_r_data
        for i in range(1,len(cum_i_data)):
            i_data.append(cum_i_data[i] - r_data[i-1])
        i_data = cum_i_data
        valid_indices = cum_i_data>=threshold
        cum_i_data = cum_i_data[valid_indices]
        i_data = np.array(i_data)[valid_indices]
        r_data = np.array(r_data)[valid_indices]
        
        
        total_predictions = [[] for x in range(initial_offset, len(i_data)-predict_forward)]
        total_data = [[] for x in range(initial_offset, len(i_data)-predict_forward)]     
        
        mu = 0.1
        param0=[0.002,threshold]   # beta, i_0(t_0), t_0, t_1
        t0=0
        t1=10
    
        # objective function for regression
        def objfn_itplusrt(param):
            itplusrt = []
            i_data_input = i_data[t0:t1]
            for i in range(t0,t1):
                itplusrt.append(param[1]*((param[0]*np.exp((param[0]-mu)*(i-t0))-mu))/(param[0]-mu) + r_data[t0])  
            itplusrt = np.array(itplusrt)
            return (np.log10(itplusrt) - np.log10(i_data_input))
        
        # regression
        predicted_itplusrt = []
        
        for t in range(initial_offset,len(i_data)+1):
            if t==initial_offset:
                t0=0
                t1=initial_offset
                param0=[0.002,threshold]
                res = least_squares(objfn_itplusrt, param0, bounds=([0,0],[1,np.inf]))
                for i in range(t0, t1+1):
                    predicted_itplusrt.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(i-t0))-mu))/(res.x[0]-mu) + r_data[t0])
                for j in range(0, 7):
                    total_predictions[t-initial_offset].append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(t1-t0+j))-mu))/(res.x[0]-mu) + r_data[t0])
                    total_data[t-initial_offset].append(i_data[j+t])
                    
            else:
                if locally_optimise:
                    error_before = 1000
                    error_after = 999
                    tstart = t-7
                    while(error_before>error_after and tstart>=0):
                        error_before=error_after
                        t0=tstart
                        t1=t
                        param0=[0.002,threshold]
                        res = least_squares(objfn_itplusrt, param0, bounds=([0,0],[1,np.inf]))
                        error_after = res.cost/(t1-t0)
                        tstart = tstart-1
                    predicted_itplusrt.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(t-t0))-mu))/(res.x[0]-mu)+r_data[t0])
                else:
                    tstart = t-7
                    t0 = tstart
                    t1 = t
                    param0=[0.002,threshold]
                    res = least_squares(objfn_itplusrt, param0, bounds=([0,0],[1,np.inf]))
                    error_after = res.cost
                    predicted_itplusrt.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(t-t0))-mu))/(res.x[0]-mu) + r_data[t0])
                if t<=len(i_data)-1-predict_forward:
                    for j in range(0,7):
                        total_predictions[t-initial_offset].append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(t+1-t0+j))-mu))/(res.x[0]-mu) + r_data[t0])
                        total_data[t-initial_offset].append(cum_i_data[t+1+j])
     
        for j in range(0,predict_forward-1):
            predicted_itplusrt.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(t+j+1-t0))-mu))/(res.x[0]-mu)+r_data[t0])
        predictions[district_index] = predicted_itplusrt
    
        std_error_1[district_index] = np.sqrt(np.sum(np.square(np.array(total_data)-np.array(total_predictions)),0)/len(total_data))      
        
        plot_prediction = []
        for j in range(t0,t+predict_forward+1):
            plot_prediction.append(res.x[1]*((res.x[0]*np.exp((res.x[0]-mu)*(j-t0))-mu))/(res.x[0]-mu)+r_data[t0])
        
        dates_modified = dates[valid_indices]
        dates1.append(dates_modified[0])
        plot_xlabels = np.arange(0,len(dates_modified),int(np.floor(len(dates_modified)/4)))
        
        plt.semilogy(np.arange(0,len(i_data)),(i_data),'o',mfc='none')    
        plt.semilogy(np.arange(0,len(i_data)+predict_forward+1)[t0:t+predict_forward+1],(plot_prediction),'r' )
        plt.xticks(plot_xlabels, dates_modified[plot_xlabels])
        plt.axvline(t0,color="limegreen")
        plt.xlabel('Date')
        plt.ylabel('Cumulative Infected (log scale)')
        plt.grid(axis='both')
        plt.title('Cumulative infected population'+str(' - ')+district)
        plt.savefig('/opt/lampp/htdocs/covid19-data-portal/Data/plots/'+ district + '.png')
        plt.show()
        plt.close()
        
    
        plt.plot((np.concatenate((i_data[-7:],np.array([0]))) - i_data[-8::])[0:7],'o',mfc='none', label='Data')    
        plt.plot(np.rint((np.concatenate((plot_prediction[-14:],np.array([0]))) - plot_prediction[-15::])[0:14]),'ro-' ,label='Prediction')
        plt.xticks([0,2,4,6,8,10,12], [dates_modified[-7:][0], dates_modified[-7:][2], dates_modified[-7:][4], dates_modified[-7:][6], 'Day 2', 'Day 4', 'Day 6'])
        plt.xlabel('Date')
        plt.ylabel('Daily cases')
        plt.grid(axis='both')
        plt.title('Daily cases prediction'+str(' - ')+district)
        plt.legend()
        plt.savefig('/opt/lampp/htdocs/covid19-data-portal/Data/plots/daily/'+ district + '.png')
        plt.show()
        plt.close()
       
    pd.DataFrame(predictions).to_csv('/opt/lampp/htdocs/covid19-data-portal/Data/Output/predictions.csv')
    pd.DataFrame(std_error_1).to_csv('/opt/lampp/htdocs/covid19-data-portal/Data/Output/std_error_1.csv')
    pd.DataFrame(dates1).to_csv('/opt/lampp/htdocs/covid19-data-portal/Data/Output/dates1.csv')


prediction1()
