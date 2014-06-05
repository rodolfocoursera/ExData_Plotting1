# Plot 2
# Global Active Power

# The data download and the transformation is the same in the four scripts
# and could be extracted to a function in order to reuse it

# Downloading and unziping the data
# dataUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file  <- "ExData_Plotting1/household_power_consumption.zip"
    download.file(url=dataUrl, destfile=file, method="curl")
    unzip(zipfile=file, exdir="ExData_Plotting1/")

# Loadind the dataset in a data frame
    pconsum  <- read.table(file=gsub(pattern=".zip", replacement=".txt", x=file), stringsAsFactors=F
                           , header=T , sep=";")
    head(pconsum)

# Converting the Date variable to Date class
    pconsum$Date  <- as.Date(pconsum$Date, format="%d/%m/%Y")

# Subseting data from the dates 2007-02-01 and 2007-02-02
    pconsum  <- subset(x=pconsum, Date==as.Date('2007-02-01') | Date==as.Date('2007-02-02'))

# Converting the Date/Time variables to Date/Time classes
    pconsum$Time  <- strptime(paste(pconsum$Date,as.character(pconsum$Time)),  format="%Y-%m-%d %H:%M:%S")

# Converting global active power to numeric
    pconsum$Global_active_power  <- as.numeric(pconsum$Global_active_power)

# Setting english languaje (used for the names of the days of the week)
    Sys.setlocale("LC_TIME", "C");

# Ploting Global Active Power along the time and saving to a PNG file
    png(filename="ExData_Plotting1/figure/plot2.png", width=480, height=480)
    
    plot(y=pconsum$Global_active_power, x=pconsum$Time, type="l"
         , ylab="Global Active Power (kilowatts)", xlab="")
    
    dev.off()