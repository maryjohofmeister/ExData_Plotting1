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
#We will only be using data from the dates 2007-02-01 and 
dt<-paste(data$Date, data$Time)
data$dt2<-strptime(as.character(dt), format ="%e/%m/%Y %H:%M:%S")
data$dt3<-as.Date(dt2, format ="%Y-%m-%d %H:%M:%S")
data2<-subset(data, data$dt3 > "2007-01-31" & data$dt3 < "2007-02-03")
data2$myPOSIXct = as.POSIXct(data2$dt2) 


#Plot 2
png(filename="plot2.png", width = 480, height = 480, units = "px")
plot(data2$myPOSIXct,as.numeric(data2$Global_active_power)/1000,xlab= "", ylab= "Global Active Power (kilowatts)", type='l', col='black')
dev.off()
