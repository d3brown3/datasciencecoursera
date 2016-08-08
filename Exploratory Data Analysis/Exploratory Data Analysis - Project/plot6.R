## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
merged <- merge(NEI, SCC, by = "SCC")

##subsetting on Baltimore and vehicle sources
BaltandLA <- subset(merged, fips == c("24510", "06037"))
vehicle_sources <- BaltandLA[grepl("[Vv]ehicle", BaltandLA$EI.Sector),]

##create barplot
g_vehicle <- ggplot(vehicle_sources, aes(year, Emissions))
g_vehicle + geom_bar(stat = "identity") + facet_grid(. ~ fips)

##copy to png file and save
dev.copy(png, file = "plot6.png")

dev.off()