##Read in the data from the .txt file
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

##Change column classes to character and numeric as appropriate
power$Date <- as.character((power$Date))
power$Time <- as.character((power$Time))
for(i in 3:9) {
        power[,i] <- as.numeric(as.character((power[,i])))
}

##Concatenate Date and Time columns, then change to POSIXlt 
power$Concat_Date_Time <- with(power, paste0(Date, " ", Time))
power$Concat_Date_Time <- strptime(power$Concat_Date_Time, format = "%d/%m/%Y %H:%M:%S")

##Subset only February 1st and 2nd, 2007
library (dplyr)
subset_power <- filter(power, power$Concat_Date_Time > "2007-02-01 00:00:00 PST")
subset_power <- filter(subset_power, subset_power$Concat_Date_Time < "2007-02-02 23:59:59 PST")

##Open PNG and make plot
png(filename = "plot2.png")
plot(subset_power$Concat_Date_Time, subset_power$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()