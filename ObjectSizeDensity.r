#!/usr/bin/Rscript
scriptname = "ObjectSizeDensity"
source("include.r")

par(mar=c(4,4,1,2), cex=2)

## Get The Data
between_time = "time between '2009-02-22 00:00:00' and '2009-02-28 23:59:59'"
cat("Getting Data (Requests) \n")
data_all = dbGetQuery(con, paste("select size AS 'size' from ",db," where size > 1 and ",between_time))
cat("Getting Data (Uniques) \n")
data = dbGetQuery(con, paste("select avg(size) AS 'size' from ",db," where size > 1 and ",between_time," group by MD5(uri)"))

## Logaritmic Density Plot
cat("Plotting Chart \n")
plot(density(log10(data_all$size)),main="",col="red",xlim=c(2,8),ylim=c(0,2),xlab="Tamaño de Objeto",ylab="Densidad (%)",axes=FALSE)
axis(1,at=c(2,3,4,5,6,7,8),labels=c("100B","1KB","10KB","100KB","1MB","10MB","100MB"))
axis(2)
lines(density(log10(data$size)),col="blue", lty=2)
legend(6,2,legend=c("Pedidos", "Únicos"), col=c("red","blue"), lwd=1:1, lty=1:2, bty="n")

source("bottom.r")