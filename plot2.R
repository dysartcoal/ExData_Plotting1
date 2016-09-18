# Recreate Plot 2 showing the Global Active Power in kilowatts 
# by day of the week.

# Load the lubridate library for date and time conversions and remove
# existing environment variables so that the default plotting 
library(lubridate)
rm(list=ls())

data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Select only the data for 2007-02-01 and 2007-02-02
# and convert the Global_active_power data to numeric.
plot.data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
plot.data$Global_active_power <- 
    as.numeric(levels(plot.data$Global_active_power)[plot.data$Global_active_power])


# Open the PNG device and write the plot to it.
png("plot2.png", width=480, height=480, units="px")
plot(plot.data$Date+plot.data$Time, plot.data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()


