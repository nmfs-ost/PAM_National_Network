library(tmap)
library(dplyr)
library(sf)
library(tmaptools)
library(raster)
library(terra)
library(spData)
library(usmap)

#### Hawaii ####
bbox_HI <- st_bbox(hawaii) # current bounding box

yrange <- bbox_HI$ymax - bbox_HI$ymin # range of y values

#bbox_HI[4] <- bbox_HI[4] + (0.1 * yrange) # ymax - top

bbox_HI <- bbox_HI %>%  # take the bounding box ...
  st_as_sfc() # ... and make it a sf polygon

regional_offices.hawaii <- read.csv("content/code/Regional_offices_hawaii.csv")
geocode.hawaii <- st_as_sf(regional_offices.hawaii, coords = c("Long", "Lat"), crs = 4326)

hawaii <- tm_shape(hawaii, bbox = bbox_HI) +
  tm_fill() +
  tm_borders() +
  tm_shape(geocode.hawaii) +
  tm_bubbles(col = "coral2", fill = "coral2", size = 1, alpha = 1) +
  tm_text("PIFSC", size = 1.6, ymod = 0, xmod = -2, col = "black") +
  tm_layout(title = 'Pacific Islands NOAA Fisheries Science Centers', title.position = c('center', 'top'), title.size = 2) + 
 tm_add_legend(type = "fill", 
labels = c("Northeast Fishery Science centers", "Southeast Fishery Science centers", "Northwest Fishery Science centers", "Southwest Fishery Science centers", "Alaska Fishery Science centers", "Pacific Islands Fishery Science centers", "Multiple Offices", "Headquarters"),
col = c("royalblue","aquamarine","darkred","darkgoldenrod2","springgreen3","coral2", "gray", "black"),
border.lwd = 0.5,
title = "Legend",
is.portrait = F)

hawaii
tmap_save(hawaii, "content/code/output/Hawaii.2.png", dpi = 900)
#tmap_save(hawaii, "content/code/output/Hawaii.3.png", dpi = 900)