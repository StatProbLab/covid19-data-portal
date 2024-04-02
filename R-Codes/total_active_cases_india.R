###
#File: total_active_cases_india.R
#Description: this program generates graph of total active 
#             covid-19 cases in india
#Author:  
#Modified by: Paavan Parekh
#Mentored by: Prof. Shiva Athreya
###

library(dplyr)
library(ggplot2)
library(tidyr)
library(gganimate)
library(viridis)
library(hrbrthemes)
library(plotly)
library(anim.plots)

india <- read.csv("./data/summarymohfw1update.csv", header = FALSE)
india <- india[-2, ]

# extract number of infected cases in india

inf_ind <- india[, c(1, 2 + 4 * 0:((ncol(india) - 1) / 4 - 1))]
inf_for <- india[, c(1, 3 + 4 * 0:((ncol(india) - 1) / 4 - 1))]
ind_inf <- inf_ind

for (i in 2:ncol(ind_inf)) {
  ind_inf[-1, i] <- as.numeric(ind_inf[-1, i]) + as.numeric(inf_for[-1, i])
}

colnames(ind_inf) <- c("State", 1:(ncol(ind_inf) - 1))
rownames(ind_inf) <- 0:(nrow(ind_inf) - 1)
ind_inf[38, 1] <- "India"
ind_inf[1, 1] <- "Date"
write.csv(ind_inf, "./data/India_Infected.csv")

# extract number of recovered cases in india

ind_rec <- india[, c(1, 4 + 4 * 0:((ncol(india) - 1) / 4 - 1))]
colnames(ind_rec) <- c("State", 1:(ncol(ind_rec) - 1))
rownames(ind_rec) <- 0:(nrow(ind_rec) - 1)
ind_rec[38, 1] <- "India"
ind_rec[1, 1] <- "Date"
write.csv(ind_rec, "./data/India_Recovered.csv")

# extract number of deceased cases in india

ind_dec <- india[, c(1, 5 + 4 * 0:((ncol(india) - 1) / 4 - 1))]
colnames(ind_dec) <- c("State", 1:(ncol(ind_dec) - 1))
rownames(ind_dec) <- 0:(nrow(ind_rec) - 1)
ind_dec[38, 1] <- "India"
ind_dec[1, 1] <- "Date"
write.csv(ind_dec, "./data/India_Deceased.csv")



# dataframe of total infected cases in India 

df_i=read.csv('./data/India_Infected.csv')
tot_i = df_i %>% filter(State=='India')
total_i=as.integer(t(array(tot_i[,3:ncol(df_i)])))
data_i=data.frame(date = as.Date("2020-03-10") + 0:(ncol(df_i)-3),total_i)
names(data_i)=c('Date','India')

# dataframe of total recovered cases in India 

df_r=read.csv('./data/India_Recovered.csv')
tot_r = df_r %>% filter(State=='India')
total_r=as.integer(t(array(tot_r[,3:ncol(df_r)])))
data_r=data.frame(date = as.Date("2020-03-10") + 0:(ncol(df_r)-3),total_r)
names(data_r)=c('Date','India')

# dataframe of total deceased cases in India 

df_d=read.csv('./data/India_Deceased.csv')
tot_d = df_d %>% filter(State=='India')
total_d=as.integer(t(array(tot_d[,3:ncol(df_d)])))
data_d=data.frame(date = as.Date("2020-03-10") + 0:(ncol(df_d)-3),total_d)
names(data_d)=c('Date','India')

# dataframe of total active cases in India 
data_a=data_r
data_a[,2]=data_i[,2]-data_r[,2]-data_d[,2]

# plot graph of total active cases in India over time

a_ = ggplot(data_a, aes(x=Date, y=India)) +
  labs(
    title="Active Coronavirus Cases in India",
    x="Date", y="Active Cases"
  ) +
  geom_point(colour='lightblue') +
  geom_line() +
  scale_x_date(date_breaks = "months" , date_labels = "%b-%y") +
  scale_y_continuous(n.breaks=7,labels=scales::comma)+
  theme(axis.text.x = element_text(angle = 45, color="blue", size=7, face=7, hjust=1)) + 
  theme(plot.title = element_text(hjust = 0.5)) +   
  theme(plot.title = element_text(color="maroon", size=14, face="bold"), axis.title.x = element_text(color="maroon", size=14),axis.title.y = element_text(color="maroon", size=14)) +
  scale_color_viridis(discrete = TRUE)


a_
# animate

an_ = animate(a_+transition_reveal(Date), renderer = gifski_renderer('./graphs/India_Active.gif'),
              width = 2560, height = 1440, res = 300, fps = 10)

