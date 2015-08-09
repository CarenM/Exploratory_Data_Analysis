# Set working directory 
setwd("./4_Exploratory_Data_Analysis")

# Check size of object
object.size("household_power_consumption.txt")

# Read and subset the data for 1/2/2007 and 2/2/2007
data <- subset(read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses="character"), Date == "1/2/2007" | Date == "2/2/2007")

# Change Global_active_power class to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Create histogram and safe as png with defined size
png("plot1.png", width = 480 , height = 480)
hist(data$Global_active_power, main="Global Active Power", col="red", xlab= "Global Active Power (kilowatts)")
dev.off()
