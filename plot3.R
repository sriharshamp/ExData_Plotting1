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

# This section of the code creates a png file and plots the data to the 
# png file
png(file = "plot3.png", width = 480, height = 480)
plot(power$time_stamp, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$time_stamp, power$Sub_metering_2, type = "l", col = "red")
lines(power$time_stamp, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, seg.len = 2)
dev.off()