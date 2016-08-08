## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subsetting on Baltimore
Baltimore <- subset(NEI, fips == "24510")

##create barplot
g <- ggplot(Baltimore, aes(year, Emissions))
g + geom_bar(stat = "identity") + facet_grid(. ~ type) + theme(axis.text.x = element_text(size = 6))

##copy to png file and save
dev.copy(png, file = "plot3.png")

dev.off()