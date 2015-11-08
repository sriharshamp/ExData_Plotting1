# This section of the code reads the data, extracts the required subset from 
# the data set, creates a time stamp column and makes the necessary data 
# type conversions 
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
power_data$Date <- as.Date(power_data$Date,"%d/%m/%Y")
power <- with(power_data, power_data[(power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02"),])
time_stamp <- paste(power$Date, power$Time)
power <- cbind(power, time_stamp, stringsAsFactors = FALSE)
power$time_stamp <- strptime(power$time_stamp, "%Y-%m-%d %H:%M:%S")
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)

# This section of the code creates a png file and plots the data to the 
# png file
png(file = "plot4.png", width = 480, height = 480)
par(mfrow= c(2, 2))
plot(power$time_stamp, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(power$time_stamp, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(power$time_stamp, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$time_stamp, power$Sub_metering_2, type = "l", col = "red")
lines(power$time_stamp, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, seg.len = 1.5, bty = "n")
plot(power$time_stamp, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()