## Loading library
library(RMySQL)
## Loading config
source("config")
## Connect to the db
if(exists("db")) {
  cat(paste("Using the",db,"database on",hostname,"\n"))
  con <- dbConnect(MySQL(), user="apw", password="apw", dbname="apw", host=hostname)
}

## output device
if(exists("output_file") == F) {
  output_file = paste("../charts/",scriptname,"_",db,".eps",sep="")
}
postscript(output_file,onefile=TRUE)