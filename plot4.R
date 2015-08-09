# Set working directory 
setwd("./4_Exploratory_Data_Analysis")

# Check size of object
object.size("household_power_consumption.txt")

# Read and subset the data for 1/2/2007 and 2/2/2007
data <- subset(read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character"), Date == "1/2/2007" | Date == "2/2/2007")

# Paste Date and Time into new field and change to format that R recognizes
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")

# Add the Day of the Week
data$day <- weekdays(data$datetime, abbreviate = TRUE)

# Change Global_active_power class to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Change Voltage class to numeric
data$Voltage <- as.numeric(data$Voltage)

# Change Global_reactive_power class to numeric
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

# Create histogram and safe as png with defined size
png("plot4.png", width = 480 , height = 480)
par(mfrow = c(2,2))

# plot top_left
plot(x = data$datetime, y = data$Global_active_power, xlab = " ", ylab = "Global Active Power (kilowatts)", type = "l")

# plot top_right
plot(x = data$datetime, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot bottom_left
with(data, plot(datetime, Sub_metering_1, xlab = " ",  ylab = "Energy sub metering", type = "n"))
with(data, lines(datetime, Sub_metering_1, col="black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1,bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1)

# plot bottom_right
plot(x = data$datetime, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
