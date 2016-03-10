#Set Working Drive to the Location of the Dataset on your Computer
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


#Plot 4
png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2, 2))
#1
plot(data2$myPOSIXct,as.numeric(data2$Global_active_power)/1000,xlab= "", ylab= "Global Active Power (kilowatts)", type='l', col='black')
#2
plot(data2$myPOSIXct,as.numeric(data2$Voltage),xlab= "datetime", ylab= "Voltage", type='l', col='black')
#3
plot(data2$myPOSIXct,as.numeric(data2$Sub_metering_1),xlab= "", ylab= "Energy sub metering", type='l', col='black')
points(data2$myPOSIXct,as.numeric(data2$Sub_metering_2), type='l', col='red')
points(data2$myPOSIXct,as.numeric(data2$Sub_metering_3), type='l', col='blue')
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)
#4
plot(data2$myPOSIXct,as.numeric(data2$Global_reactive_power),xlab= "datetime", ylab="Global_reactive_power", type='l', col='black')
dev.off()

