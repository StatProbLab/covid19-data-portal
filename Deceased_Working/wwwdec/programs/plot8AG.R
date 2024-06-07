###############################################################################
## Title: Box plot for wave and district wise deaths                         ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


##Box plot for wave and district wise deaths

##Wave 1 district wise deaths
wave_1_death = list()
for(i in seq(length(unique_district_names)))
{
  temp <- subset(wave_1,wave_1$District == unique_district_names[i])
  n <- nrow(temp)
  wave_1_death <- append(wave_1_death,n)
}

##Middle wave district wise deaths
mid_wave_death = list()
for(i in seq(length(unique_district_names)))
{
  temp <- subset(middle_wave,middle_wave$District == unique_district_names[i])
  n <- nrow(temp)
  mid_wave_death <- append(mid_wave_death,n)
}

##Wave 2 district wise deaths
wave_2_death = list()
for(i in seq(length(unique_district_names)))
{
  temp <- subset(wave_2,wave_2$District == unique_district_names[i])
  n <- nrow(temp)
  wave_2_death <- append(wave_2_death,n)
}

##Populating dataframe
for(i in seq(length(unique_district_names)))
{
  temp = c(unique_district_names[i],wave_1_death[i],mid_wave_death[i],wave_2_death[i])
  death_cnt_df <- rbind(death_cnt_df,temp)
}

names(death_cnt_df) <- c("District","wave1","midwave","wave2")

##Scatter plot
scatter_death_cnt <- death_cnt_df[death_cnt_df$District != "Bengaluru Urban",]
g_8_p <- ggplot(scatter_death_cnt,aes(x=wave1,y=wave2,color=wave1 + wave2,size = wave1 + wave2,label = District)) + geom_point() + geom_abline(slope = 1, intercept = 0, color = "red") + scale_fill_viridis_d(option = "plasma") + labs(x = "Number of deceased in Wave 1", y = "Number of deceased in Wave 2", title = "Comparing number of deceased across waves district wise") + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28)) + geom_text_repel(aes(label = District),size=3.5)
g_8_h <- ggplot(scatter_death_cnt,aes(x=wave1,y=wave2,color=wave1 + wave2,size = wave1 + wave2,label = District)) + geom_point() + geom_abline(slope = 1, intercept = 0, color = "red") + scale_fill_viridis_d(option = "plasma") + labs(x = "Number of deceased in Wave 1", y = "Number of deceased in Wave 2", title = "Comparing number of deceased across waves district wise") + theme(legend.position = "none", plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_text_repel(aes(label = District),size=3.5)
gp_7 <- ggplotly(g_8_h, tooltip = c("x","y","size","label"))
name <- paste("waveScatter","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_7, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("waveScatter","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_8_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
