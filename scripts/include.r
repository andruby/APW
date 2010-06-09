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
	fn <- paste("cache/",scriptname,"_data.xz",sep="")
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
 	save(list=list,file=fn,compress="xz")
	cat(system(paste("ls -lh",fn),intern=T),"\n")
}

## output device
if(exists("output_file") == F) {
  output_file = paste("../figures/",scriptname,"_",db,".",sep="")
}
if(exists("export_png") && export_png) {
	output_file = paste(output_file,"png",sep="")
	png(output_file,1024,724)
} else {
	output_file = paste(output_file,"pdf",sep="")
	pdf(output_file,11.6929,8.2677)
}