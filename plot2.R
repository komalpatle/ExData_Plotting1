# Load necessary libraries
library(data.table)

# Read and filter data
data <- fread("household_power_consumption.txt", na.strings="?", sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# Convert Date & Time to POSIXct for plotting
subset_data$DateTime <- as.POSIXct(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# Open PNG device
png("plot2.png", width=480, height=480)

# Create the time series plot
plot(subset_data$DateTime, as.numeric(subset_data$Global_active_power), 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

# Close PNG device
dev.off()

