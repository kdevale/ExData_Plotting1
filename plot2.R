library(dplyr)
library(chron)
library(datasets)

##################################################################
# Create a 480 by 480m png file with 1 line plot of the data 
#     (Date & Global Active Power)
# done for Data Scientist - Exploratory Data Analysis Class
##################################################################

#read the data
rawData <- read.table("household_power_consumption.txt", 
                      header = TRUE, 
                      sep = ";", 
                      na.strings = "?",
                      stringsAsFactors = FALSE)

##reformat date and time columns
#alter time column to be POSIX standard that includes date
rawData$Time<-as.POSIXct(paste(rawData$Date, rawData$Time), 
                         format= "%d/%m/%Y %H:%M:%S")

#alter the date column to be in "Date" format
rawData$Date <- as.Date(rawData$Date,format= "%d/%m/%Y")

#using dplyr to narrow down rows to the 2 days of interest
data_tbl <- tbl_df(rawData)
data_reduced <- filter(data_tbl, (((as.numeric(Date - as.Date("2007-02-01"))) >= 0) &
                                  ((as.numeric(Date - as.Date("2007-02-02"))) <=0)))


png(filename = "plot2.png", width = 480, height = 480)  ##Open png file

#graph (plot 2) of Date & Global Active Power 
with(data_reduced, plot(Time, Global_active_power, type= "l", 
                        ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()





