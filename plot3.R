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

# Change Submetering class to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create plot and safe as png with defined size
png("plot3.png", width = 480 , height = 480)
with(data, plot(datetime, Sub_metering_1, xlab = " ",  ylab = "Energy sub metering", type = "n"))
with(data, lines(datetime, Sub_metering_1, col="black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75)
dev.off()

### Please do not wonder that my weekdays are in German
# Do = Thu, Fr = Fri, Sa = Sat