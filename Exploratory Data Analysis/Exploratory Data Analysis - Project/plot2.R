## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subsetting on Baltimore
Baltimore <- subset(NEI, fips == "24510")

##aggregating emissions by year
Baltimore_apply <- tapply(Baltimore$Emissions, Baltimore$year, sum)
Balt_table <- data.frame(Years = names(Baltimore_apply), Emissions = Baltimore_apply, row.names = NULL)

##creating barplot with a downward sloping trendline
barplot(Balt_table$Emissions)
fit <- lm(Emissions ~ c(1:4), Balt_table)
abline(fit, col = "blue", lwd = 2)

##copy to png file and save
dev.copy(png, file = "plot2.png")

dev.off()
