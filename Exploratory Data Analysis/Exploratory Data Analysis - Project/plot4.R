## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##merge NEI and SCC dataframes
merged <- merge(NEI, SCC, by = "SCC")

##subset on coal and create barplot
Coal <- merged[grepl("Coal", merged$EI.Sector),]
g_coal <- ggplot(Coal, aes(year, Emissions))
g + geom_bar(stat = "identity")

##copy to png file and save
dev.copy(png, file = "plot4.png")

dev.off()