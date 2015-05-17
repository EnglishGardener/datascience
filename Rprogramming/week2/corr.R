setwd("/Users/dongping/Code/datascience/Rprogramming/week2")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  # set working directory
  if(grep("specdata", directory) == 1) {
    directory <- ("./specdata/")
  }
  # initialize a vector to hold the pollutant data
  correlation_vectors <- c()
  # find all files in the specdata folder
  all_files <- as.character( list.files(directory) )
  file_paths <- paste(directory, all_files, sep="")
  id = 1:332
  for(i in id) {
    current_file <- read.csv(file_paths[i], header=T, sep=",")
    head(current_file)
    na_removed <- sum(!is.na(current_file[,"sulfate"])&!is.na(current_file[,"nitrate"]))
    if(na_removed>threshold)
    {
      sulfatev <- current_file[!is.na(current_file[,"sulfate"])&!is.na(current_file[,"nitrate"]),"sulfate"]
      nitratev <- current_file[!is.na(current_file[,"sulfate"])&!is.na(current_file[,"nitrate"]),"nitrate"]
      correlation<-cor(sulfatev, nitratev)
      correlation_vectors <- c(correlation_vectors, correlation)
    }
  }
  correlation_vectors
  
}