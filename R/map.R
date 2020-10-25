
library(maps)
library(ggplot2)
library(dplyr)
map <- function(type,date){
  date = gsub("/" , ".",date)
  date = paste0("X", date)
  if(type=="death"){
    data = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv",header = TRUE)
  }
  if(type=="confirmed"){
    data = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv",header = TRUE)
  }
  data <- data %>%
    select(Country.Region,Lat,Long,date)
  colnames(data)[4]<- "count"
  world_map <- map_data("world")
  mybreaks <- c(1, 20, 100, 1000, 50000)
  ggplot() +
    geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
    geom_point(data=data, aes(x=Long, y=Lat, size=count, color=count),stroke=F, alpha=0.7) +
    scale_size_continuous(name="Cases", trans="log", range=c(1,7),breaks=mybreaks, labels = c("1-19", "20-99", "100-999", "1,000-49,999", "50,000+")) +
    scale_color_viridis_c(option="inferno",name="Cases", trans="log",breaks=mybreaks, labels = c("1-19", "20-99", "100-999", "1,000-49,999", "50,000+")) +
    theme_void() +
    guides( colour = guide_legend()) +
    theme(
      legend.position = "bottom",
      text = element_text(color = "#22211d"),
      plot.background = element_rect(fill = "#ffffff", color = NA),
      panel.background = element_rect(fill = "#ffffff", color = NA),
      legend.background = element_rect(fill = "#ffffff", color = NA)
    )

}


