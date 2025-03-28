# Load necessary libraries
library(data.table)

# Read and filter data
data <- fread("household_power_consumption.txt", na.strings="?", sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# Convert Date & Time to POSIXct for plotting
subset_data$DateTime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Open PNG device
png("plot3.png", width=480, height=480)

# Create the plot
plot(subset_data$DateTime, as.numeric(subset_data$Sub_metering_1), 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(subset_data$DateTime, as.numeric(subset_data$Sub_metering_2), col="red")
lines(subset_data$DateTime, as.numeric(subset_data$Sub_metering_3), col="blue")

# Add legend
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)

# Close PNG device
dev.off()
