library(lubridate)

hpcFileName <- "household_power_consumption.txt"

allData<-read.table(hpcFileName,nrows = -1,sep = ';',header = TRUE,na.strings='?')      ## read the data
allData$Date <- as.Date(allData$Date,format='%d/%m/%Y')                                 ## convert the date column to date
allData$Time<-strptime(paste(allData$Date,allData$Time), "%Y-%m-%d %H:%M:%S")           ## convert the time column to datetime

plottingData<-subset(allData,year(Date)== 2007 & month(Date) == 2 & day(Date) %in% c(1,2)) ## subset the data needed for plotting

par(mfrow=c(1,1))     ## define the layout

hist(plottingData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)") ## plot as requested

dev.copy(png,file = "plot1.png", width = 480, height = 480) ## save to png
dev.off()       ## close the device