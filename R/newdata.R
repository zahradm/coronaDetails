# import new data

library(dplyr)
newdata <- function(){
  dfc = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  dfc = as.data.frame(dfc[ ,c(1,2,3,4,ncol(dfc)-1)])
  names(dfc)[length(names(dfc))]<-"confirmed"
  dfd = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  dfd = as.data.frame(dfd[ ,c(ncol(dfd)-1)])
  names(dfd)[length(names(dfd))]<-"deaths"
  all_data = cbind(dfc,dfd)
  return(all_data)
}



