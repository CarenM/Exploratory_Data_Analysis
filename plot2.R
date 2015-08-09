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

# Create plot and safe as png with defined size
png("plot2.png", width = 480 , height = 480)
plot(x = data$datetime, y = data$Global_active_power, xlab = " ", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()


### Please do not wonder that my weekdays are in German
# Do = Thu, Fr = Fri, Sa = Sat