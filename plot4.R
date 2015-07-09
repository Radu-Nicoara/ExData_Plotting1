library(lubridate)

hpcFileName <- "household_power_consumption.txt"

allData<-read.table(hpcFileName,nrows = -1,sep = ';',header = TRUE,na.strings='?')      ## read the data
allData$Date <- as.Date(allData$Date,format='%d/%m/%Y')                                 ## convert the date column to date
allData$Time<-strptime(paste(allData$Date,allData$Time), "%Y-%m-%d %H:%M:%S")           ## convert the time column to datetime

plottingData<-subset(allData,year(Date)== 2007 & month(Date) == 2 & day(Date) %in% c(1,2)) ## subset the data needed for plotting

par(mfrow=c(2,2))     ## define the layout

plot(plottingData$Time,plottingData$Global_active_power,type = "l",xlab="",ylab="Global Active Power",main="",cex.lab=0.8)   ## the first plot. Add a scaling factor to fit in

plot(plottingData$Time,plottingData$Voltage,type = "l",xlab="datetime",ylab="Voltage",main="")                               ## the second plot. Add a scaling factor to fit in

plot(plottingData$Time,plottingData$Sub_metering_1,type = "l",xlab="",ylab="Energy sub metering",main="",col="black",cex.lab=0.8)    ## the third plot. Add a scaling factor to fit in
points(plottingData$Time,plottingData$Sub_metering_2,type = "l",col="red")                                                           ## add the points for sub_metering_2
points(plottingData$Time,plottingData$Sub_metering_3,type = "l",col="blue")                                                          ## add the points for sub_metering_3
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=3,cex=0.8,bty="n")    ## add the legend. Scale the text here as well

plot(plottingData$Time,plottingData$Global_reactive_power,type = "l",xlab="datetime",ylab="Global_reactive_power",main="",cex.axis=0.85,,cex.lab=0.8) ## the forth plot. Scaling here was also necessary

dev.copy(png,file = "plot4.png", width = 480, height = 480) ## save to png
dev.off() ## close the device