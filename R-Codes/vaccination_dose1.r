###############################################################
## Title: Total Dose1 Vaccination in Districts of Karnataka  ##
## Input: VaccinationTimeSeries-FirstDose.csv                ##
##        pop.csv                                            ##
## Output: Plot of Date Vs Total Dose1 Vaccination           ##
## Date Modified: 01-05-2024                                 ##
###############################################################

library(tidyverse)
library(janitor)
library(lubridate)
library(EpiEstim)
library(plotly)
library(svglite)

FILENAME <- "./csv/old/VaccinationTimeSeries-FirstDose.csv"
GRAPHSAVEPATH <- "./graphs/"

# Reading CSV files into data frames
data <- read.csv(file = FILENAME, check.names = FALSE)
popdf = read.csv("./csv/old/pop.csv")

# Required indices and column length
NCOL <- ncol(data)
DISTRICT_INDICES <- 1:31

DATES <- as.Date(colnames(data)[2:NCOL], "%b-%d")

# Function to generate plots
makePlots <- function(df, TITLE, COLOR, YLAB) {
    # Required settings/formats for text on plots
    f1 <- list(family = "serif", size = 17, color = 'maroon',face="bold")
    f2 <- list(family = "serif", size = 13, color = 'maroon',face="bold")
    f3 <- list(family = "serif", size = 14, color = 'black')

    date_ticks <- seq(as.Date("2021-01-17"), tail(df$dates, 1), "1 week")

    TICKVALS <- format(as.Date(as.character(date_ticks)), "%Y-%m-%d")
    TICKTEXT <- as.character(format(date_ticks, "%b-%d"))

    fig <- plot_ly(df, x = ~dates, y = ~count, type="scatter" ,mode = 'lines+markers',
                   line = list(color = COLOR), hoverinfo = 'text',
                   text = ~paste('</br> Date: ', format(dates, "%d-%b-%y"),
                                 '</br> Total vaccinated:', count,
                                 '</br> Percentage Vaccinated: ', perc))

    fig <- fig %>% add_trace(df, x = ~dates, y = ~count, type = "scatter",
                             mode = "markers+lines", marker = list(color = COLOR),
                             textposition = 'center', showlegend = FALSE)

    fig <- fig %>% layout(title = TITLE, font = f2,
                          yaxis = list(title = YLAB, titlefont = f1,
                                       tickfont = f3, showgrid = T, showline = T,
                                       zeroline = F),
                          xaxis = list(title = "", tickangle = -45, tickfont = f3,
                                       showgrid = T, showline = T, tickvals = TICKVALS,
                                       ticktext = TICKTEXT))
    return(fig)

}

vacdose1csv <- NULL
rbind(vacdose1csv, c("", as.character(DATES))) -> vacdose1csv
colnames(vacdose1csv) <- c("", as.character(1 : (ncol(vacdose1csv) - 1)))

for (index in DISTRICT_INDICES) {

    district_name <- as.character(data[index, 1])
    if(index == 31) {
        district_name <- "Karnataka"
    }
    district_code <- index

    vacdose1 <- cumsum(as.integer(data[index, 2:length(data[index, ])]))
    dist_pop <- as.integer(popdf[index, 5])
    percentage <- round(vacdose1 / dist_pop, dig=3)
    vacdose1df <- data.frame(dates = DATES, count = vacdose1, perc = percentage)
    vacdose1plot  <- makePlots(vacdose1df, district_name, "#d55e00", "Total Vaccinations - Dose 1")

    # Saving vacdose1 svg and plotly
    name1 = paste(district_code, "kar-vacdose1.svg", sep="-")
    name2 = paste0(GRAPHSAVEPATH, name1)
    #orca(vacdose1plot, file = name2)
    save_image(vacdose1plot, file = name2)
    name = paste(district_code , "kar-vacdose1.html", sep="-")
    path <- file.path(getwd(), GRAPHSAVEPATH, name)
    htmlwidgets::saveWidget(vacdose1plot, file=path, selfcontained = FALSE, libdir = "plotly.html")

    rbind(vacdose1csv, c(district_name, vacdose1)) -> vacdose1csv

}

write.csv(x = vacdose1csv, "./csv/karvacdose1.csv" , row.names = FALSE, quote = FALSE)
