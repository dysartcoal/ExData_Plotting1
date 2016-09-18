# Recreate Plot 4 containing 4 graphs including Plot2 and Plot3. 

# Load the lubridate library for date and time conversions and remove
# existing environment variables so that the default plotting 
library(lubridate)
rm(list=ls())

data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Select only the data for 2007-02-01 and 2007-02-02
# and convert Global Active Power, Golbal Reactive Power, Voltage, Sub_metering_1 and 
# Sub_metering_2 data to numeric.
plot.data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
plot.data$Global_active_power <- 
    as.numeric(levels(plot.data$Global_active_power)[plot.data$Global_active_power])
plot.data$Global_reactive_power <- 
    as.numeric(levels(plot.data$Global_reactive_power)[plot.data$Global_reactive_power])
plot.data$Voltage <- as.numeric(levels(plot.data$Voltage)[plot.data$Voltage])
for (i in 1:2){
    plot.data[[6 + i]] <- as.numeric(levels(plot.data[[6+i]])[plot.data[[6 + i]]])  
}

# Open the PNG device and write the plot to it.
png("plot4.png", width=480, height=480, units="px")

# 2 rows and 2 columns required. mf col will fill by column first.
par(mfcol=c(2,2))

# Plot Graph 1
plot(plot.data$Date+plot.data$Time, plot.data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")

# Plot Graph2
plot(plot.data$Date+plot.data$Time, plot.data[[7]], type="l", 
     xlab="", ylab="Energy sub metering")
lines(plot.data$Date+plot.data$Time, plot.data[[8]], type="l", col="red")
lines(plot.data$Date+plot.data$Time, plot.data[[9]], type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend=names(plot.data)[7:9])

# Plot Graph 3
plot(plot.data$Date+plot.data$Time, plot.data$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

# Plot Graph 4
plot(plot.data$Date+plot.data$Time, plot.data$Global_reactive_power, type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()


