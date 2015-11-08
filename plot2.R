# This section of the code reads the data, extracts the required subset from 
# the data set, creates a time stamp column and makes the necessary data 
# type conversions 
power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
power_data$Date <- as.Date(power_data$Date,"%d/%m/%Y")
power <- with(power_data, power_data[(power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02"),])
time_stamp <- paste(power$Date, power$Time)
power <- cbind(power, time_stamp, stringsAsFactors = FALSE)
power$time_stamp <- strptime(power$time_stamp, "%Y-%m-%d %H:%M:%S")
power$Global_active_power <- as.numeric(power$Global_active_power)

# This section of the code creates a png file and plots the data to the 
# png file
png(file = "plot2.png", width = 480, height = 480)
plot(power$time_stamp, power$Global_active_power,type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()