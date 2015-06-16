# set the working directory and unzip the downloaded data file in the same working directory as where the R scripts are. 

#setwd("~/datascience/exploratoryDataAnalysis/courseProject2")

#unzip the downloaded data file, if necessary
#unzip("./exdata-data-NEI_data.zip")

#check whether two input data objects already in the environment, if not load the input data. 

if (!"NEI" %in% ls()) {
      NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}

if(!"SCC" %in% ls()) {
      SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

baltimore <- NEI[NEI$fips == "24510", ]

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "./plot3.png", 
    width = 800, height = 600, 
    units = "px")

g <- ggplot(baltimore, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") + ylab(expression('Total PM'[2.5]*" Emissions")) +
ggtitle("Total Emissions in Baltimore City, Maryland from 1999 to 2008")

dev.off()

