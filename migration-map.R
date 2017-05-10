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
#library(ggmap)

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
map <- getMap(resolution = "low")
#get list of all unique dates and sort them from oldest to newest
pipl$dates <- substr(pipl$OBSERVATION.DATE, start = 6, stop = 10)
dates <- sort(unique(pipl$dates))

for (i in 2:length(dates))
{
  toPlot <- pipl[ which(pipl$dates == dates[i]), ]
  plot(map, xlim = range(coords$lon), ylim = range(coords$lat), asp = 1)
  points(toPlot$LONGITUDE, toPlot$LATITUDE, col = "blue")
  p <- recordPlot()
  png(paste("C:/Users/Brandon/Documents/GitHub/migration-map/img/", i, ".png", sep=""), width=1000, height=872)
  print(p)
  dev.off()
  plot.new()
}
