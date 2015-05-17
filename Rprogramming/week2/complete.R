setwd("/Users/dongping/Code/datascience/Rprogramming/week2")

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  # initialize a vector to hold the pollutant data
  mydata <- data.frame(x=numeric(),y=numeric())
  
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  for(i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")
    head(current_file)
    na_removed <- sum(!is.na(current_file[,"sulfate"])&!is.na(current_file[,"nitrate"]))
 mydata <- rbind(mydata, data.frame(x = i, y = na_removed))
  }
 names(mydata) <- c("id","nobs") # variable names
 
mydata  
}