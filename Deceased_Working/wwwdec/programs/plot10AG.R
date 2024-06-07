###############################################################################
## Title: Monthly deceased percentage across Districts                       ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


##Monthly deceased percentage across Districts

monthly_distr_perc_df <- data.frame(month = integer(), count = integer(), perc = double(), district = character())
months_df <- as.data.frame(table(format(data$DOD, format = "%Y-%m")))
months_df <- months_df[,-c(2)]
months_df <- as.data.frame(months_df)
names(months_df)[1] <- c("month")

for(i in seq(length(unique_district_names)))
{
  subdata <- subset(data, data$District == unique_district_names[i])
  temp_df <- as.data.frame(table(format(subdata$DOD, format = "%Y-%m")))
  names(temp_df) <- c("month","count")
  temp_df$perc <- round(((temp_df$count/sum(temp_df$count))*100),3)
  temp_df <- as.data.frame(temp_df)
  temp_df <- join(months_df, temp_df, by = "month")
  temp_df$count[is.na(temp_df$count)] <- 0
  temp_df$perc[is.na(temp_df$perc)] <- 0
  temp_df$district <- unique_district_names[i]
  monthly_distr_perc_df <- rbind(monthly_distr_perc_df, temp_df)
}

g_p <- ggplot(monthly_distr_perc_df,aes(x=month,y=perc,group=district,color=district)) + geom_line() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Percentage of deceased") + ggtitle("Deceased patients monthwise distribution across districts") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g_h <- ggplot(monthly_distr_perc_df,aes(x=month,y=perc,group=district,color=district)) + geom_line() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Percentage of deceased") + ggtitle("Deceased patients monthwise distribution across districts") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
gp <- ggplotly(g_h, tooltip = c("x","y","group"))
name = paste("linePlotDistr","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("linePlotDistr","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##District wise wave-1 and wave-2 plot peaks

peaks_w1_df <- data.frame(month = character(), count = integer(), percentage = double(), district = character())
wave_1_pop <- nrow(wave_1_no_na)

for(i in seq(length(unique_district_names)))
{
  sub <- subset(wave_1_no_na, wave_1_no_na$District == unique_district_names[i])
  temp_df <- as.data.frame(table(format(sub$DOD, format = "%Y-%m")))
  names(temp_df) <- c("month","count")
  temp_df$perc <- round(((temp_df$count/wave_1_pop)*100),3)
  temp_df$district <- unique_district_names[i]
  temp_df <- as.data.frame(temp_df)
  t <- which(temp_df == max(temp_df[, 3]), arr.ind = T)
  t_row <- temp_df[t[1],]
  peaks_w1_df <- rbind(peaks_w1_df, t_row)
}

g_p <- ggplot(peaks_w1_df,aes(x=month,y=perc,group=district,color=district)) + geom_point() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Maximum percentage of deceased") + ggtitle("Deceased patients maximum percentage districtwise - Wave 1") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g_h <- ggplot(peaks_w1_df,aes(x=month,y=perc,group=district,color=district)) + geom_point() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Maximum percentage of deceased") + ggtitle("Deceased patients maximum percentage districtwise - Wave 1") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
gp <- ggplotly(g_h, tooltip = c("x","y","group"))
name = paste("maxDeathPercDistrWave1","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("maxDeathPercDistrWave1","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

peaks_w2_df <- data.frame(month = character(), count = integer(), percentage = double(), district = character())
wave_2_pop <- nrow(wave_2_no_na)

for(i in seq(length(unique_district_names)))
{
  sub <- subset(wave_2_no_na, wave_2_no_na$District == unique_district_names[i])
  temp_df <- as.data.frame(table(format(sub$DOD, format = "%Y-%m")))
  names(temp_df) <- c("month","count")
  temp_df$perc <- round(((temp_df$count/wave_2_pop)*100),3)
  temp_df$district <- unique_district_names[i]
  temp_df <- as.data.frame(temp_df)
  t <- which(temp_df == max(temp_df[, 3]), arr.ind = T)
  t_row <- temp_df[t[1],]
  peaks_w2_df <- rbind(peaks_w2_df, t_row)
}

g_p <- ggplot(peaks_w2_df,aes(x=month,y=perc,group=district,color=district)) + geom_point() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Maximum percentage of deceased") + ggtitle("Deceased patients maximum percentage districtwise - Wave 2") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28),axis.text.x = element_text(angle=45,hjust = 1,size = 28))
g_h <- ggplot(peaks_w2_df,aes(x=month,y=perc,group=district,color=district)) + geom_point() + scale_color_viridis(discrete = TRUE) + xlab("Months") + ylab("Maximum percentage of deceased") + ggtitle("Deceased patients maximum percentage districtwise - Wave 2") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18),axis.text.x = element_text(angle=45,hjust = 1,size = 18))
gp <- ggplotly(g_h, tooltip = c("x","y","group"))
name = paste("maxDeathPercDistrWave2","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("maxDeathPercDistrWave2","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
