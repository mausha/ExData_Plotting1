###############################################################################
# This is an R script that creates the fourth plot (plot4.png) 
# required for the Coursera Exploratory Data Analysis course, 
# week-1 assignment:
# A 2x2 matrix containing 4 plots in 2 rows and 2 columns:
#     - Top Left: (plot2 except no units on Y label)
#     - Bottom Left: (plot3)
#     - Top Right: a line graph with Date + Time on x-axis and Voltage on y-axis
#     - Bottom Right: a line graph with Date + Time on x-axis and 
#                     Global_reactive_power on y-axis
###############################################################################

###############################################################################
# Load all required libraries.
library(dplyr)
library(lubridate)

###############################################################################
# 0) Load all of the required data from the data set. 
# download files
if (!file.exists("exdata_data_household_power_consumption.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile = "exdata_data_household_power_consumption.zip")
  unzip("exdata_data_household_power_consumption.zip")
}

###############################################################################
# Loading the data:
# When loading the dataset into R, please consider the following:  
#     - The dataset has 2,075,259 rows and 9 columns. 
#     - We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#     - You may find it useful to convert the Date and Time variables to Date/Time
#       classes in R using the strptime() and as.Date() functions. 
#     - Note that in this dataset missing values are coded as ?. 
power_data <- as_tibble(read.csv("household_power_consumption.txt", header=TRUE,
                                 skip=0, stringsAsFactors = FALSE, sep = ";"))

# Column names:
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;
# Sub_metering_1;Sub_metering_2;Sub_metering_3

# Convert the values in the Date column from character & filter to 2 required days.
power_data <- mutate(power_data, Date = dmy(Date))
power_data <- filter(power_data, 
                     Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

# Convert the remaining column values from character.
power_data <- mutate(power_data,
                     Time = hms(Time),
                     Global_active_power = as.numeric(Global_active_power),
                     Global_reactive_power = as.numeric(Global_reactive_power),
                     Voltage = as.numeric(Voltage),
                     Global_intensity = as.numeric(Global_intensity),
                     Sub_metering_1 = as.numeric(Sub_metering_1),
                     Sub_metering_2 = as.numeric(Sub_metering_2),
                     Sub_metering_3 = as.numeric(Sub_metering_3))

# Filter out missing data.
power_data <- filter(power_data, complete.cases(power_data))


###############################################################################
# Making Plots:
# Our overall goal here is simply to examine how household energy
# usage varies over a 2-day period in February, 2007. Your task is to
# reconstruct the following plots below, all of which were constructed using the
# base plotting system. 
#
# For each plot you should:
#     - Construct the plot and save it to a PNG file with a width of 480 pixels and 
#       a height of 480 pixels.
#     - Name each of the plot files as plot1.png, plot2.png, etc.
###############################################################################

###############################################################################
###############################################################################
# Construct plot4:
# A 2x2 matrix containing 4 plots in 2 rows and 2 columns:
#     - Top Left: (plot2 except no units on Y label)
#     - Bottom Left: (plot3)
#     - Top Right: a line graph with Date + Time on x-axis and Voltage on y-axis
#     - Bottom Right: a line graph with Date + Time on x-axis and 
#                     Global_reactive_power on y-axis

# Open the png file graphic device with the required size.
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Setup to plot a 2x2 matrix of plots, filling in by column
par(mfcol = c(2, 2))

###############################################################################
# Top Left Plot: copy of plot2 code except no units on Y label
plot(power_data$Date + power_data$Time,
     power_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     main = "")

###############################################################################
# Bottom Left Plot: copy of plot3 code

# Construct the initial plot with Sub_metering_1 line graph
plot(power_data$Date + power_data$Time,
     power_data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     main = "")

# Add Sub_metering_2 line graph
lines(power_data$Date + power_data$Time,
      power_data$Sub_metering_2, col = "red")

# Add Sub_metering_3 line graph
lines(power_data$Date + power_data$Time,
      power_data$Sub_metering_3, col = "blue")

# Add a legend at the top right corner of the plot
legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

###############################################################################
# Top Right Plot: 
#    - a line graph with Date + Time on x-axis and Voltage on y-axis
#    - X label: datetime
#    - Y label: (black) Voltage
#    - Title: none
plot(power_data$Date + power_data$Time,
     power_data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     main = "")

###############################################################################
# Bottom Right Plot: 
#    - a line graph with Date + Time on x-axis and Voltage on y-axis
#    - X label: datetime
#    - Y label: (black) Global_reactive_power
#    - Title: none
plot(power_data$Date + power_data$Time,
     power_data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     main = "")

# Close the png graphic device.
dev.off()

###############################################################################
#############################       End of file.        #######################
###############################################################################