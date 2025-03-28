# Load necessary libraries
library(data.table)

# Read and filter data
data <- fread("household_power_consumption.txt", na.strings="?", sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# Convert Date & Time to POSIXct for plotting
subset_data$DateTime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Open PNG device
png("plot4.png", width=480, height=480)

# Set up 2x2 layout for multiple plots
par(mfrow=c(2,2))

# Plot 1: Global Active Power
plot(subset_data$DateTime, as.numeric(subset_data$Global_active_power), 
     type="l", xlab="", ylab="Global Active Power")

# Plot 2: Voltage
plot(subset_data$DateTime, as.numeric(subset_data$Voltage), 
     type="l", xlab="datetime", ylab="Voltage")

# Plot 3: Energy sub metering
plot(subset_data$DateTime, as.numeric(subset_data$Sub_metering_1), 
     type="l", xlab="", ylab="Energy sub metering")
lines(subset_data$DateTime, as.numeric(subset_data$Sub_metering_2), col="red")
lines(subset_data$DateTime, as.numeric(subset_data$Sub_metering_3), col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")

# Plot 4: Global Reactive Power
plot(subset_data$DateTime, as.numeric(subset_data$Global_reactive_power), 
     type="l", xlab="datetime", ylab="Global Reactive Power")

# Close PNG device
dev.off()
