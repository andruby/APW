#!/usr/bin/Rscript 
db = "small"
output_file = paste("Speed_",db,".eps")
## output device
postscript(output_file,onefile=TRUE)

## params
par(mar=c(4,4,3,3))
## Loading library
library(RMySQL)
## Connect to the db
con <- dbConnect(MySQL(), user="apw", password="apw", dbname="apw", host="localhost")
## Get The Data
cat("Getting Data (HITS) \n")
hits = dbGetQuery(con, paste("select size/elapsed as 'speed' from ",db," where action LIKE '%HIT' and size > 1024 and size < 1024000 and elapsed > 0"))
cat("Getting Data (MISSES) \n")
misses = dbGetQuery(con, paste("select size/elapsed as 'speed' from ",db," where action LIKE '%MISS' and size > 1024 and size < 1024000 and elapsed > 0"))
## Logaritmic Density Plot
cat("Plotting Chart \n")
plot(density(misses$speed, from=0, to=500),col="blue",main="Elapsed Time",xlab="Speed (KBps)")
# axis(1,at=c(2,3,4,5,6,7,8),labels=c("100B","1KB","10KB","100KB","1MB","10MB","100MB"))
# axis(2)
lines(density(hits$speed, from=0, to=500),col="red")
legend(400,0.02,legend=c("Cache Hits", "Cache Misses"), col=c("red","blue"), lwd=1:1)

## close the device
dev.off()
cat(paste("written to file: ",output_file))