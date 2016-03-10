#Set Working Drive to the Location of the Dataset on your Computer to output .png files
setwd("/Users/Josephine/Documents/PAHO_Drive/Coursera/Exploratory")

#run install packages, if not already installed
install.packages("downloader")

#load library
library("downloader")


#Download the data
download(, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header =TRUE)
unlink(temp)
head(data)

#Convert and subset to dates required
dt<-paste(data$Date, data$Time)
data$dt2<-strptime(as.character(dt), format ="%e/%m/%Y %H:%M:%S")
data$dt3<-as.Date(dt2, format ="%Y-%m-%d %H:%M:%S")
data2<-subset(data, data$dt3 > "2007-01-31" & data$dt3 < "2007-02-03")
data2$myPOSIXct = as.POSIXct(data2$dt2) 

#Plot 1. .png outputs to specified file location in my library
png(filename="plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(data2$Global_active_power)/1000, col="red", main = NULL, xlab = NULL, ylab = NULL)
title (main="Global Active Power", xlab ="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
