#!/usr/bin/Rscript 
## Parameters
db = "medium"
from_kbytes = 1
to_kbytes = 5
scriptname = paste("ElapsedTimeAll_",from_kbytes,"k", sep="")

## Include standard stuff
source("include.r")

par(mar=c(4,4,3,3),cex=1.5)
colors <- rainbow(6)
actions <- c("TCP_MEM_HIT", "TCP_IMS_HIT", "TCP_HIT", "TCP_CLIENT_REFRESH_MISS", "TCP_REFRESH_HIT", "TCP_MISS")

## Build this chart
cat("Getting Data \n")
all = dbGetQuery(con, paste("select action,elapsed from ",db," where size > ",from_kbytes*1024," and size < ",to_kbytes*1024))
cat("Plotting Chart \n")
plot(0,0,main=paste("Tiempo transcurrido (Objetos ",from_kbytes,"-",to_kbytes,"KB)",sep=""),xlab="Tiempo transcurrido (ms)",ylab="Acumulativo (%)",xlim=c(0,600), ylim=c(0,1), type="n", axes=F)

axis(1)
axis(2, at=c(0,0.25,0.5,0.75,1), labels=c(0,25,50,75,100))
box()

i = 1
for(type in actions) {
  lines(ecdf(all$elapsed[all$action == type]),col=colors[i], pch=46, verticals=TRUE)
  i=i+1
}

legend(270,0.5,legend=actions, col=colors, lwd=1:1, bty="n")

## Include standard closing stuff
source("bottom.r")