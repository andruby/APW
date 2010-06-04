#!/usr/bin/Rscript 
db = "full"
scriptname = "TimeOfDay2"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)

## Get The Data
cat("Getting Data \n")
tod = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 1200 AS 'minutes',count(*) AS 'count',sum(size) AS 'size' from ",db," where method = 'GET' group by TIME_TO_SEC(time) div 1200 "))
cat("Calculating X en Y's \n")
tod_x = tod$minutes/3
tod_counts = (tod$count/sum(tod$count))*100
tod_bytes = (tod$size/sum(tod$size))*100
cat("Plotting Chart \n")
plot(tod_x,tod_counts,xlab="Hora del Dia",ylab="Percentage", type="n", axes=F)
axis(1, at=c(0:12)*2, labels=c(0:12)*2)
axis(2)
# axis(2, at=c(0,400000,800000,1200000), labels=c(0,0.4,0.8,1.2))
lines(tod_x,tod_bytes,col="blue",lty=2)
lines(tod_x,tod_counts,col="red")
legend(0,0.025,legend=c("Pedidos", "Bytes"), col=c("red","blue"), lwd=1:1, lty=1:2, bty="n")

## close the device
source("bottom.r")
