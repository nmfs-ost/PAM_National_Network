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
library(gridExtra)
library(grid)
library(png)

regional_offices <- read.csv("content/code/Regional_offices_mainland.csv")
geocode <- st_as_sf(regional_offices, coords = c("Long", "Lat"), crs = 4326)

mainland <- tm_shape(us_states) +
  tm_fill() +
  tm_shape(geocode) +
  tm_polygons(legend.show = F) +
  tm_bubbles(col = "black", fill = "Office", size = .5) +
  tm_text("Name1", size = 0.8, ymod = 0, xmod = 2, col = "coral3") +
  tm_text("Name2", size = 0.6, ymod = 0, xmod = -1.9) +
  tm_text("Name3", size = 0.6, ymod = 0, xmod = -1.7) +
  tm_text("Name4", size = 0.6, ymod = 0.8, xmod = -1.3) +
  tm_text("Name5", size = 0.8, ymod = 0, xmod = 3, col = "deepskyblue4") +
  tm_text("Name6", size = 0.8, ymod = 0, xmod = 2.4, col = "darkgoldenrod") +
  tm_text("Name7", size = 0.8, ymod = 0, xmod = 3) +
  tm_text("Name8", size = 0.8, ymod = -.7, xmod = 0) +
  tm_text("Name9", size = 0.8, ymod = 1, xmod = 0) +
  tm_text("Name10", size = 0.8, ymod = 0, xmod = 4) +
  tm_text("Name11", size = 0.8, ymod = 0, xmod = 3, col = "darkgreen") +
  tm_text("Name12", size = 0.8, ymod = .8, xmod = 3) +
  tm_text("Name13", size = 0.8, ymod = -.6, xmod = 3) 

mainland
tmap_save(mainland, "content/code/output/Mainland.png", dpi = 900)

#### Alaska  ####
regional_offices.alaska <- read.csv("content/code/Regional_offices_alaska.csv")
geocode.alaska <- st_as_sf(regional_offices.alaska, coords = c("Long", "Lat"), crs = 4326)

alaska <- tm_shape(alaska) +
  tm_fill() +
  tm_shape(geocode.alaska) +
  tm_bubbles(col = "black", fill = "darkorchid3", size = 1) +
  tm_text("Name1", size = 1.3, ymod = 1, xmod = 0, col = "darkorchid4") +
  tm_text("Name2", size = 1.3, ymod = -.8, xmod = -.6) 

alaska
tmap_save(alaska, "content/code/output/Alaska.png", dpi = 900)


#### Hawaii ####

regional_offices.hawaii <- read.csv("content/code/Regional_offices_hawaii.csv")
geocode.hawaii <- st_as_sf(regional_offices.hawaii, coords = c("Long", "Lat"), crs = 4326)

hawaii <- tm_shape(hawaii) +
  tm_fill() +
  tm_borders() +
  tm_shape(geocode.hawaii) +
  tm_bubbles(col = "black", fill = "cyan3", size = 1) +
  tm_text("Name", size = 1.3, ymod = 0, xmod = -5, col = "cyan4") +
  tm_add_legend(type = "fill", 
                labels = c("NEFSC", "SEFSC", "NWFSC", "SWFSC", "AFSC", "PIFSC"),
                col = c("coral2","darkgoldenrod1","deepskyblue4","chartreuse3","darkorchid3","cyan3"),
                border.lwd = 0.5,
                title = "Office",
                is.portrait = F)

hawaii
tmap_save(hawaii, "content/code/output/Hawaii.png", dpi = 900)

       