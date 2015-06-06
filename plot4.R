library(dplyr)
library(datasets)
##################################################################
# Create a 480 by 480m png file with 4 plots of the data 
# 
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

#alter date column to be in "date" format
rawData$Date <- as.Date(rawData$Date,format= "%d/%m/%Y")


#using dplyr to narrow down rows to the 2 days of interest
data_tbl <- tbl_df(rawData)
data_reduced <- filter(data_tbl, (((as.numeric(Date - as.Date("2007-02-01"))) >= 0) &
                                  ((as.numeric(Date - as.Date("2007-02-02"))) <=0)))


png(filename = "plot4.png", width = 480, height = 480)  ##Open png file


par(mfcol = c(2,2))  #specify a 2x2 plot alignment filled by columns



with(data_reduced, { 
  #graph (top-left) of Date & Global Active Power 
  plot(Time, Global_active_power, type= "l", 
       ylab = "Global Active Power", xlab = "")

  #graph (bottom-left) of Date & Energy sub metering (X3) w/ legend 
  plot(Time, Sub_metering_1, 
       ylab = "Energy sub metering", xlab = "", type = "n")

     lines(Time, Sub_metering_1)
     lines(Time, Sub_metering_2, col = "red")
     lines(Time, Sub_metering_3, col = "blue")

     legend("topright", legend = c(names(data_reduced[,7]),names(data_reduced[,8]),names(data_reduced[,9])),
       col = c("black","red","blue"), lwd = 1, bty = "n")

   #graph (top-right) of datetime vs. Voltage
   plot(Time, Voltage, xlab = "datetime", type = "l")

   #graph (bottom - right) of datetime vs. Global reactive power
   plot(Time, Global_reactive_power,xlab = "datetime", type = "l")
})

dev.off()



