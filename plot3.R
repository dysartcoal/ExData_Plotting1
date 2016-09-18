# Recreate Plot 3 Electricity Sub-Metering by day. kilowatts 

# Load the lubridate library for date and time conversions and remove
# existing environment variables so that the default plotting 
library(lubridate)
rm(list=ls())

data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Select only the data for 2007-02-01 and 2007-02-02
# and convert Sub_metering_1 and Sub_metering_2 data to numeric.
plot.data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
for (i in 1:2){
    plot.data[[6 + i]] <- as.numeric(levels(plot.data[[6+i]])[plot.data[[6 + i]]])  
}

# Open the PNG device and write the plot to it.
png("plot3.png", width=480, height=480, units="px")
plot(plot.data$Date+plot.data$Time, plot.data[[7]], type="l", xlab="", ylab="Energy sub metering")
lines(plot.data$Date+plot.data$Time, plot.data[[8]], type="l", col="red")
lines(plot.data$Date+plot.data$Time, plot.data[[9]], type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend=names(plot.data)[7:9])
dev.off()


