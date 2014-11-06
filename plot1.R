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

png("plot1.png", width=480, height=480)

hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()