library(dplyr)
library(tibble)
library(reshape2)
library(ggplot2)
library(dplyr)
library(plotly)
library(hrbrthemes)
timeseries <- function(start,end,country){
  start = gsub("/" , ".",start)
  start = paste0("X",start)
  end = gsub("/" , ".",end)
  end = paste0("X", end)
  datac <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  datac <- do.call(rbind, lapply(split(datac[-c(1, 2)], datac$Country.Region), colSums))
  datac <- as.data.frame(datac)
  datac <- rownames_to_column(datac)
  datac <- subset(datac, rowname == country)
  datac <- datac[ ,-c(2:3)]
  datac <- melt(datac)
  datac <- datac %>%
    mutate(daily_c = value - lag(value, default = first(value)))
  datad <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  datad <- do.call(rbind, lapply(split(datad[-c(1, 2)], datad$Country.Region), colSums))
  datad <- as.data.frame(datad)
  datad <- rownames_to_column(datad)
  datad <- subset(datad, rowname == country)
  datad <- datad[ ,-c(2:3)]
  datad <- melt(datad)
  datad <- datad %>%
    mutate(daily_d = value - lag(value, default = first(value)))

  ggplot(data = datac, aes(x = variable,y = diff))+ geom_line(aes(group=1),size=1)
  return(datac)

}


datac <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
datac <- do.call(rbind, lapply(split(datac[-c(1, 2)], datac$Country.Region), colSums))
datac <- as.data.frame(datac)
datac <- rownames_to_column(datac)
datac <- subset(datac, rowname == country)
datac <- datac[ ,-c(2:3)]
datac <- melt(datac)
datad <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
datad <- do.call(rbind, lapply(split(datad[-c(1, 2)], datad$Country.Region), colSums))
datad <- as.data.frame(datad)
datad <- rownames_to_column(datad)
datad <- subset(datad, rowname == country)
datad <- datad[ ,-c(2:3)]
datad <- melt(datad)
datad <- datad %>%
  mutate(diff = value - lag(value, default = first(value)))
colnames(datad) <- c("rowname","variable","value2",)

datac <- datac %>%
  mutate(diff = value - lag(value, default = first(value)))



