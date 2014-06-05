# Plot 3
# Energy sub metering along the date/time

# The download and transformation process is the same in the four scripts
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

# Ploting energy sub metering along the date/time and saving to a PNG file
    png(filename="ExData_Plotting1/figure/plot3.png", width=480, height=480)
    
    plot(y=pconsum$Sub_metering_1, x=pconsum$Time, type="l"
         , ylab="Energy sub metering", xlab="")
    points(y=pconsum$Sub_metering_2, x=pconsum$Time, type ="l", col="red")
    points(y=pconsum$Sub_metering_3, x=pconsum$Time, type ="l", col="blue")
    legend("topright", pch="_", col=c("black","red","blue"), legend=colnames(pconsum)[7:9])
    
    dev.off()