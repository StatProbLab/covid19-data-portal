###############################################################################
## Title: Confidence interval of age - district wise                         ##
## Input: NA                                                                 ##
## Output: Plots                                                             ##
## Date Modified: 3rd May 2024                                               ##
###############################################################################


##Confidence interval of age - district wise

names(conf_df) <- c("District", "mean", "variance", "sd")

for(i in seq(length(unique_district_names)))
{
  sub_data_w1 <- subset(wave_1_no_na, wave_1_no_na$District == unique_district_names[i])
  sub_data_mw <- subset(mid_wave_no_na, mid_wave_no_na$District == unique_district_names[i])
  sub_data_w2 <- subset(wave_2_no_na, wave_2_no_na$District == unique_district_names[i])
  
  w1_n <- nrow(sub_data_w1)
  w2_n <- nrow(sub_data_w2)
  mw_n <- nrow(sub_data_mw)
  t_w1 <- round(qt(0.05/2, w1_n-1, lower.tail = FALSE),2)
  t_mw <- round(qt(0.05/2, mw_n-1, lower.tail = FALSE),2)
  t_w2 <- round(qt(0.05/2, w2_n-1, lower.tail = FALSE),2)
  w1_t1 <- round(mean(sub_data_w1$`Age In Years`),2)
  w1_t2 <- round(var(sub_data_w1$`Age In Years`),2)
  w1_t3 <- round(sqrt(w1_t2),2)
  mw_t1 <- round(mean(sub_data_mw$`Age In Years`),2)
  mw_t2 <- round(var(sub_data_mw$`Age In Years`),2)
  mw_t3 <- round(sqrt(mw_t2),2)
  w2_t1 <- round(mean(sub_data_w2$`Age In Years`),2)
  w2_t2 <- round(var(sub_data_w2$`Age In Years`),2)
  w2_t3 <- round(sqrt(w2_t2),2)
  
  temp <- data.frame(unique_district_names[i],w1_n,mw_n,w2_n,t_w1,t_mw,t_w2,w1_t1,w1_t2,w1_t3,mw_t1,mw_t2,mw_t3,w2_t1,w2_t2,w2_t3)
  wave_conf_df <- rbind(wave_conf_df,temp)
}

names(wave_conf_df) <- c("District","w1_cnt","mw_cnt","w2_cnt","t_w1","t_mw","t_w2","mean_w1","var_w1","sd_w1","mean_mw","var_mw","sd_mw","mean_w2","var_w2","sd_w2")
temp <- rep('h',length(wave_conf_df$w1_cnt))

for(i in seq(length(wave_conf_df$w1_cnt)))
{
  if(wave_conf_df$mean_w1[i] >= wave_conf_df$mean_w2[i])
  {
    temp[i] <- 'h'
  }
  else
  {
    temp[i] <- 'l'
  }
}

wave_conf_df$diff_mean <- temp

g1 <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w1)) + geom_pointrange(aes(x = District, ymin = mean_w1 - sd_w1, ymax = mean_w1 + sd_w1, col=diff_mean)) + xlab("Districts") + ylab("Mean age of deceased - Wave 1") + ggtitle("Age of deceased WAVE 1") + theme_minimal() + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w1)) + coord_flip()
g2 <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w2)) + geom_pointrange(aes(x = District, ymin = mean_w2 - sd_w2, ymax = mean_w2 + sd_w2, col=diff_mean)) + xlab("") + ylab("Mean age of deceased - Wave 2") + ggtitle("Age of deceased WAVE 2") + theme_minimal() + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.text.x = element_text(size = 18),axis.title.x = element_text(color = "#D55E00", size=20),plot.title = element_text(color = "#D55E00", face="bold",size=24)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w2)) + coord_flip()

##t-interval
g1_t <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w1)) + geom_pointrange(aes(x = District, ymin = mean_w1 - ((t_w1*sd_w1)/round(sqrt(w1_cnt))), ymax = mean_w1 + ((t_w1*sd_w1)/round(sqrt(w1_cnt))), col=diff_mean)) + xlab("Districts") + ylab("Mean age of deceased - Wave 1") + ggtitle("Age of deceased WAVE 1") + theme_minimal() + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w1)) + coord_flip()
g2_t <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w2)) + geom_pointrange(aes(x = District, ymin = mean_w2 - ((t_w2*sd_w2)/round(sqrt(w2_cnt))), ymax = mean_w2 + ((t_w2*sd_w2)/round(sqrt(w2_cnt))), col=diff_mean)) + xlab("") + ylab("Mean age of deceased - Wave 2") + ggtitle("Age of deceased WAVE 2") + theme_minimal() + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.text.x = element_text(size = 18),axis.title.x = element_text(color = "#D55E00", size=20),plot.title = element_text(color = "#D55E00", face="bold",size=24)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w2)) + coord_flip()

g1_t_sub <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w1)) + geom_pointrange(aes(x = District, ymin = mean_w1 - ((t_w1*sd_w1)/round(sqrt(w1_cnt))), ymax = mean_w1 + ((t_w1*sd_w1)/round(sqrt(w1_cnt))), col=diff_mean)) + xlab("Districts") + ylab("Mean age of deceased - Wave 1") + ggtitle("Age of deceased WAVE 1 vs WAVE 2") + theme_minimal() + theme(legend.position = "none",plot.title = element_text(color = "#D55E00",face = "bold", size = 24), axis.title = element_text(color = "#D55E00", size = 20), axis.text.y = element_text(size = 18), axis.text.x = element_text(size = 18)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w1)) + coord_flip()
g2_t_sub <- wave_conf_df %>% arrange(mean_w1) %>% mutate(District=factor(District, levels=District)) %>% ggplot(aes(x = District, y = mean_w2)) + geom_pointrange(aes(x = District, ymin = mean_w2 - ((t_w2*sd_w2)/round(sqrt(w2_cnt))), ymax = mean_w2 + ((t_w2*sd_w2)/round(sqrt(w2_cnt))), col=diff_mean)) + xlab("") + ylab("Mean age of deceased - Wave 2") + ggtitle("Age of deceased WAVE 1 vs WAVE 2") + theme_minimal() + theme(legend.position = "none", axis.text.y = element_blank(), axis.ticks.y = element_blank(),axis.text.x = element_text(size = 18),axis.title.x = element_text(color = "#D55E00", size=20),plot.title = element_text(color = "#D55E00", face="bold",size=24)) + geom_point(show.legend = FALSE) + ggrepel::geom_text_repel(data = wave_conf_df, aes(label = mean_w2)) + coord_flip()

grp_g1 <- subplot(g1, g2, nrows = 1)
grp_g <- ggarrange(g1, g2, ncol = 2, nrow = 1)
gp_5 <- ggplotly(grp_g1)
name <- paste("waveCI","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_5, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("waveCI","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=grp_g ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

grp_g1_t <- subplot(g1_t_sub, g2_t_sub, nrows = 1)
grp_g_t <- ggarrange(g1_t, g2_t, ncol = 2, nrow = 1)
gp_5_t <- ggplotly(grp_g1_t)
name <- paste("waveCI-T","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_5_t, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("waveCI-T","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=grp_g_t ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

##Saving the cI graphs separately

gp_5 <- ggplotly(g1)
name <- paste("waveCI-1","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_5, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("waveCI-1","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g1 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')

gp_5 <- ggplotly(g2)
name <- paste("waveCI-2","html", sep=".")
path <- file.path(getwd(), "graphs", name)
htmlwidgets::saveWidget(gp_5, file=path, selfcontained = FALSE, libdir = "plotly.html")
name1 <- paste("waveCI-2","png",sep=".")
name2 <- paste0("graphs/", name1)
ggsave(name2, plot=g2 ,width = 20, height = 10.7, dpi = 300, units = "in", device='png')
