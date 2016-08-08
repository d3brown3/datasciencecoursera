## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##aggregating emissions by year
NEI_apply <- tapply(NEI$Emissions, NEI$year, sum)
NEI_table <- data.frame(Years = names(NEI_apply), Emissions = NEI_apply, row.names = NULL)

##creating barplot with a downward sloping trendline
barplot(NEI_table$Emissions)
fit <- lm(Emissions ~ c(1:4), NEI_table)
abline(fit, col = "blue", lwd = 2)

##copy to png file and save
dev.copy(png, file = "plot1.png")

dev.off()