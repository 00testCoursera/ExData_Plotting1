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

# Create plot 4 and save it as plot4.png
png(file= "plot4.png",  width = 480, height = 480)

# Make frame for 4 graphics
par(mfrow = c(2,2))
# Create upper left graphic
with(sub.household, plot(sub.household$DateTime, sub.household$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# Create upper right graphic
plot(sub.household$DateTime, sub.household$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
# Create lower left graphic
plot(sub.household$DateTime, sub.household$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(sub.household$DateTime, subMetering1, type = "l")
lines(sub.household$DateTime, subMetering2, type = "l", col = "red")
lines(sub.household$DateTime, subMetering3, type = "l", col = "blue")    
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), bty="n")
# Create lower right graphic
plot(sub.household$DateTime, sub.household$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

