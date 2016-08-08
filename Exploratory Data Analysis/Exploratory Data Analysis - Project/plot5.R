## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merged <- merge(NEI, SCC, by = "SCC")

##subsetting on Baltimore, Los Angeles, and vehicle sources
mBaltimore <- subset(merged, fips == "24510")
vehicle_sources <- mBaltimore[grepl("[Vv]ehicle", mBaltimore$EI.Sector),]

##create barplot
g_vehicle <- ggplot(vehicle_sources, aes(year, Emissions))
g_vehicle + geom_bar(stat = "identity")

##copy to png file and save
dev.copy(png, file = "plot5.png")

dev.off()