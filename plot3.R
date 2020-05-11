#Plot 3
#Project
#Coursera Course 4: Exploratory Data Analysis
#Jose A. Ramirez

library(data.table)
library(dplyr)
library(lubridate)
#Store the URL to the zip file
url<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fho)usehold_power_consumption.zip")
#download and rename zip file
download.file(url,"household_power_consumption.zip")

#extract zip file
unzip("household_power_consumption.zip")

#name file features
features<-fread("household_power_consumption.txt")
#Convert character Date to date format using lubridate 
features$Date<-dmy(features$Date)
features_s1<-subset(features,Date>="2007-02-01" & Date<="2007-02-02")

#convert all others to proper classes
features_s1$Global_active_power<-as.numeric(features_s1$Global_active_power)
features_s1$Global_reactive_power<-as.numeric(features_s1$Global_reactive_power)
features_s1$Voltage<-as.numeric(features_sub1$Voltage)
features_s1$Global_intensity<-as.numeric(features_s1$Global_intensity)
features_s1$Sub_metering_1<-as.numeric(features_s1$Sub_metering_1)
features_s1$Sub_metering_2<-as.numeric(features_s1$Sub_metering_2)
features_s1$Sub_metering_3<-as.numeric(features_s1$Sub_metering_3)
features_s1$Time<-as.ITime(features_s1$Time,format="%H:%M:%S")
#summary(features_s1)
#class(features_s1$Time)

# First combine Date and time columents
features_s1[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

#Prepare png file for saving
png("plot3.png", width=480, height=480)
#Line chart for plot #3 including legend

plot(features_s1[, dateTime], features_s1[, Sub_metering_1], type="l", 
     xlab="", 
     ylab="Energy sub metering")
#Create line plots for the other two sub metering stations
lines(features_s1[, dateTime], features_s1[, Sub_metering_2],col="red")
lines(features_s1[, dateTime], features_s1[, Sub_metering_3],col="blue")

#create legend with appropriate colors to match Sub Metering colors shown above
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
dev.off()
