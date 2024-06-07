import pandas as pd
import numpy as np
import plotly.graph_objs as go
from plotly.subplots import make_subplots
import plotly.io as pio

# Load data
pred = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/predictions.csv").iloc[:, 1:]
pred3 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/predictions3.csv").iloc[:, 1:]
kadist = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/Distdata.csv").iloc[:, 1:]
dates1 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/dates1.csv").iloc[:, 1:]
pred2 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Karnataka_forecasts2.csv")
print(pred2.columns)
pred4 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/karnataka_projections4.csv")
pred5 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/csirforecast.csv")
d = pd.to_datetime(pred2['Date'], format="%Y-%m-%d")
d4 = pd.to_datetime(pred4['Date'], format="%Y-%m-%d")
d5 = pd.to_datetime(pred5['Date'], format="%Y-%m-%d")
stder1 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/std_error_1.csv").iloc[:, 1:]
stder3 = pd.read_csv("/opt/lampp/htdocs/covid19-data-portal/Data/Output/std_error_3.csv").iloc[:, 1:]


# Define district names and plot formatting
dist_names = ["Bagalakote", "Ballari", "Belagavi", "Bengaluru Rural", "Bengaluru Urban", "Bidar", "Chamarajanagara",
              "Chikkaballapura", "Chikkamagaluru", "Chitradurga", "Dakshina Kannada", "Davanagere", "Dharwad", "Gadag",
              "Hassan", "Haveri", "Kalaburagi", "Kodagu", "Kolar", "Koppal", "Mandya", "Mysuru", "Raichur", "Ramanagara",
              "Shivamogga", "Tumakuru", "Udupi", "Uttara Kannada", "Vijayapura", "Yadgiri"]
f = dict(family="serif", size=18, color="black")
f2 = dict(family="serif", size=18, color="green3", font=2)
f3 = dict(family="serif", size=13)
colors1 = ["#0072B2", "#000000", "#009E73", "#D55E00", "#CC79A7", "#f0e442"]

# Define functions for plotting
def district1(i):
    na1 = np.where(pd.isna(pred.iloc[i, :]))[0]
    na2 = np.where(pd.isna(kadist.iloc[i, :]))[0]

    if len(na1) > 0:
        pred_data = pred.iloc[i, :min(na1) - 1]
        pred3_data = pred3.iloc[i, :min(na1) - 1]
    else:
        pred_data = pred.iloc[i, :]
        pred3_data = pred3.iloc[i, :]

    if len(na2) > 0:
        dist_data = kadist.iloc[i, :min(na2) - 1]
    else:
        dist_data = kadist.iloc[i, :]

    l = np.arange(1, len(pred_data) + 1)
    dist_data = np.log10(dist_data.astype(float))
    pred_data_lin = pred_data.astype(float)
    pred_data = np.log10(pred_data.astype(float))
    pred3_data_lin = pred3_data.astype(float)
    pred3_data = np.log10(pred3_data.astype(float))
    start = pd.to_datetime(dates1.iloc[i, 0], format="%d/%m/%y")
    start = start.replace(year=2020)

    dist_data[len(dist_data):len(l)] = -99  # always get 7 more -99
    if i == 6:
        dateseq1 = pd.date_range(start=start, end=pd.to_datetime("27-04-20", format="%d-%m-%y"), freq="D")
        dateseq2 = pd.date_range(start=pd.to_datetime("02-05-20", format="%d-%m-%y"), periods=len(l) - len(dateseq1), freq="D")
        l2 = dateseq1.union(dateseq2)
    else:
        l2 = pd.date_range(start=start, periods=len(l), freq="D")
    z = l2.strftime("%d-%m-%y")
    #print("z =", z)

    # Adding the second prediction
    pred2['Date'] = pd.to_datetime(pred2['Date'], format="%Y-%m-%d")
    whole_data2 = pred2[pred2['District'] == dist_names[i]][['Rescaled-Infected', 'Date']]
    #whole_data2 = pred2[pred2['District'] == dist_names[i]][['Rescaled-Infected', pd.to_datetime(pred2['Date'], format="%Y-%m-%d")]]
    k = whole_data2['Date'].eq(start)
    pred2_data = whole_data2.loc[k, 'Rescaled-Infected'].iloc[1:len(l2)]
    pred2_data_lin = pred2_data
    pred2_data = np.log10(pred2_data)

    # Adding the fourth prediction
    if i == 7:
        pred4_data = np.nan * np.zeros(len(pred2_data))
        pred4_data_lin = np.nan * np.zeros(len(pred2_data_lin))
    else:
        if i == 6:
            pred4['Date'] = pd.to_datetime(pred2['Date'], format="%Y-%m-%d")
            whole_data4 = pred4[(pred4['District'] == dist_names[i]) & pred4['Date'].isin(l2)][['Predicted-Infected', 'Date']]
        else:
            whole_data4 = pred4[(pred4['District'] == dist_names[i])][['Predicted-Infected', 'Date']]
        k = whole_data4['Date'].eq(start)
        pred4_data = whole_data4.loc[k, 'Predicted-Infected'].iloc[1:len(l2)]
        pred4_data_lin = pred4_data
        pred4_data = np.log10(pred4_data)

    # Adding the fifth prediction
    if i == 6:
        pred5['Date'] = pd.to_datetime(pred2['Date'], format="%Y-%m-%d")
        whole_data5 = pred5[(pred5['District'] == dist_names[i]) & pred5['Date'].isin(l2)][['Infected', 'Date']]
    else:
        whole_data5 = pred5[(pred5['District'] == dist_names[i])][['Infected', 'Date']]
    k = whole_data5['Date'].eq(start)
    pred5_data = whole_data5.loc[k, 'Infected'].iloc[1:len(l2)]
    pred5_data_lin = pred5_data
    pred5_data = np.log10(pred5_data)

    print("dist_data = ", type(dist_data))
    print("pred_data = ", type(pred_data))
    print("pred_data_lin = ", type(pred_data_lin))
    print("pred2_data = ", type(pred2_data))
    print("pred2_data_lin = ", type(pred2_data_lin))
    print("pred4_data = ", type(pred4_data))
    print("pred4_data_lin = ", type(pred4_data_lin))
    print("pred5_data = ", type(pred5_data))
    print("pred5_data_lin = ", type(pred5_data_lin))

    df = pd.DataFrame({'z': z, 'dist_data': dist_data, 'pred_data': pred_data, 'pred_data_lin': pred_data_lin,
                       'pred2_data': pred2_data, 'pred2_data_lin': pred2_data_lin, 'pred3_data': pred3_data,
                       'pred3_data_lin': pred3_data_lin, 'pred4_data': pred4_data, 'pred4_data_lin': pred4_data_lin,
                       'pred5_data': pred5_data, 'pred5_data_lin': pred5_data_lin})
    #print(df.dtypes)
    df['z'] = pd.Categorical(df['z'], categories=df['z'].unique())

    fig = make_subplots(rows=2, cols=1, shared_xaxes=True, subplot_titles=(dist_names[i], "Log Scale"))
    fig.add_trace(go.Scatter(x=df['z'], y=df['dist_data'], mode='markers', name='Observed Data', marker=dict(color='rgba(0, 114, 178, 1)')), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred2_data'], mode='lines', name='INDSCI-SIM Prediction'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred_data'], mode='lines', name='IISC-ISI Prediction 1'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred3_data'], mode='lines', name='IISC-ISI Prediction 2'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred4_data'], mode='lines', name='SAIR Prediction'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred5_data'], mode='lines', name='CSIR Prediction'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred_data_lin'], mode='lines', name='IISC-ISI Prediction 1', hoverinfo='text',
                             text=df.apply(lambda row: f"<br> IISC-ISI Fit 1 <br> Date: {row['z']} <br> Log Scale: {row['pred_data']} <br> Linear Scale: {row['pred_data_lin']}", axis=1)), row=2, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred3_data_lin'], mode='lines', name='IISC-ISI Prediction 2', hoverinfo='text',
                             text=df.apply(lambda row: f"<br> IISC-ISI Fit 2 <br> Date: {row['z']} <br> Log Scale: {row['pred3_data']} <br> Linear Scale: {row['pred3_data_lin']}", axis=1)), row=2, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred4_data_lin'], mode='lines', name='SAIR Prediction', hoverinfo='text',
                             text=df.apply(lambda row: f"<br> SAIR Model <br> Date: {row['z']} <br> Log Scale: {row['pred4_data']} <br> Linear Scale: {row['pred4_data_lin']}", axis=1)), row=2, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred5_data_lin'], mode='lines', name='CSIR Prediction', hoverinfo='text',
                             text=df.apply(lambda row: f"<br> CSIR Model <br> Date: {row['z']} <br> Log Scale: {row['pred5_data']} <br> Linear Scale: {row['pred5_data_lin']}", axis=1)), row=2, col=1)
    fig.update_layout(title_font=f2, xaxis=dict(title='Dates', titlefont=f, tickangle=-45, tickfont=f3),
                      yaxis=dict(title='Infected Cases-Log Scale', titlefont=f), showlegend=True, colorway=colors1)
    fig.update_yaxes(title='Infected Cases-Linear Scale', titlefont=f, row=2, col=1)
    return fig


def district3(i):
    na1 = np.where(pd.isna(pred.iloc[i, :]))[0]
    na2 = np.where(pd.isna(kadist.iloc[i, :]))[0]

    if len(na1) > 0:
        pred_data = pred.iloc[i, :min(na1) - 1]
        pred3_data = pred3.iloc[i, :min(na1) - 1]
    else:
        pred_data = pred.iloc[i, :]
        pred3_data = pred3.iloc[i, :]

    if len(na2) > 0:
        dist_data = kadist.iloc[i, :min(na2) - 1]
    else:
        dist_data = kadist.iloc[i, :]

    l = np.arange(1, len(pred_data) + 1)
    dist_data = dist_data.astype(float)
    pred_data = np.round(pred_data.astype(float))
    pred3_data = np.round(pred3_data.astype(float))
    start = pd.to_datetime(dates1.iloc[i, 0], format="%d/%m/%y")
    start = start.replace(year=2020)

    dist_data[len(dist_data):l] = np.nan  # always get 7 more NAs
    if i == 5:
        l2 = pd.date_range(end=pd.Timestamp.today(), periods=14, freq="D")
    else:
        l2 = pd.date_range(start=start, periods=14, freq="D")
    z = l2.strftime("%d-%m-%y")

    # Adding the second prediction
    whole_data2 = pred2[pred2['District'] == dist_names[i]][['Rescaled-Infected', 'Date']]
    k = whole_data2['Date'].eq(start)
    pred2_data = whole_data2.loc[k, 'Rescaled-Infected'].iloc[1:14]

    # Adding the fourth prediction
    if i == 6:
        pred4_data = np.nan * np.zeros(14)
    else:
        if i == 5:
            whole_data4 = pred4[(pred4['District'] == dist_names[i]) & pred4['Date'].isin(l2)][['Predicted-Infected', 'Date']]
        else:
            whole_data4 = pred4[(pred4['District'] == dist_names[i])][['Predicted-Infected', 'Date']]
        k = whole_data4['Date'].eq(start)
        pred4_data = whole_data4.loc[k, 'Predicted-Infected'].iloc[1:14]

    # Adding the fifth prediction
    if i == 5:
        whole_data5 = pred5[(pred5['District'] == dist_names[i]) & pred5['Date'].isin(l2)][['Infected', 'Date']]
    else:
        whole_data5 = pred5[(pred5['District'] == dist_names[i])][['Infected', 'Date']]
    k = whole_data5['Date'].eq(start)
    pred5_data = whole_data5.loc[k, 'Infected'].iloc[0:14]

    df = pd.DataFrame({'z': z, 'dist_data': dist_data, 'pred_data': pred_data, 'pred2_data': pred2_data,
                       'pred3_data': pred3_data, 'pred4_data': pred4_data, 'pred5_data': pred5_data})
    df['z'] = pd.Categorical(df['z'], categories=df['z'].unique())

    fig = make_subplots(rows=2, cols=1, shared_xaxes=True, subplot_titles=(dist_names[i], "Linear Scale"))
    fig.add_trace(go.Scatter(x=df['z'], y=df['dist_data'], mode='markers', name='Observed Data', marker=dict(color='rgba(0, 114, 178, 1)')), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred2_data'], mode='lines', name='INDSCI-SIM Prediction'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred_data'], mode='lines', name='IISC-ISI Prediction 1'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred3_data'], mode='lines', name='IISC-ISI Prediction 2'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred4_data'], mode='lines', name='SAIR Prediction'), row=1, col=1)
    fig.add_trace(go.Scatter(x=df['z'], y=df['pred5_data'], mode='lines', name='CSIR Prediction'), row=1, col=1)
    fig.update_layout(title_font=f2, xaxis=dict(title='Dates', titlefont=f, tickangle=-45, tickfont=f3),
                      yaxis=dict(title='Infected Cases-Linear Scale', titlefont=f), showlegend=True, colorway=colors1)
    return fig


def errband(i):
    na1 = np.where(pd.isna(pred.iloc[i, :]))[0]
    na2 = np.where(pd.isna(kadist.iloc[i, :]))[0]

    tempdate = pd.to_datetime(dates1.iloc[i, 0], format="%d/%m/%y")
    tempdate = tempdate.replace(year=2020)
    start = tempdate + pd.DateOffset(days=len(pred.iloc[i, :]) - 14)

    if len(na1) > 0:
        pred_data = pred.iloc[i, min(na1) - 1:]
        pred3_data = pred3.iloc[i, min(na1) - 1:]
    else:
        pred_data = pred.iloc[i, :]
        pred3_data = pred3.iloc[i, :]

    if len(na2) > 0:
        dist_data = kadist.iloc[i, min(na2) - 1:]
    else:
        dist_data = kadist.iloc[i, :]

    l = len(pred_data)
    pred_data = pred_data.iloc[l-14:l].astype(float)
    pred3_data = pred3_data.iloc[l-14:l].astype(float)
    l = len(pred_data)
    dist_data = dist_data[-7:].astype(float)
    dist_data = np.append(dist_data, [np.nan] * (l - 7))

    error1_high = np.array([np.nan] * (l - 7))
    error1_low = np.array([np.nan] * (l - 7))
    error3_high = np.array([np.nan] * (l - 7))
    error3_low = np.array([np.nan] * (l - 7))

    if l >= 14:
        if i != 6:
            error1_high[0] = np.log10(pred_data[0]) + 1.96 * stder1.iloc[i, 0]
            error1_low[0] = np.log10(pred_data[0]) - 1.96 * stder1.iloc[i, 0]
            error3_high[0] = np.log10(pred3_data[0]) + 1.96 * stder3.iloc[i, 0]
            error3_low[0] = np.log10(pred3_data[0]) - 1.96 * stder3.iloc[i, 0]
            for j in range(1, l - 7):
                error1_high[j] = np.log10(pred_data[j]) + 1.96 * stder1.iloc[i, j]
                error1_low[j] = np.log10(pred_data[j]) - 1.96 * stder1.iloc[i, j]
                error3_high[j] = np.log10(pred3_data[j]) + 1.96 * stder3.iloc[i, j]
                error3_low[j] = np.log10(pred3_data[j]) - 1.96 * stder3.iloc[i, j]

    fig = go.Figure()
    fig.add_trace(go.Scatter(x=pd.date_range(start=start, periods=l, freq="D"), y=np.log10(dist_data), mode='markers', name='Observed Data', marker=dict(color='rgba(0, 114, 178, 1)')))
    fig.add_trace(go.Scatter(x=pd.date_range(start=start, periods=l - 7, freq="D"), y=error1_high, mode='lines', fill=None, line=dict(color='red'), name='95% CI IISC-ISI Model 1 High'))
    fig.add_trace(go.Scatter(x=pd.date_range(start=start, periods=l - 7, freq="D"), y=error1_low, mode='lines', fill='tonexty', line=dict(color='red'), name='95% CI IISC-ISI Model 1 Low'))
    fig.add_trace(go.Scatter(x=pd.date_range(start=start, periods=l - 7, freq="D"), y=error3_high, mode='lines', fill=None, line=dict(color='green'), name='95% CI IISC-ISI Model 2 High'))
    fig.add_trace(go.Scatter(x=pd.date_range(start=start, periods=l - 7, freq="D"), y=error3_low, mode='lines', fill='tonexty', line=dict(color='green'), name='95% CI IISC-ISI Model 2 Low'))
    fig.update_layout(title_font=f2, xaxis=dict(title='Date', titlefont=f), yaxis=dict(title='Infected Cases (Log Scale)', titlefont=f))
    return fig



# Loop through each district index
for i in range(len(dist_names)):
    # Generate district-wise plots
    fig1 = district1(i)
    fig2 = district3(i)
    fig3 = errband(i)
    
    # Save plots as PNG files
    pio.write_image(fig1, f'district1_plot_{dist_names[i]}.png')
    pio.write_image(fig2, f'district3_plot_{dist_names[i]}.png')
    pio.write_image(fig3, f'errband_plot_{dist_names[i]}.png')

