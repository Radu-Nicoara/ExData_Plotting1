library(lubridate)

hpcFileName <- "household_power_consumption.txt"

allData<-read.table(hpcFileName,nrows = -1,sep = ';',header = TRUE,na.strings='?')      ## read the data
allData$Date <- as.Date(allData$Date,format='%d/%m/%Y')                                 ## convert the date column to date
allData$Time<-strptime(paste(allData$Date,allData$Time), "%Y-%m-%d %H:%M:%S")           ## convert the time column to datetime

plottingData<-subset(allData,year(Date)== 2007 & month(Date) == 2 & day(Date) %in% c(1,2)) ## subset the data needed for plotting

par(mfrow=c(1,1))     ## define the layout

plot(plottingData$Time,plottingData$Sub_metering_1,type = "l",xlab="",ylab="Energy sub metering",main="",col="black")   ## plot the first set of points
points(plottingData$Time,plottingData$Sub_metering_2,type = "l",col="red")                                              ## add the sub_metering_2 points
points(plottingData$Time,plottingData$Sub_metering_3,type = "l",col="blue")                                             ## add the sub_metering_3 points
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=3)       ## add the legend

dev.copy(png,file = "plot3.png", width = 480, height = 480) ## save to png
dev.off() ## close the device