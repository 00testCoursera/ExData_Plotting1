# Download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp)
household <- read.table(unz(temp,"household_power_consumption.txt"), sep=";",stringsAsFactor=F,head=TRUE,na.strings="?")

# Select dates 2007-02-01 and 2007-02-02.
sub.household <- household[household$Date %in% c("1/2/2007", "2/2/2007"),]

# Convert date and time variables to POSIXlt format
sub.household$DateTime <- strptime(paste0(sub.household$Date,"-", sub.household$Time), format="%d/%m/%Y-%H:%M:%S")

# Create plot 1 and save it as plot1.png
png(file= "plot1.png",  width = 480, height = 480)
with(sub.household, hist(sub.household$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
