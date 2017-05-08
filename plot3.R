# Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp)
household <- read.table(unz(temp,"household_power_consumption.txt"), sep=";",stringsAsFactor=F,head=TRUE,na.strings="?")

# Set date to USA time to give the right parameters on the x axis
Sys.setlocale(locale = "USA")

# Select dates 2007-02-01 and 2007-02-02.
sub.household <- household[household$Date %in% c("1/2/2007", "2/2/2007"),]

# Convert date and time variables to POSIXlt format
sub.household$DateTime <- strptime(paste0(sub.household$Date,"-", sub.household$Time), format="%d/%m/%Y-%H:%M:%S")

# Subset and convert Submetering data
subMetering1 <- as.numeric(sub.household$Sub_metering_1)
subMetering2 <- as.numeric(sub.household$Sub_metering_2)
subMetering3 <- as.numeric(sub.household$Sub_metering_3)

# Create plot 3 and save it as plot3.png
png(file= "plot3.png",  width = 480, height = 480)
with(sub.household, plot(sub.household$DateTime, sub.household$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
     lines(sub.household$DateTime, subMetering1, type = "l")
     lines(sub.household$DateTime, subMetering2, type = "l", col = "red")
     lines(sub.household$DateTime, subMetering3, type = "l", col = "blue")    
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
