## Close the Database connection
if(exists("con")) {
  dbDisconnect(con)
}

## close the device
dev.off()
cat(paste("written to file:",output_file,"\n"))

## If the OS is a Mac, open the output file
if (system('uname',intern=T) == 'Darwin') {
  cat("opening file..\n")
  system(paste('open',output_file))
}