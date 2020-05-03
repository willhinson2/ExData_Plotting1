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

png("plot4.png", width=480, height=480)

#Setting parameters for Plot 4
par(mfrow=c(2,2))

# Plotting Plot 1
plot(DT[, dateTime], DT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plotting Plot 2
plot(DT[, dateTime],DT[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plotting Plot 3
plot(DT[, dateTime], DT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(DT[, dateTime], DT[, Sub_metering_2], col="red")
lines(DT[, dateTime], DT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue") , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1), bty="n", cex=.5) 

# Plotting Plot 4
plot(DT[, dateTime], DT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()