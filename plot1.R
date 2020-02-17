###############################################################################
# This is an R script that creates the first plot (plot1.png) 
# required for the Coursera Exploratory Data Analysis course, 
# week-1 assignment:
#     - A histogram of Global_active_power
#     - plot is red
#     - X label: (black) Global Active Power (kilowatts)
#     - Y label: (black) Frequency
#     - Title: (black) Global Active Power
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
# Construct plot1:
#     - A histogram of Global_active_power
#     - plot is red
#     - X label: (black) Global Active Power (kilowatts)
#     - Y label: (black) Frequency
#     - Title: (black) Global Active Power

# Open the png file graphic device with the required size.
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Construct the plot
hist(power_data$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Close the png graphic device.
dev.off()

###############################################################################
#############################       End of file.        #######################
###############################################################################