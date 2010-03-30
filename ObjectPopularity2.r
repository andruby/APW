#!/usr/bin/Rscript 
output_file = "../charts/Popularity2_full.eps"

## Include standard stuff
source("include.r")

## params
par(mar=c(4,4,1,2),cex=2)

## Get The Data
cat("Getting Data \n")
data = read.csv('../object_popularity')
sample_size = length(data$cuenta)
cat("Plotting Chart \n")
plot(data$cuenta*100,xlab="Porcentage de objetos",ylab="Acumulativo", type="n", axes=F)
axis(1, at=c(0:5)*(sample_size/5), labels=c(0:5)*20)
axis(2)
box()
lines(data$cuenta*100,col="red")
legend(sample_size/1.8,70,legend=c("Bytes","Peticiones"), col=c("blue","red"), lwd=1:1, lty=2:1, bty="n")

## close the device
source("bottom.r")
