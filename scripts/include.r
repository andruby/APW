## Loading library
library(RMySQL)
## Loading config
source("config")
## Connect to the db
if(exists("db")) {
  cat(paste("Using the",db,"database on",hostname,"\n"))
  con <- dbConnect(MySQL(), user="apw", password="apw", dbname="apw", host=hostname)
}

## cache functions
read_cache <- function() {
	fn <- paste("data_",scriptname,".gz",sep="")
 	if(file.exists(fn)) {
		cat("Loading Data from File",fn,"\n")
		load(fn, .GlobalEnv)
		return(TRUE)
	} else {
  		return(FALSE)
	}
}

write_cache <- function(list) {
	fn <- paste("data_",scriptname,".gz",sep="")
	cat("Saving Data To File",fn,"\n")
 	save(list=list,file=fn,compress="gzip")
	cat(system(paste("ls -lh",fn,"\n"),intern=T))
}

## output device
if(exists("output_file") == F) {
  output_file = paste("../figures/",scriptname,"_",db,".eps",sep="")
}
postscript(output_file,onefile=TRUE)