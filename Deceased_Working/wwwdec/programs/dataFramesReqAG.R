#Dataframes required
wave_1 <- data[(data$`MB Date` <= "2020-10-31"),]
wave_1 <- wave_1[!is.na(wave_1$`MB Date`),]
middle_wave <- data[(data$`MB Date` > "2020-10-31") & (data$`MB Date` < "2021-02-01"),]
middle_wave <- middle_wave[!is.na(middle_wave$`MB Date`),]
wave_2 <- data[(data$`MB Date` >= "2021-02-01") & (data$`MB Date` <= "2021-07-31"),]
wave_2 <- wave_2[!is.na(wave_2$`MB Date`),]
#wave_1 <- subset(data,data$`MB Date` <= "2020-10-31")
#middle_wave <- data[(data$`MB Date` > "2020-10-31") & (data$`MB Date` < "2021-02-01"),]
#middle_wave <- middle_wave[!is.na(middle_wave$`MB Date`),]
#wave_2 <- subset(data,data$`MB Date` >= "2021-02-01")
wave_1_no_na <- wave_1[!is.na(wave_1$`Age In Years`),]
wave_2_no_na <- wave_2[!is.na(wave_2$`Age In Years`),]
mid_wave_no_na <- middle_wave[!is.na(middle_wave$`Age In Years`),]
conf_df <- data.frame(District = character(), mean = double(), variance = double(), sd = double())
death_cnt_df <- data.frame(District = character(), wave_1 = integer(), middle_wave = integer(), wave_2 = integer())
wave_conf_df <- data.frame(District = character(), w1_cnt = integer(), mw_cnt = integer(), w2_cnt = integer(), t_w1 = double(), t_mw = double(), t_w2 = double(), mean_w1 = double(), variance_w1 = double(), sd_w1 = double(), mean_mw = double(), variance_mw = double(), sd_mw = double(), mean_w2 = double(), variance_w2 = double(), sd_w2 = double())
age_not_na_data <- data[!is.na(data$`Age In Years`),]
ka_age_distr <- data.frame(age = integer(), fromData = integer(), actual = integer())

#Lists required
death_500 = c()
death_1000 = c()
death_more_than_1000 = c()
cen = c(8.26,8.58,9.39,9.54,9.91,9.45,7.69,7.69,6.26,5.76,4.42,3.51,3.37,2.49,1.74,0.86,1.02)
cen <- floor(100*cen/sum(cen))
age_cnt = c()

#Creating category column
categ <- rep('Wave 1',length(wave_1$District))
wave_1$categ <- categ
categ <- rep('Mid wave',length(middle_wave$District))
middle_wave$categ <- categ
categ <- rep('Wave 2',length(wave_2$District))
wave_2$categ <- categ

#Creating combined dataframe
df = rbind(wave_1,middle_wave,wave_2)

#For creating total population statistic
cen = replace(cen,cen==0,1)

Pop = c()
for (i in 1:17){
  A = rep(i*5-3.5,cen[i])
  Pop <- c(Pop,A)
}
Cen = data.frame(`Age In Years` = Pop)

#t-test
#sub_test_data <- df[df$categ == 'Wave 1' || df$categ == 'Wave 2',]
sub_test_data <- df[df$categ == 'Wave 1' | df$categ == 'Wave 2',]
sub_test_data <- sub_test_data[!is.na(sub_test_data$`Age In Years`),]
#t.test(`Age In Years`~ categ,data=sub_test_data, mu=0, conf=.95, paired = FALSE)
t.test(wave_1$`Age In Years`, wave_2$`Age In Years`)
