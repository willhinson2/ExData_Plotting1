library("data.table")

setwd("/Users/williamhinson/Desktop/Coursera")

#Reads in data from file then subsets data for specified dates
DT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# Making Data more user-friendly and removing Scientific notation
DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changing Date type to Posixct to be able to sort by time of day
DT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
DT <- DT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plotting Plot 2
plot(x = DT[, dateTime]
     , y = DT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

