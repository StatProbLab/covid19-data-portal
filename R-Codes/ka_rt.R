############################################################
## Title: Reproduction Rate of Coronavirus in Karnataka   ##
## Input: IRDD_allka.csv                                  ##  
## Output: Plot of Date Vs mean of Rt                     ##
## Date Modified: 24-04-2024                              ##
############################################################

library(tidyverse)
library(janitor)
library(lubridate)
library(EpiEstim)
library(plotly)
theme_set(theme_gray())

allka <- readr::read_csv("./data/IRDD_allka.csv")

data_tidied = allka[,c(1,2,3)]
colnames(data_tidied) =  c('date','district','confirmed')
data_tidied$date = as.Date(data_tidied$date,'%d-%m-%Y')
last_week_tbl_list <<- list()
data_tidied = na.omit(data_tidied)


fix_negative_incidence <- function(incidence) {
  tail_incidence <- c(0, incidence, 0)
  for(i in 1:length(tail_incidence)) {
    if(tail_incidence[i] < 0) {
      tail_incidence[i] = round(mean(c(tail_incidence[i - 1],
                                       tail_incidence[i + 1])))
    }
  }
  return(tail_incidence[c(-1, -length(tail_incidence))])
}

get_estimates <- function(tbl) {
  tryCatch({
    estimates <- tbl %>%
      mutate(incidence = c(confirmed[1], diff(confirmed))) %>%
      mutate(incidence = fix_negative_incidence(incidence)) %>%
      pull(incidence) %>%
      estimate_R(method = "parametric_si",
                 config = make_config(list(mean_si = 7.5, std_si = 3.4)))
  }, error = function(e) {
    print(e)
    return(NA)
  })
  df <- tibble(date = tbl$date[estimates$R$t_start],
               mean_r = estimates$R$`Mean(R)`,
               p5th = estimates$R$`Quantile.0.05(R)`,
               p95th = estimates$R$`Quantile.0.95(R)`) %>%
    mutate(mean_r = round(mean_r, 3),
           p5th = round(p5th, 3),
           p95th = round(p95th, 3))
  last_week_tbl_list <<- df %>%
    mutate(district = unique(tbl$district)) %>%
    list() %>%
    append(last_week_tbl_list, .)
  
  return(df)
}

get_plot <- function(tbl, index) {
  tryCatch({
    p <- tbl %>%
      get_estimates() %>%
      ggplot(aes(date, mean_r)) +
      geom_area(alpha = .1, fill = "darkgreen") +
      geom_line(color = "darkgreen") +
      #geom_ribbon(aes(ymin = p5th, ymax = p95th), alpha = .2) +
      geom_hline(yintercept = 1, color = "blue") +
      scale_x_date(date_labels = "%b, %y", date_breaks = "3 months") +
      labs(title = unique(tbl$district),
           x = "",
           y = "Mean(R)")
  }, error = function(e) {
    return(NA)
  })
  
  ggsave(plot = p, file = paste0("./karnataka-graphs/", index, ".png"), width = 12,
         height = 6, units = "in")
  
  fig <- ggplotly(p)
  
  htmlwidgets::saveWidget(widget = fig, 
                          selfcontained = F, 
                          file =  paste0("./karnataka-graphs/", index, ".html"),
                          libdir = "./htmlfiles/")
  
}


data_tidied %>%
  filter(date >= as.Date("2020-07-01")) %>%
  group_by(district) %>%
  group_split() %>%
  iwalk(.x = ., ~ get_plot(.x, .y))


last_week_tbl <- bind_rows(last_week_tbl_list)

last_week_tbl %>%
  group_by(district) %>%
  slice(tail(row_number(), 14)) %>%
  ungroup() %>%
  select(date, district, mean_r, p5th, p95th) %>%
  write_csv("./csv/lastweek-karnataka-rt.csv")

last_week_tbl %>%
  group_by(district) %>%
  slice(tail(row_number(), 7)) %>%
  ungroup() %>%
  select(Date = date, district, mean_r) %>%
  mutate(mean_r = round(mean_r, 2),
         Date = format(Date, "%d-%m-%Y")) %>%
  pivot_wider(names_from = c("district"), values_from = c("mean_r")) %>%
  write_csv("./csv/karlastweekR.csv")