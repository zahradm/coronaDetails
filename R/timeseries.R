# timeserie plot of coronaviruce
# satar = start of the date that wants to draw the plot
# end = end of the date that wants to draw the
# country = country
# output is a line plot


#' @title timeseries plot
#'
#' @description Plot with statr and end date by contury of coronaviruce death and confirmed
#'
#' @param start Date of start format of date is
#'
#' @param  end Date
#'
#' @param  country country
#'
#' @return a plot
#' @export
#' @importFrom dplyr filter
#' @importFrom tibble rownames_to_column
#' @importFrom reshape2 melt
#' @importFrom dplyr mutate
#' @importFrom dplyr full_join
#' @importFrom ggplot2 geom_line
#'
#'
#' @example
#' y <- timeseries("2020-01-25","2020-11-25","Iran")

library(dplyr)
library(tibble)
library(reshape2)
library(ggplot2)
library(lubridate)
timeseries <- function(start,end,country){
  datac <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  datac <- do.call(rbind, lapply(split(datac[-c(1, 2)], datac$Country.Region), colSums))
  datac <- as.data.frame(datac)
  datac <- rownames_to_column(datac)
  datac <- datac %>%
    filter(rowname==country)
  datac <- datac[ ,-c(2:3)]
  datac <- melt(datac)
  datac <- datac %>%
    mutate(daily_c = value - lag(value, default = first(value)))
  datac$variable <- stringr::str_replace(datac$variable, '\\X', '')
  datac$variable =format(as.Date(datac$variable, "%m.%d.%y"), "20%y-%m-%d")
  colnames(datac)[2]  <- "date"
  datad <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  datad <- do.call(rbind, lapply(split(datad[-c(1, 2)], datad$Country.Region), colSums))
  datad <- as.data.frame(datad)
  datad <- rownames_to_column(datad)
  datad <- datad %>%
    filter(rowname==country)
  datad <- datad[ ,-c(2:3)]
  datad <- melt(datad)
  datad <- datad %>%
    mutate(daily_d = value - lag(value, default = first(value)))
  datad$variable <- stringr::str_replace(datad$variable, '\\X', '')
  datad$variable =format(as.Date(datad$variable, "%m.%d.%y"), "20%y-%m-%d")
  colnames(datad)[2]  <- "date"
  datac = datac[ ,c(2,4)]
  datad = datad[ ,c(2,4)]
  all = full_join(datac,datad)
  all$date = as.Date(all$date)
  start =as.Date(start)
  end =as.Date(end)
  all = all %>%
    filter(date>=start&date<=end)
  ggplot(all, aes(x=date)) +
    geom_line(aes(y = daily_d,group=1), color = "darkred") +
    geom_line(aes(y = daily_c,group=1), color="steelblue")+
    scale_x_date(date_breaks = "1 month")+theme_minimal()+
    labs(y="count")
}

