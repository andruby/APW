#!/usr/bin/Rscript 
db = "small"
scriptname = "HitRateDay"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)

## Get The Data
cat("Getting Data \n")
tod_hits = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 1200 AS 'minutes',count(*) AS 'count' from ",db," where method = 'GET' and action like '%HIT' and uri_md5 <> '6afe18f284eae8bc4a7c3e777a7a9239' group by TIME_TO_SEC(time) div 1200 "))
tod = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 1200 AS 'minutes',count(*) AS 'count' from ",db," where method = 'GET' and uri_md5 <> '6afe18f284eae8bc4a7c3e777a7a9239' group by TIME_TO_SEC(time) div 1200 "))
cat("Calculating X en Y's \n")
tod_x = tod$minutes/3
tod_hitrate = tod_hits$count/tod$count
cat("Plotting Chart \n")
plot(tod_x,tod_hitrate,xlab="Hora del Dia",ylab="HitRate (Hits/Total) (%)", type="n", axes=F)
axis(1, at=c(0:12)*2, labels=c(0:12)*2)
axis(2)
lines(tod_x,tod_hitrate,col="red")

## close the device
source("bottom.r")
