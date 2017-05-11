##############################
#
# Migration Map
#
# Visualize migrations of
# different bird species
# from eBird data.
#
# Brandon Edwards
# May 2017
##############################

##############################
# Clear Memory
##############################

remove(list = ls())

##############################
# Libraries to Use
##############################

library(rworldmap)
library(rworldxtra)
library(ggmap)
library(mapproj)

##############################
# File IO
##############################
pipl <- read.csv("data.txt", header = TRUE, sep = "\t")

##############################
# Create map
##############################

#coordinates obtained from http://www.latlong.net/
coords <- read.csv("coords.csv")

#creates empty map object
map <- get_map(location = 'Iowa', zoom = 4)

#get list of all unique dates and sort them from oldest to newest
pipl$dates <- substr(pipl$OBSERVATION.DATE, start = 6, stop = 10)
dates <- sort(unique(pipl$dates))

for (i in 2:length(dates))
{
  toPlot <- pipl[ which(pipl$dates == dates[i]), ]
  p <- ggmap(map, legend.position = "none", main = dates[i])
  toPlot$count <- as.numeric(toPlot$OBSERVATION.COUNT)
  toPlot$count = (toPlot$count)/2
  p <- p + geom_point(data = toPlot, aes(x = LONGITUDE, y = LATITUDE, colour = "red", size = count), show.legend = FALSE)
  p <- p + ggtitle(dates[i])
  
  png(paste("C:/Users/Brandon/Documents/GitHub/migration-map/img/", i, ".png", sep=""), width=800, height=698)
  print(p)
  dev.off()
  plot.new()
}
