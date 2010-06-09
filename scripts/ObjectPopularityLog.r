#!/usr/bin/Rscript 
scriptname = "ObjectPopularityLog"
export_png = TRUE

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2.5)
sample_size = 10000
top_percent=0.001

## Get The Data
if(!read_cache()) {
	cat("Getting Data \n")
	tod = dbGetQuery(con, paste("SELECT uri_id,count(*) AS 'count' from ",db,
								" where method = 'GET' and uri_id NOT IN (6960,117) group by uri_id"))
	
	cat("Filtering for top ",top_percent,"% \n")
	sorted = sort(tod$count, decreasing = T)
	# amount = length(sorted)
	# top_data <- sorted[1:(amount*top_percent)]
	# bottom_data <- sorted[(amount*top_percent):amount]
	
	cat("Sampling \n")
	data <- sorted
	# data <- c(top_data,sort(sample(bottom_data, size = sample_size), decreasing = T),min(bottom_data))
	write_cache(c("data"))
}

cat("Plotting Chart \n")
plot(data,xlab="Posición del objeto",ylab="Peticiones", col="red", axes=T,log="xy",pch=".")

## close the device
source("bottom.r")
