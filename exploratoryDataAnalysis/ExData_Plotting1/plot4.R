## Script load_data.R reads the input data and creates a subset of the data for plotting purpose. 
## First check whether it has the file in the current dir.
if (!"load_data.R" %in% list.files()) {
      setwd("~/datascience/exploratoryDataAnalysis/ExData_Plotting1/")
} 
source("load_data.R")

## set the format for the figures
png(filename = "plot4.png", 
    width = 480, 
    height = 480,
    units = "px", 
    bg = "transparent")

par(mfrow = c(2, 2))

## Plot the figures in order

## Top-left
plot(DateTime, 
     Global_active_power, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Global Active Power")

## Top-right
plot(DateTime, 
     Voltage,
     type = "l",
     col = "black",
     xlab = "datetime", 
     ylab = "Voltage")

## Bottom-left
plot(DateTime, 
     Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering")
## add Sub_metering_2 and Sub_metering_3
lines(DateTime, Sub_metering_2, col = "red")
lines(DateTime, Sub_metering_3, col = "blue")
# Add the legend without the border.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

## Bottom-right
plot(DateTime, 
     Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", 
     ylab = colnames(newData)[4])

dev.off()