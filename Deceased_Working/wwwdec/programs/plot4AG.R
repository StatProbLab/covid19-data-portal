###############################################################################
## Title: Stacked age and gender district wise                               ##
## Input: mediadata/Master.csv                                               ##
## Output: Plots                                                             ##
## Date Modified: 21st May 2024                                              ##
###############################################################################


##Stacked age and gender district wise

unique_district_names <- unique(data$District)
unique_district_names <- sort(unique_district_names)

for(i in seq(length(unique_district_names)))
{
  sub_data <- subset(data, data$District == unique_district_names[i])
  sub_data1 <- subset(age_not_na_data, age_not_na_data$District == unique_district_names[i])
  temp_cnt <- length(sub_data1$`Age In Years`)
  
  #Writing district data
  my_name_1 <- paste(i,"data",sep="-")
  my_name_2 <- paste(my_name_1,"csv",sep=".")
  my_name <- paste0("csv/DistrictAge/", my_name_2)
  write.csv(sub_data, file = my_name, row.names=FALSE)
  
  #Calculating death count in the district for further classification
  if(temp_cnt <= 500)
  {
    death_500 <- append(death_500,unique_district_names[i])
  }
  else if(temp_cnt <= 1000)
  {
    death_1000 <- append(death_1000,unique_district_names[i])
  }
  else
  {
    death_more_than_1000 <- append(death_more_than_1000,unique_district_names[i])
  }
  
  t1 <- round(mean(sub_data1$`Age In Years`),2)
  t2 <- round(var(sub_data1$`Age In Years`),2)
  t3 <- round(sqrt(t2),2)
  temp <- data.frame(unique_district_names[i],t1,t2,t3)
  conf_df <- rbind(conf_df,temp)
  
  #print(ggplot(sub_data, aes(x = `Age In Years`, fill = Sex)) + geom_histogram(bins = 10, position = "dodge") + ggtitle(title) + scale_fill_viridis_d(option = "plasma") + xlab("Age") + ylab("Count"))
  g_p <- ggplot(sub_data, aes(x = `Age In Years`, fill = Sex)) + geom_histogram(bins = 10, position = "dodge") + scale_fill_viridis_d(option = "plasma") + labs(x = "Age", y = "Number of deceased", title = unique_district_names[i]) + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28),legend.justification = c("right", "top"),legend.position = c(.95, .95))
  g_h <- ggplot(sub_data, aes(x = `Age In Years`, fill = Sex)) + geom_histogram(bins = 10, position = "dodge") + scale_fill_viridis_d(option = "plasma") + labs(x = "Age", y = "Number of deceased", title = unique_district_names[i]) + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18))
  gp <- ggplotly(g_h)
  n1 <- paste(i,"age",sep="-")
  name = paste(n1,"html", sep=".")
  path <- file.path(getwd(), "graphs", name)
  htmlwidgets::saveWidget(gp, file=path, selfcontained = FALSE, libdir = "plotly.html")
  name1 <- paste(n1,"png",sep=".")
  name2 <- paste0("graphs/", name1)
  ggsave(name2, plot=g_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
}
