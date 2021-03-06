library(leaflet)
library(dplyr)

setwd("C:/Users/dbrow/datasciencecoursera/Data Products/meteorites")

mets <- read.csv("meteorite-landings.csv")
mets <- mets[complete.cases(mets),]
names(mets)[8:9] <- c("lat", "lng")
mets <- subset(mets, !(lng == 0 & lat == 0))

mets <- mets %>%
          mutate(year.mass = paste("year", year, "- mass", mass))

mets %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(popup = ~as.character(year.mass), 
             clusterOptions = markerClusterOptions())
