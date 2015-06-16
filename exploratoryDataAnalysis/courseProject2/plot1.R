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

# check the data
#head(NEI)
#head(SCC)
#dim(NEI)
#dim(SCC)

# compute the total emissions in each of the years provided. 
totalEmissions <- aggregate(NEI$Emissions, list(NEI$year), FUN = "sum")

png(filename = "./plot1.png", 
    width = 600, height = 600, 
    units = "px")

plot(totalEmissions, type = "l", xlab = "Year",
main = "Total Emissions in the United States from 1999 to 2008",
ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()

