library(dplyr)
library(chron)
library(datasets)

##################################################################
# Create a 480 by 480m png file with a plot of 3 lines -  
#     Date & Energy sub metering (1-3)
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

rawData$Date <- as.Date(rawData$Date,format= "%d/%m/%Y")

#using dplyr to narrow down rows to the 2 days of interest
data_tbl <- tbl_df(rawData)
data_reduced <- filter(data_tbl, (((as.numeric(Date - as.Date("2007-02-01"))) >= 0) &
                                  ((as.numeric(Date - as.Date("2007-02-02"))) <=0)))


png(filename = "plot3.png", width = 480, height = 480)  ##Open png file

#graph (plot 3) of Date & Energy sub metering w/ legend
with(data_reduced, plot(Time, Sub_metering_1, 
                        ylab = "Energy sub metering", xlab = "", type = "n"))

with(data_reduced, lines(Time, Sub_metering_1))

with(data_reduced, lines(Time, Sub_metering_2, col = "red"))

with(data_reduced, lines(Time, Sub_metering_3, col = "blue"))

legend("topright", legend = c(names(data_reduced[,7]),names(data_reduced[,8]),names(data_reduced[,9])),
       col = c("black","red","blue"), lwd = 1)


dev.off()



