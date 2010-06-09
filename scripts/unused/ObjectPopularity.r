#!/usr/bin/Rscript 
scriptname = "ObjectPopularity"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)
sample_size = 1000
top_percent=0.001

## Get The Data
if(!read_cache()) {
	cat("Getting Data \n")
	tod = dbGetQuery(con, paste("SELECT uri_id,count(*) AS 'count' from ",db,
								" where method = 'GET' group by uri_id"))
	
	cat("Filtering for top ",top_percent,"% \n")
	amount = length(tod$count)
	data <- sort(tod$count, decreasing = T)[1:(amount*top_percent)]
	
	cat("Sampling \n")
	#data <- c(max(data),sort(sample(data, size = sample_size), decreasing = T),min(data))
	write_cache(c("data"))
}

cat("Plotting Chart \n")
plot(data,xlab="Porcentaje de objetos (%)",ylab="Peticiones", type="n", axes=F)
axis(1, at=c(0:5)*(length(data)/5), labels=c(0:5)*(20*top_percent))
axis(2)

lines(data,col="red")
polygon(c(0,data),col="red",border="red")

## close the device
source("bottom.r")
