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

# Create plot 2 and save it as plot2.png
png(file= "plot2.png",  width = 480, height = 480)
with(sub.household, plot(sub.household$DateTime, sub.household$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
