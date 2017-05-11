##############################
#
# Migration Map
#
# Compare migrations of
# two different bird species
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
# Set Contants
##############################

#These are edited based on what
#species you would like to compare
species1 <- "Piping Plover"
species2 <- "Semipalmated Plover"

##############################
# Libraries to Use
##############################

library(ggmap)
library(mapproj)
library(data.table)
library(gridExtra)

##############################
# File IO
##############################

data <- fread(file.choose())
data2 <- fread(file.choose())

names(data) <- names(data2)

##############################
# Get Commparison Species
##############################
species1Data <- data2
species2Data <- data[ which(data$`COMMON NAME` == species2), ]

remove(data, data2)
##############################
# Create map
##############################

#creates empty map object
map <- get_map(location = 'Iowa', zoom = 4)

#get list of all unique dates and sort them from oldest to newest
species1Data$dates <- substr(species1Data$`OBSERVATION DATE`, start = 6, stop = 10)
species2Data$dates <- substr(species2Data$`OBSERVATION DATE`, start = 6, stop = 10)
dates <- sort(unique(species1Data$dates))

for (i in 2:length(dates))
{
  species1ToPlot <- species1Data[ which(species1Data$dates == dates[i]), ]
  species2ToPlot <- species2Data[ which(species2Data$dates == dates[i]), ]
  
  p1 <- ggmap(map, legend.position = "none")
  p2 <- ggmap(map, legend.position = "none")
  
  species1ToPlot$count <- as.numeric(species1ToPlot$`OBSERVATION COUNT`)
  species2ToPlot$count <- as.numeric(species2ToPlot$`OBSERVATION COUNT`)
  species1ToPlot$count = (species1ToPlot$count)/2
  species2ToPlot$count = (species2ToPlot$count)/2
  
  p1 <- p1 + geom_point(data = species1ToPlot, aes(x = LONGITUDE, y = LATITUDE, colour = "red", size = count), show.legend = FALSE)
  p2 <- p2 + geom_point(data = species2ToPlot, aes(x = LONGITUDE, y = LATITUDE, colour = "red", size = count), show.legend = FALSE)
  
  p1 <- p1 + ggtitle(species1)
  p2 <- p2 + ggtitle(species2)
  png(paste("C:/Users/Brandon/Documents/GitHub/migration-map/img/", i, ".png", sep=""), width=800, height=698)
  grid.arrange(p1, p2, ncol = 2)
  dev.off()
  plot.new()
}
