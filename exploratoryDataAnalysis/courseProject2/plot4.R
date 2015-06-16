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

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))

png(filename = "./plot4.png", 
    width = 600, height = 600, 
    units = "px")

coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal <- SCC[coal, ]
coal <- NEI[NEI$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

plot(coalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Coal Combustion-related Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()
