#!/usr/bin/Rscript 
scriptname = "Bandwidth"

## Include standard stuff
source("include.r")

## params
par(mar=c(4, 4, 1, 5.7),cex=1.8)

## Sequential timeslots per 20 minutes since the start of the year
mysql_year_seconds="(TIME_TO_SEC(time) + TO_DAYS(time) * (24*60*60)) div 1200"

## Get The Data
cat("Getting Data (Total BW) \n")
bw_total = dbGetQuery(con, paste("SELECT ",mysql_year_seconds," AS 'slot',count(*) AS sum(size) AS 'size' from ",db," group by ",mysql_year_seconds))
cat("Getting Data (NON HIT BW) \n")
bw_nonhit = dbGetQuery(con, paste("SELECT ",mysql_year_seconds," AS 'slot',count(*) AS sum(size) AS 'size' from ",db," where action like '%HIT' group by ",mysql_year_seconds))

cat("Calculating X en Y's \n")
bw_x = bw_total$slot
# turn bytes per 20 minutes into Megabits per seconds
bw_total = (bw_total$size * 8) / (1200 * 1024 * 1024)
bw_nonhit = (bw_nonhit$size * 8) / (1200 * 1024 * 1024)

max_y = max(bw_total)

cat("Plotting Chart \n")
plot(bw_x,bw_total,xlab="Tiempo",ylab="Ancho de banda (Mbits)", axes=F, col="blue", type="l", ylim=c(0,max_y))
#axis(1, at=c(0:12)*2, labels=c(0:12)*2)
axis(1)
axis(2, las=2)
box()
lines(bw_x,bw_total,col="blue",lty=1,lwd=1)
lines(bw_x,bw_nonhit,col="red",lty=2,lwd=2)

legend(0,max_y,legend=c("Total", "Real"), col=c("blue","red"), lwd=c(1,2), lty=c(1,1), bty="n")

source("bottom.r")