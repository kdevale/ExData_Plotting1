library(dplyr)
library(chron)
library(datasets)

##################################################################
# Create a 480 by 480m png file with 1 histogram of the Global 
# Active Power
# done for Data Scientist - Exploratory Data Analysis Class
##################################################################

#read the data
rawData <- read.table("household_power_consumption.txt", 
                      header = TRUE, 
                      sep = ";", 
                      na.strings = "?",
                      stringsAsFactors = FALSE)

##reformat date column
rawData$Date <- as.Date(rawData$Date,format= "%d/%m/%Y")

#using dplyr to narrow down rows to the 2 days of interest
data_tbl <- tbl_df(rawData)
data_reduced <- filter(data_tbl, (((as.numeric(Date - as.Date("2007-02-01"))) >= 0) &
                                  ((as.numeric(Date - as.Date("2007-02-02"))) <=0)))


png(filename = "plot1.png", width = 480, height = 480)  ##Open png file

#histogram (plot 1) of Global Active Power
hist(data_reduced$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
