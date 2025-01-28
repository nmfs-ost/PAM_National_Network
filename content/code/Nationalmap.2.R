library(tmap)
library(dplyr)
library(sf)
library(stars)
library(tmaptools)
library(ggpubr)
library(cowplot)
library(gridExtra)
library(mapview)
library(raster)
library(RColorBrewer)
library(sf)
library(viridis)
library(ncdf4)
library(leaflet)
library(terra)
library(spData)
library(spDataLarge)
library(ggplot2)
library(fiftystater)
library(mapproj)

regional_offices <- read.csv("content/code/Regional_offices_mainland.csv")
geocode <- st_as_sf(regional_offices, coords = c("Long", "Lat"), crs = 4326)

mainland <- tm_shape(us_states) +
  tm_fill() +
#  tm_polygons(alpha = 0.7, legend.show = FALSE) +
  tm_shape(geocode) +
  tm_bubbles(col = "black", fill = "Regional_office", size = .5) +
  tm_text("Name1", size = 0.7, ymod = 1, xmod = 1, col = "coral3") +
  tm_text("Name2", size = 0.6, ymod = -.8, xmod = -.6) +
  tm_text("Name3", size = 0.6, ymod = .6, xmod = -2) +
  tm_text("Name4", size = 0.6, ymod = -1, xmod = 1) +
  tm_text("Name5", size = 0.7, ymod = -1, xmod = 1.2, col = "blue") +
  tm_text("Name6", size = 0.7, ymod = 0, xmod = 2.7, col = "darkgoldenrod") +
  tm_text("Name7", size = 0.6, ymod = -1, xmod = 1.2) +
  tm_text("Name8", size = 0.6, ymod = -.7, xmod = 0) +
  tm_text("Name9", size = 0.6, ymod = 1.2, xmod = 0) +
  tm_text("Name10", size = 0.6, ymod = 0, xmod = 4.4) +
  tm_text("Name11", size = 0.7, ymod = -1, xmod = 0, col = "darkgreen") +
  tm_text("Name12", size = 0.6, ymod = 1, xmod = 1.2) +
  tm_text("Name13", size = 0.6, ymod = -.8, xmod = 1.2) 

mainland

regional_offices.alaska <- read.csv("content/code/Regional_offices_alaska.csv")
geocode.alaska <- st_as_sf(regional_offices.alaska, coords = c("Long", "Lat"), crs = 4326)

alaska <- tm_shape(alaska) +
  tm_fill() +
  tm_shape(geocode.alaska) +
  tm_bubbles(col = "black", fill = "Regional_office", size = .5) +
  tm_text("Name1", size = 0.7, ymod = 1, xmod = 1, col = "darkorchid4") +
  tm_text("Name2", size = 0.6, ymod = -.8, xmod = -.6) 
alaska

regional_offices.hawaii <- read.csv("content/code/Regional_offices_hawaii.csv")
geocode.hawaii <- st_as_sf(regional_offices.hawaii, coords = c("Long", "Lat"), crs = 4326)

hawaii <- tm_shape(hawaii) +
  tm_fill() +
  tm_borders() +
  tm_shape(geocode.hawaii) +
  tm_bubbles(col = "black", fill = "Regional_office", size = .5) +
  tm_text("Name", size = 0.7, ymod = 1, xmod = 1, col = "cyan4")


mainland
hawaii
alaska

