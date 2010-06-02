#!/usr/bin/Rscript
scriptname = "ObjectSizeCumulative"
source("include.r")

par(mar=c(4,4,1,2), cex=2)
## Get The Data
cat("Getting Data (Requests) \n")
os_reqs = dbGetQuery(con, paste("select size from ",db," where size > 1"))
cat("Getting Data (Uniques) \n")
os_uniq = dbGetQuery(con, paste("select distinct MD5(uri),size from ",db," where size > 1"))
cat("Calculating cumulative functions \n")
sort_reqs <- c(min(os_reqs$size),sort(sample(os_reqs$size, size = 8000)),max(os_reqs$size))
ecdf_reqs <- ((1:length(sort_reqs))/length(sort_reqs)) * 100
sort_uniq <- c(min(os_uniq$size),sort(sample(os_uniq$size, size = 8000)),max(os_uniq$size))
ecdf_uniq <- ((1:length(sort_uniq))/length(sort_uniq)) * 100
# plot 
cat("Plotting Chart \n")
plot(sort_reqs,ecdf_reqs, type="n",log="x",ylab="Acumulativo (%)",xlab="Tamaño de Objeto",xlim=c(100,100000000),axes=F)
axis(1,at=c(100,1000,10000,100000,1000000,10000000,100000000),labels=c("100B","1KB","10KB","100KB","1MB","10MB","100MB"))
axis(2)
lines(sort_reqs,ecdf_reqs,col="red",pch=46)
lines(sort_uniq,ecdf_uniq,col="blue",lty=2,pch=46)
# add top and bottom dotted lines
abline(0,0,lty = "dashed",col="grey", lwd=1.5)
abline(100,0,lty = "dashed",col="grey", lwd=1.5)
# add a legend
legend(1000000,95,legend=c("Pedidos", "Únicos"), col=c("red","blue"), lwd=1:1, lty=1:2, bty="n")

source("bottom.r")