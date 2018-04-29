library(dplyr)

url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, "./epc.zip")
unzip("./epc.zip")

epc<- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") 

epc2<- epc %>%
    mutate(datetime = as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S")) %>%
    select(datetime, Global_active_power:Sub_metering_3) %>%
    filter(datetime >= "2007-02-01" & datetime < "2007-02-03")

png("Plot3.png", width = 480, height = 480, bg = "white")

plot(epc2$datetime, epc2$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = NA)

points(epc2$datetime, epc2$Sub_metering_1, type = "l", col = "black")

points(epc2$datetime, epc2$Sub_metering_2, type = "l", col = "red")

points(epc2$datetime, epc2$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()
