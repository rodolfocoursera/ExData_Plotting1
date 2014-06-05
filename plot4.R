# Plot 3
# Energy sub metering along the date/time

# The data download and the transformation is the same in the four scripts
# and could be extracted to a function in order to reuse it

# Downloading and unziping the data
    dataUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file  <- "ExData_Plotting1/household_power_consumption.zip"
    download.file(url=dataUrl, destfile=file, method="curl")
    unzip(zipfile=file, exdir="ExData_Plotting1/")

# Loading the dataset in a data frame
    pconsum  <- read.table(file=gsub(pattern=".zip", replacement=".txt", x=file), stringsAsFactors=F
                       , header=T , sep=";")
    head(pconsum)

# Converting the Date variable to Date class
    pconsum$Date  <- as.Date(pconsum$Date, format="%d/%m/%Y")

# Subseting data from the dates 2007-02-01 and 2007-02-02
    pconsum  <- subset(x=pconsum, Date==as.Date('2007-02-01') | Date==as.Date('2007-02-02'))

# Converting the Date/Time variables to Date/Time classes
    pconsum$Time  <- strptime(paste(pconsum$Date,as.character(pconsum$Time)),  format="%Y-%m-%d %H:%M:%S")

# Converting values to numbers
    pconsum$Sub_metering_1  <- as.numeric(pconsum$Sub_metering_1)
    pconsum$Sub_metering_2  <- as.numeric(pconsum$Sub_metering_2)
    pconsum$Sub_metering_3  <- as.numeric(pconsum$Sub_metering_3)

# Setting english languaje (used for the names of the days of the week)
    Sys.setlocale("LC_TIME", "C");

    
# Setting the output device to save the graphics to a PNG file
    png(filename="ExData_Plotting1/plot4.png", width=480, height=480)

# Preparing the frame to plot the four graphics in 2x2
    par(mfcol=c(2,2))
    
# Row=1, Col=1. Ploting Global Active Power along the time
    plot(y=pconsum$Global_active_power, x=pconsum$Time, type="l"
         , ylab="Global Active Power (kilowatts)", xlab="")
    
# Row=2, Col=1. Ploting energy sub metering along the date/time
    plot(y=pconsum$Sub_metering_1, x=pconsum$Time, type="l"
         , ylab="Energy sub metering", xlab="")
    points(y=pconsum$Sub_metering_2, x=pconsum$Time, type ="l", col="red")
    points(y=pconsum$Sub_metering_3, x=pconsum$Time, type ="l", col="blue")
    legend("topright", pch="_", cex=1, box.lwd=0
           , col=c("black","red","blue"), legend=colnames(pconsum)[7:9])
    
# Row=1, Col=2. Ploting Voltage along the time
    with(pconsum,plot(y=Voltage, x=pconsum$Time, type="l", xlab="datetime"))

# Row=2, Col=2. Ploting Global Reactive Power along the time
    with(pconsum,plot(y=Global_reactive_power, x=pconsum$Time, type="l", xlab="datetime"))
    
    dev.off()
