#!/usr/bin python3
# -*- coding: utf-8 -*
import io
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import os

directory_path = "Data/plots3"

if not os.path.exists(directory_path):
    os.makedirs(directory_path)

dir_path = "Data/plots3/daily"

if not os.path.exists(dir_path):
    os.makedirs(dir_path)


num_districts = 30
initial_offset = 7
predict_forward = 7
locally_optimise = True
dates1=[]

whole_data = pd.read_csv('Data/kacleaned.csv')
dates = whole_data.iloc[1,:].unique()[2::]
threshold = 15

predictions_3_master = [[] for x in range(0,num_districts)]
std_error_3 = [[] for x in range(0,num_districts)]

def prediction3(time_series):
    days = len(time_series)
    time =  np.arange(0, days, 1)
    Y = np.array(time_series)
    Y[Y==0] = 1 # Boiler plate to avoid divide by zero error... 
    Y_log = np.log(Y)
    time_1 = time.reshape(-1,1)
    reg = LinearRegression().fit(time_1, Y_log)
    return (reg)    

for district_index in range(0,num_districts):
    district = whole_data['2'][district_index+2]
    i_data = np.take(whole_data.iloc[district_index+2,2:].values,np.arange(0,len(whole_data.iloc[district_index+2,2:]),3)).astype(int)
    valid_indices = i_data>=threshold
    i_data = i_data[valid_indices]
    
    total_predictions3 = [[] for x in range(initial_offset, len(i_data)-predict_forward)]
    total_data3 = [[] for x in range(initial_offset, len(i_data)-predict_forward)]

    predicted_three = []

    for t in range(initial_offset,len(i_data)+1):
        if t==initial_offset:
            t0=0
            t1=initial_offset
            res3 = prediction3(i_data[t0:t1]) 
            for i in range(t0, t1+1):
                predicted_three.append(np.exp(res3.intercept_ + res3.coef_*(i-t0))[0])
            for j in range(0, 7):
                total_predictions3[t-initial_offset].append(np.exp(res3.intercept_ + res3.coef_*(t1-t0+j))[0])
                total_data3[t-initial_offset].append(i_data[j+t])

        else:
            if locally_optimise:
                error_before = 1000
                error_after = 999
                tstart = t-7
                while(error_before>error_after and tstart>=0 and (t1+1)<len(i_data)):
                    error_before=error_after
                    t0=tstart
                    t1=t
                    res3 = prediction3(i_data[t0:t1])
                    error_after = 0
                    for i in range(t1-t0):
                        error_after += np.abs(np.exp(res3.intercept_ + res3.coef_*(i)) - i_data[t0+i])
                    error_after /= (t1-t0) 
                    tstart = tstart-1
                predicted_three.append(np.exp(res3.intercept_ + res3.coef_*(t-t0))[0])               
 
            else:
                tstart = t-7
                t0 = tstart
                t1 = t
                res3 = prediction3(i_data[t0:t1])
                error_after = 0
                for i in range(t1-t0):
                    error_after += np.abs(np.exp(res3.intercept_ + res3.coef_*(i)) - i_data[t0+i])
                error_after /= (t1-t0)
                predicted_three.append(np.exp(res3.intercept_ + res3.coef_*(t1-t0))[0])               

            if t<=len(i_data)-1-predict_forward:
                for j in range(0,7):
                    total_predictions3[t-initial_offset].append(np.exp(res3.intercept_ + res3.coef_*(t+1-t0+j))[0])
                    total_data3[t-initial_offset].append(i_data[t+1+j])

    for j in range(0,predict_forward-1):
        predicted_three.append(np.exp(res3.intercept_ + res3.coef_*(t+j+1-t0))[0])               
    
    predicted_curve = []
    for j in range(t0, t+predict_forward+1):
        predicted_curve.append(np.exp(res3.intercept_ + res3.coef_*(j-t0))[0])

    predictions_3_master[district_index] = predicted_three

    std_error_3[district_index] = np.sqrt(np.sum(np.square(np.array(total_data3)-np.array(total_predictions3)),0)/len(total_data3))
    
    dates_modified = dates[valid_indices]
    dates1.append(dates_modified[0])
    plot_xlabels = np.arange(0,len(dates_modified),int(np.floor(len(dates_modified)/4)))
    
    plt.semilogy((i_data),'o',mfc='none')    
    plt.semilogy((predicted_three),'g' )
    plt.semilogy(np.arange(0,len(i_data)+predict_forward+1)[t0:t+predict_forward+1],(predicted_curve),'deeppink')
    plt.xticks(plot_xlabels, dates_modified[plot_xlabels])
    plt.axvline(t0,color="dodgerblue")
    plt.xlabel('Date')
    plt.ylabel('Cumulative Infected (log scale)')
    plt.grid(axis='both')
    plt.title('Cumulative infected population'+str(' - ')+district)
    plt.savefig('Data/plots3/'+ district + '.png')
    plt.close()    

    plt.plot((np.concatenate((i_data[-7:],np.array([0]))) - i_data[-8::])[0:7],'o',mfc='none', label='Data')    
    plt.plot(np.rint((np.concatenate((predicted_three[-14:],np.array([0]))) - predicted_three[-15::])[0:14]),'ro-' ,label='Prediction')
    plt.xticks([0,2,4,6,8,10,12], [dates_modified[-7:][0], dates_modified[-7:][2], dates_modified[-7:][4], dates_modified[-7:][6], 'Day 2', 'Day 4', 'Day 6'])
    plt.xlabel('Date')
    plt.ylabel('Daily cases')
    plt.grid(axis='both')
    plt.title('Daily cases prediction'+str(' - ')+district)
    plt.legend()
    plt.savefig('Data/plots3/daily/'+ district + '.png')
    plt.close()

pd.DataFrame(predictions_3_master).to_csv('Data/Output/predictions3.csv')
pd.DataFrame(std_error_3).to_csv('Data/Output/std_error_3.csv')
