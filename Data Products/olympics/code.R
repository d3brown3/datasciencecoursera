library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)

setwd("C:/Users/dbrow/datasciencecoursera/Data Products/olympics")

aths <- read.csv("athletes.csv")
aths <- aths[complete.cases(aths),]
aths <- mutate(aths, metalcount = gold + silver + bronze)
aths$dob <- year(mdy(aths$dob))

aths <-
  aths %>% group_by(sport, nationality) %>%
  summarise(total = sum(metalcount), gold = sum(gold),n_athletes = length(nationality)) %>% 
  arrange(desc(total)) %>% filter(total > 0 & gold > 0) %>%
  filter(total > 1 & gold > 1)

g1 <- ggplot() + 
  geom_point(data = aths, aes(x = n_athletes, y = total, color = sport, size = gold), show.legend = FALSE) + 
  geom_text(data = aths, 
            aes(x = n_athletes, y = total, 
                label=ifelse(n_athletes>50 | total > 25, as.character(nationality),''), 
                color = sport), nudge_y = 2.5)
g1 <- ggplotly(g1, width = 1200, height =800)
g1