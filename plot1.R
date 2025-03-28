# Load necessary libraries
library(data.table)

# Read and filter data
data <- fread("household_power_consumption.txt", na.strings="?", sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# Open PNG device
png("plot1.png", width=480, height=480)

# Create the histogram
hist(as.numeric(subset_data$Global_active_power), 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency")

# Close PNG device
dev.off()

