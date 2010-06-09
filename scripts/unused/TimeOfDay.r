#!/usr/bin/Rscript 
db = "medium"
scriptname = "TimeOfDay"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)

## Get The Data
cat("Getting Data \n")
tod = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 300 AS 'minutes',count(*) AS 'count' from ",db," where method = 'GET' group by TIME_TO_SEC(time) div 300 "))
cat("Plotting Chart \n")
plot(tod$minutes/12,tod$count*20,xlab="Hora del Dia",ylab="Milliones de peticiones GET", type="n", axes=F)
axis(1, at=c(0:12)*2, labels=c(0:12)*2)
axis(2, at=c(0,400000,800000,1200000), labels=c(0,0.4,0.8,1.2))
lines(tod$minutes/12,tod$count*20,col="red")

## close the device
source("bottom.r")
