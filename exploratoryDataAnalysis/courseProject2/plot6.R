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


baltimoreAndLA <- NEI[NEI$fips == "24510"|NEI$fips == "06037", ]

motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- baltimoreAndLA[baltimoreAndLA$SCC %in% motor$SCC, ]

library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot6.png", width = 800, height = 600, units = "px")

g <- ggplot(motor, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") +
      ylab(expression('Total PM'[2.5]*" Emissions")) +
      ggtitle("Comparison of Total Emissions From Motor Vehicle Sources\n in Baltimore City and Los Angeles County from 1999 to 2008") +
      scale_colour_discrete(name = "Group", label = c("Los Angeles Country","Baltimore City"))

dev.off()
