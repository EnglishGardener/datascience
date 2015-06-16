## This R script is for loading the large input dataset and choose the subset from 2007-02-01 to 2007-02-02.
filename <- "./household_power_consumption.txt"
data <- read.table(filename,
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
dim(data) # 2075259 9
attach(data)
## Select 2 days' data for processing.
subset <- Date == "1/2/2007" | Date == "2/2/2007"
subData <- data[subset, ]
attach(newData)
x <- paste(Date, Time)
## add DateTime to the subData as the last column
subData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(subData) <- 1:nrow(subData)
dim(subData) # 2880   10
attach(subData)