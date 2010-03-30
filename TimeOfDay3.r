#!/usr/bin/Rscript 
scriptname = "TimeOfDay3"

## Include standard stuff
source("include.r")

## params
par(mar=c(4, 4, 1, 5.7),cex=1.8)

## Get The Data
cat("Getting Data (TimeOfDay) \n")
tod = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 1200 AS 'minutes',count(*) AS 'count',sum(size) AS 'size' from ",db," where method = 'GET' group by TIME_TO_SEC(time) div 1200 "))
cat("Getting Data (HitRate) \n")
tod_hits = dbGetQuery(con, paste("SELECT TIME_TO_SEC(time) div 1200 AS 'minutes',count(*) AS 'count' from ",db," where method = 'GET' and action like '%HIT' group by TIME_TO_SEC(time) div 1200 "))
cat("Calculating X en Y's \n")
tod_x = tod$minutes/3
tod_hitrate = tod_hits$count/tod$count
tod_counts = (tod$count/sum(tod$count))*300
# tod_bytes = (tod$size/sum(tod$size))*300
max_y = max(tod_counts)
cat("Plotting Chart \n")
plot(tod_x,tod_counts,xlab="Hora del Dia",ylab="Pedidos (% por hora)", axes=F, col="blue", type="l", ylim=c(0,max_y))
axis(1, at=c(0:12)*2, labels=c(0:12)*2)
axis(2, las=2)
box()
mtext("Aciertos (%)", side=4, cex=1.8, line=3)
# lines(tod_x,tod_bytes,col="blue",lty=2)
lines(tod_x,tod_hitrate*max_y,col="red",lwd=2)
axis(4, at=c(0:5)*0.2*max_y,labels=c(0:5)*20, las=2)
legend(0,max_y,legend=c("Pedidos", "Aciertos"), col=c("blue","red"), lwd=c(1,2), lty=c(1,1), bty="n")

source("bottom.r")
