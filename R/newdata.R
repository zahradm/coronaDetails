# import new data

library(dplyr)
newdata <- function(){
  dfc = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  dfc = as.data.frame(dfc[ ,c(2,ncol(dfc))])
  names(dfc)[length(names(dfc))]<-"confirmed"
  dfc <- dfc %>%
    group_by(Country.Region) %>%
    summarise(confirmed=sum(confirmed))
  dfd = read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  dfd = as.data.frame(dfd[ ,c(2,ncol(dfd))])
  names(dfd)[length(names(dfd))]<-"deaths"
  dfd <- dfd %>%
    group_by(Country.Region) %>%
    summarise(deaths=sum(deaths))
  dfd = dfd[ ,2]
  all_data = cbind(dfc,dfd)
  write.csv(all_data,"covdata.csv",row.names = FALSE)
}


