#!/usr/bin/Rscript 
scriptname = "ObjectPopularityCum"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)
sample_size = 10000

## Get The Data
if(!read_cache()) {
	cat("Getting Data \n")
	tod = dbGetQuery(con, paste("SELECT MD5(uri),count(*) AS 'count',sum(size) AS 'size' from ",db," where method = 'GET' group by MD5(uri)"))
	cat("Sampling \n")
	count_cum = cumsum(rev(sort(tod$count)))
	size_cum = cumsum(rev(sort(tod$size)))
	count_max <- max(count_cum)
	size_max <- max(size_cum)
	count_sampled <- c(min(count_cum),sort(sample(count_cum, size = sample_size)),max(count_cum))
	size_sampled <- c(min(size_cum),sort(sample(size_cum, size = sample_size)),max(size_cum))
	write_cache(c("count_sampled","size_sampled","count_max","size_max"))
}

cat("Plotting Chart \n")
plot((count_sampled/count_max)*100,xlab="Porcentage de objetos",ylab="Acumulativo", type="n", axes=F)
axis(1, at=c(0:5)*(sample_size/5), labels=c(0:5)*20)
axis(2)

# add top and bottom dotted lines
abline(0,0,lty = "solid",col="grey", lwd=0.5)
abline(100,0,lty = "solid",col="grey", lwd=0.5)

lines((count_sampled/count_max)*100,col="red")
lines((size_sampled/size_max)*100,col="blue", lty=2)
legend(sample_size/1.8,70,legend=c("Bytes","Peticiones"), col=c("blue","red"), lwd=1:1, lty=2:1, bty="n")

## close the device
source("bottom.r")
