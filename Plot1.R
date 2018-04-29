setwd("C:/Users/karim.youannis/Documents/Data Science/Coursera/Exploratory Data Analysis")

library(dplyr)

url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, "./epc.zip")
unzip("./epc.zip")

epc<- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") 

epc2<- epc %>%
    mutate(datetime = as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")) %>%
    select(datetime, Global_active_power:Sub_metering_3) %>%
    filter(datetime >= "2007-02-01" & datetime < "2007-02-03")

png("Plot1.png", width = 480, height = 480, bg = "white")

hist(epc2$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

dev.off()
