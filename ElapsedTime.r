#!/usr/bin/Rscript 
## Parameters
db = "small"
from_kbytes = 1
to_kbytes = 5
output_file = paste("ElapsedTime_",db,"_",from_kbytes,"k.eps", sep="")

## Include standard stuff
source("include.r")

par(mar=c(4,4,3,3))

## Build this chart
cat("Getting Data (HITS) \n")
hits = dbGetQuery(con, paste("select elapsed from ",db," where action LIKE '%HIT' and size > ",from_kbytes*1024," and size < ",to_kbytes*1024))
cat("Getting Data (MISSES) \n")
misses = dbGetQuery(con, paste("select elapsed from ",db," where action LIKE '%MISS' and size > ",from_kbytes*1024," and size < ",to_kbytes*1024))
cat("Plotting Chart \n")
plot(ecdf(hits$elapsed),col="red",main=paste("Elapsed Time (objects ",from_kbytes,"-",to_kbytes,"KB)",sep=""),xlab="Elapsed Time (ms)",ylab="Cumulative Percent",xlim=c(0,800), pch=46, verticals=TRUE)
lines(ecdf(misses$elapsed),col="blue", pch=46, verticals=TRUE)
legend(600,0.2,legend=c("Cache Hits", "Cache Misses"), col=c("red","blue"), lwd=1:1)

## Include standard closing stuff
source("bottom.r")