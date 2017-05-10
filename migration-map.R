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
pipl <- read.csv(file.choose(), header = TRUE, sep = "\t")

##############################
# Create map
##############################

#coordinates obtained from http://www.latlong.net/
coords <- read.csv("coords.csv")
map <- getMap(resolution = "low")
plot(map, xlim = range(coords$lon), ylim = range(coords$lat), asp = 1)
