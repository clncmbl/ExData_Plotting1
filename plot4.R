library(lubridate)
library(dplyr)

datafile <- "../data/household_power_consumption.txt"
data <- read.csv(datafile, sep=";", na.strings="?")

# Select rows for the two days of interest.
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Create an actual datetime column.
data <- mutate(data, datetime=dmy_hms(paste(Date, Time)))

# Eliminate a few columns.
data <- select(data, datetime, Global_active_power, Global_reactive_power, Voltage, starts_with("Sub"))

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

### TOP-LEFT Global Active Power ###

plot(data$datetime,
     data$Global_active_power,
     type="l",
     main="",
     xlab="",
     ylab="Global Active Power")

### TOP-RIGHT Voltage ###

plot(data$datetime,
     data$Voltage,
     type="l",
     main="",
     xlab="datetime",
     ylab="Voltage")

### BOTTOM-LEFT Energy sub metering ###

plot(data$datetime,
     data$Sub_metering_1,
     type="l",
     main="",
     xlab="",
     ylab="Energy sub metering")

lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")

legend("topright",
       lty=1,
       box.lty=0,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))

### BOTTOM-RIGHT Global_reactive_power ###

plot(data$datetime,
     data$Global_reactive_power,
     type="l",
     main="",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()
