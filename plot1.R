library (data.table)

setwd("/Users/williamhinson/Desktop/Coursera")

##Pulling in Data & Removing NA Dates
DT <- data.table::fread(input = "household_power_consumption.txt"
                        , na.strings="?")

# Making Data more user-friendly and removing Scientific notation
DT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Reformatting Date to Requested Date type 
DT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
DT <- DT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plotting Plot 1
hist(DT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()