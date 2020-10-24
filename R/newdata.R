# import new data

library(dplyr)
newdata <- function(){
  dfc = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  dfc = as.data.frame(dfc[ ,c(1,2,3,4,ncol(dfc))])
  names(dfc)[length(names(dfc))]<-"con"
  dfd = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  dfd = as.data.frame(dfd[ ,c(1,2,3,4,ncol(dfd))])
  names(dfd)[length(names(dfd))]<-"death"
  dfr = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")
  dfr = as.data.frame(dfr[ ,c(1,2,3,4,ncol(dfr))])
  all_data = full_join(dfc,dfd)
  all_data = full_join(all_data,dfr)
  return(all_data)
}

m=newdata()
