setwd("/home/nitin/Documents/ebooks/Onlinecourses/ExploratoryDataAnalysis/Project1")
##data <- read.csv("household_power_consumption.txt",header = TRUE,sep=";")

##Executed from unix shell to filter records. 
##The command below creates a file with records from feb month and date 1 and 2
##grep '^[1|2]\/2\/2007' household_power_consumption.txt > myfile.txt

data <- read.csv("myfile.txt",header = TRUE,sep=";")

## Append a new column : datetime which contains concatenated date and time.
data$datetime <- paste(data$Date,data$Time,sep=' ')

## Convert the newly added field to datetime.
data[,"datetime"] <- as.POSIXct(strptime(data[,"datetime"],format="%d/%m/%Y %H:%M:%S"))

## Generate Plot 4
png("Plot4.png")
par(mfrow = c(2,2))
with(data,{
  
  ## Plot 1
  plot(data$datetime,data$Global_active_power, type="l", xlab = "" ,ylab = "Global Active Power(kilowatts)")
  
  ## Plot 2
  plot(data$datetime,data$Voltage, type="l", xlab = "datetime" ,ylab = "Voltage")
  
  ## Plot 3
  plot(data$Sub_metering_1 ~ data$datetime ,type="l", xlab = "",ylab = "Energy sub metering")
  lines(data$Sub_metering_2 ~ data$datetime,type="l", col="RED")
  lines(data$Sub_metering_3 ~ data$datetime,type="l", col="BLUE")
  
  ## Add a legend to above plot.
  legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),cex=0.2, lty=c(1,1,1), col=c("BLACK","RED","BLUE"))
  
  ## Plot 4
  plot(data$datetime,data$Global_reactive_power, type="l", xlab = "datetime" ,ylab = "Global reactive power")
  
})
dev.off()
