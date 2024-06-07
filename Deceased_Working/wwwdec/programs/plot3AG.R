###############################################################################
## Title: Stacked age and gender distribution across waves                   ##
## Input: mediadata/Master.csv                                               ##
## Output: Plots                                                             ##
## Date Modified: 21st May 2024                                              ##
###############################################################################

# Set current working directory
setwd("/opt/lampp/htdocs/covid19-data-portal/Deceased_Working/wwwdec/")

##Stacked age and gender distribution across waves

#Wave 1
start_age <- 0
end_age <- 120
increment <- 10

wave_1_age_df <- data.frame(age_categ = character(), cnt = integer(), male_to_female_ratio = double())
wave_1_gen_df <- data.frame(age_categ = character(), cnt = integer(), sex = character())
age_categories <- c("0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", "80-90", "90-100", "100-110", "110-120")
i <- 1

while(start_age < end_age)
{
  subdata <- subset(wave_1, wave_1$`Age In Years` >= start_age & wave_1$`Age In Years` <= start_age+increment)
  cnt <- as.numeric(nrow(subdata))
  male <- as.numeric(nrow(subset(subdata, subdata$Sex == "Male")))
  female <- as.numeric(nrow(subset(subdata, subdata$Sex == "Female")))
  ratio <- round((male/female),3)
  if(is.infinite(ratio))
  {
    ratio = "-"
  }
  if(is.nan(ratio))
  {
    ratio = "-"
  }
  new_row <- c(age_categories[i], cnt, ratio)
  wave_1_age_df <- rbind(wave_1_age_df, new_row)
  new_row <- c(age_categories[i], male, "Male")
  wave_1_gen_df <- rbind(wave_1_gen_df, new_row)
  new_row <- c(age_categories[i], female, "Female")
  wave_1_gen_df <- rbind(wave_1_gen_df, new_row)
  start_age <- start_age + increment
  i <- i + 1
}

names(wave_1_age_df) <- c("age_categ", "count", "male_to_female_ratio")
names(wave_1_gen_df) <- c("age_categ", "count", "sex")
wave_1_gen_df$count <- as.numeric(wave_1_gen_df$count)
max_limit <- as.numeric(max(wave_1_gen_df$count))
t1 <- floor(max_limit / 1000) + 1
new_max_limit <- t1 * 1000

g_1_p <- ggplot(wave_1_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,1000), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Wave 1") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28, angle = 45, hjust = 1),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_1_h <- ggplot(wave_1_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,1000), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Wave 1") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18, angle = 45, hjust = 1))
gp_1 <- ggplotly(g_1_h, tooltip = c("x","y"))
name = paste("wave1AgeDistr","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("wave1AgeDistr","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_1_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Wave 2
start_age <- 0
end_age <- 120
increment <- 10

wave_2_age_df <- data.frame(age_categ = character(), cnt = integer(), male_to_female_ratio = double())
wave_2_gen_df <- data.frame(age_categ = character(), cnt = integer(), sex = character())
i <- 1

while(start_age < end_age)
{
  subdata <- subset(wave_2, wave_2$`Age In Years` >= start_age & wave_2$`Age In Years` <= start_age+increment)
  cnt <- as.numeric(nrow(subdata))
  male <- as.numeric(nrow(subset(subdata, subdata$Sex == "Male")))
  female <- as.numeric(nrow(subset(subdata, subdata$Sex == "Female")))
  ratio <- round((male/female),3)
  if(is.infinite(ratio))
  {
    ratio = "-"
  }
  if(is.nan(ratio))
  {
    ratio = "-"
  }
  new_row <- c(age_categories[i], cnt, ratio)
  wave_2_age_df <- rbind(wave_2_age_df, new_row)
  new_row <- c(age_categories[i], male, "Male")
  wave_2_gen_df <- rbind(wave_2_gen_df, new_row)
  new_row <- c(age_categories[i], female, "Female")
  wave_2_gen_df <- rbind(wave_2_gen_df, new_row)
  start_age <- start_age + increment
  i <- i + 1
}

names(wave_2_age_df) <- c("age_categ", "count", "male_to_female_ratio")
names(wave_2_gen_df) <- c("age_categ", "count", "sex")
wave_2_gen_df$count <- as.numeric(wave_2_gen_df$count)
max_limit <- as.numeric(max(wave_2_gen_df$count))
t1 <- floor(max_limit / 1000) + 1
new_max_limit <- t1 * 1000

g_2_p <- ggplot(wave_2_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,1000), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Wave 2") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28, angle = 45, hjust = 1),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_2_h <- ggplot(wave_2_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,1000), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Wave 2") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18, angle = 45, hjust = 1))
gp_1 <- ggplotly(g_2_h, tooltip = c("x","y"))
name = paste("wave2AgeDistr","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("wave2AgeDistr","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_2_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Middle wave
start_age <- 0
end_age <- 120
increment <- 10

mid_wave_age_df <- data.frame(age_categ = character(), cnt = integer(), male_to_female_ratio = double())
mid_wave_gen_df <- data.frame(age_categ = character(), cnt = integer(), sex = character())
age_categories <- c("0-10", "10-20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", "80-90", "90-100", "100-110", "110-120")
i <- 1

while(start_age < end_age)
{
  subdata <- subset(middle_wave, middle_wave$`Age In Years` >= start_age & middle_wave$`Age In Years` <= start_age+increment)
  cnt <- as.numeric(nrow(subdata))
  male <- as.numeric(nrow(subset(subdata, subdata$Sex == "Male")))
  female <- as.numeric(nrow(subset(subdata, subdata$Sex == "Female")))
  ratio <- round((male/female),3)
  if(is.infinite(ratio))
  {
    ratio = "-"
  }
  if(is.nan(ratio))
  {
    ratio = "-"
  }
  new_row <- c(age_categories[i], cnt, ratio)
  mid_wave_age_df <- rbind(mid_wave_age_df, new_row)
  new_row <- c(age_categories[i], male, "Male")
  mid_wave_gen_df <- rbind(mid_wave_gen_df, new_row)
  new_row <- c(age_categories[i], female, "Female")
  mid_wave_gen_df <- rbind(mid_wave_gen_df, new_row)
  start_age <- start_age + increment
  i <- i + 1
}

names(mid_wave_age_df) <- c("age_categ", "count", "male_to_female_ratio")
names(mid_wave_gen_df) <- c("age_categ", "count", "sex")
mid_wave_gen_df$count <- as.numeric(mid_wave_gen_df$count)
max_limit <- as.numeric(max(mid_wave_gen_df$count))
t1 <- floor(max_limit / 1000) + 1
new_max_limit <- t1 * 1000

g_3_p <- ggplot(mid_wave_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,200), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Middle Wave") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 40), axis.title = element_text(color = "#D55E00", size = 34), axis.text.y = element_text(size = 28), axis.text.x = element_text(size = 28, angle = 45, hjust = 1),legend.justification = c("right", "top"),legend.position = c(.95, .95))
g_3_h <- ggplot(mid_wave_gen_df, aes(x = factor(age_categ, levels = age_categories), y = count, fill = sex)) + geom_histogram(stat = "identity", position = "dodge") + scale_fill_viridis_d(option = "plasma") + scale_y_continuous(breaks = seq(0,new_max_limit,200), limits = c(0, new_max_limit)) + labs(x = "Age", y = "Number of deceased", title = "Middle Wave") + theme_minimal() + theme(plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18, angle = 45, hjust = 1))
gp_1 <- ggplotly(g_3_h, tooltip = c("x","y"))
name = paste("midWaveAgeDistr","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_1, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("midWaveAgeDistr","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g_3_p ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

#Combined dataframe for different age categories, across different waves with ratio of male to female
final_ratio_df <- data.frame(age_categ = character(), w1_cnt = integer(), w1_male_to_female_ratio = double(), w1_male = integer(), w1_female = integer(), mw_cnt = integer(), mw_male_to_female_ratio = double(), mw_male = integer(), mw_female = integer(), w2_cnt = integer(), w2_male_to_female_ratio = double(), w2_male = integer(), w2_female = integer())

male_w1 <- subset(wave_1_gen_df, wave_1_gen_df$sex == "Male")
male_w2 <- subset(wave_2_gen_df, wave_2_gen_df$sex == "Male")
male_mw <- subset(mid_wave_gen_df, mid_wave_gen_df$sex == "Male")

female_w1 <- subset(wave_1_gen_df, wave_1_gen_df$sex == "Female")
female_w2 <- subset(wave_2_gen_df, wave_2_gen_df$sex == "Female")
female_mw <- subset(mid_wave_gen_df, mid_wave_gen_df$sex == "Female")

for(i in seq(length(wave_1_age_df$age_categ)))
{
  new_entry <- c(wave_1_age_df$age_categ[i],wave_1_age_df$count[i],wave_1_age_df$male_to_female_ratio[i], male_w1$count[i], female_w1$count[i], mid_wave_age_df$count[i],mid_wave_age_df$male_to_female_ratio[i], male_mw$count[i], female_mw$count[i], wave_2_age_df$count[i],wave_2_age_df$male_to_female_ratio[i], male_w2$count[i], female_w2$count[i])
  final_ratio_df <- rbind(final_ratio_df, new_entry)
}

names(final_ratio_df) <- c("age_categ", "w1_total_cnt", "w1_ratio", "w1_male_cnt", "w1_female_cnt", "mw_total_cnt", "mw_ratio", "mw_male_cnt", "mw_female_cnt", "w2_total_cnt", "w2_ratio", "w2_male_cnt", "w2_female_cnt")
final_ratio_df_for_file <- final_ratio_df[,c(1,2,3,6,7,10,11)]