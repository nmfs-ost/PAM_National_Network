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
library(dplyr)
library(usmap)

# bbox magic

bbox_new <- st_bbox(us_states) # current bounding box


yrange <- bbox_new$ymax - bbox_new$ymin # range of y values

bbox_new[4] <- bbox_new[4] + (0.1 * yrange) # ymax - top

bbox_new <- bbox_new %>%  # take the bounding box ...
  st_as_sfc() # ... and make it a sf polygon


### Mainland ####
NEFSC_offices <- read.csv("content/code/NEFSC_offices.csv")
geocode.NEFSC <- st_as_sf(NEFSC_offices, coords = c("Long", "Lat"), crs = 4326)

WH <- read.csv("content/code/WH.csv")
geocode.WH <- st_as_sf(WH, coords = c("Long", "Lat"), crs = 4326)

NWFSC_offices <- read.csv("content/code/NWFSC_offices.csv")
geocode.NWFSC <- st_as_sf(NWFSC_offices, coords = c("Long", "Lat"), crs = 4326)

Montlake <- read.csv("content/code/Montlake.csv")
geocode.Montlake <- st_as_sf(Montlake, coords = c("Long", "Lat"), crs = 4326)

SEFSC_offices <- read.csv("content/code/SEFSC_offices.csv")
geocode.SEFSC <- st_as_sf(SEFSC_offices, coords = c("Long", "Lat"), crs = 4326)

Miami <- read.csv("content/code/Miami.csv")
geocode.Miami <- st_as_sf(Miami, coords = c("Long", "Lat"), crs = 4326)

SWFSC_offices <- read.csv("content/code/SWFSC_offices.csv")
geocode.SWFSC <- st_as_sf(SWFSC_offices, coords = c("Long", "Lat"), crs = 4326)

La.jolla <- read.csv("content/code/La.jolla.csv")
geocode.La.jolla <- st_as_sf(La.jolla, coords = c("Long", "Lat"), crs = 4326)

AFSC_offices <- read.csv("content/code/AFSC_offices.csv")
geocode.AFSC <- st_as_sf(AFSC_offices, coords = c("Long", "Lat"), crs = 4326)


mainland4 <- tm_shape(us_states, bbox = bbox_new) +
  tm_fill() +
  tm_shape(geocode.WH) +
  tm_squares(col = "royalblue", fill = "royalblue", size = .5, alpha = 1) +
  tm_text("Name1", size = 0.8, ymod = -.7, xmod = 2, col = "black") +
  tm_shape(geocode.NEFSC) +
  tm_polygons(legend.show = F) +
  tm_bubbles(col = "royalblue", fill = "Type", size = .5, alpha = 1) +
  tm_text("Name2", size = 0.7, ymod = 0, xmod = -1.9, col = "black") +
  tm_text("Name3", size = 0.7, ymod = 0, xmod = -1.9, col = "black") +
  tm_text("Name4", size = 0.7, ymod = 0.8, xmod = -1.3, col = "black") +
  tm_shape(geocode.Miami) +
  tm_squares(col = "aquamarine", fill = "aquamarine", size = .5, alpha = 1) +
  tm_text("Name6", size = 0.8, ymod = -.7, xmod = 2, col = "black") +
  tm_shape(geocode.SEFSC) +
  tm_polygons(legend.show = F) +
  tm_bubbles(col = "aquamarine", fill = "Type", size = .5, alpha = 1) +
  tm_text("Name7", size = 0.7, ymod = 0, xmod = 3, col = "black") +
  tm_text("Name8", size = 0.7, ymod = -.7, xmod = 0, col = "black") +
  tm_text("Name9", size = 0.7, ymod = 1, xmod = 0, col = "black") +
  tm_text("Name10", size = 0.7, ymod = 0, xmod = 4, col = "black") +
  tm_shape(geocode.La.jolla) +
  tm_squares(col = "darkgoldenrod2", fill = "darkgoldenrod2", size = .5, alpha = 1) +
  tm_text("Name11", size = 0.8, ymod = 0, xmod = 3, col = "black") +
  tm_shape(geocode.SWFSC) +
  tm_polygons(legend.show = F) +
  tm_bubbles(col = "darkgoldenrod2", fill = "Type", size = .5, alpha = 1) +
  tm_text("Name12", size = 0.7, ymod = .8, xmod = 3, col = "black") +
  tm_text("Name13", size = 0.7, ymod = -.6, xmod = 3, col = "black") +
  tm_shape(geocode.Montlake) +
  tm_polygons(legend.show = F) +
  tm_squares(col = "grey", fill = "Type", size = .5, alpha = 1) +
  tm_text("NWFSC Main Lab (Montlake) and AFSC Main Lab (Sandy Point)", size = 0.8, ymod = 0, xmod = 12.5, col = "black") +
  tm_shape(geocode.NWFSC) +
  tm_polygons(legend.show = F) +
  tm_bubbles(col = "darkred", fill = "Type", size = .4, alpha = 1) +
  tm_text("Name1", size = 0.7, ymod = -.7, xmod = 2.6, col = "black") +
  tm_text("Name2", size = 0.7, ymod = 0, xmod = 2.5, col = "black") +
  tm_text("Name3", size = 0.7, ymod = -.7, xmod = 3, col = "black") +
  tm_text("Name4", size = 0.7, ymod = -.7, xmod = 2.6, col = "black") +
  tm_shape(geocode.AFSC) +
  tm_polygons(legend.show = F) +
 # tm_squares(col = "black", fill = "Type", size = .5, alpha = 0.3) +
 # tm_text("Name14", size = 0.8, ymod = .8, xmod = 5, col = "black") +
  tm_layout(title = 'Mainland NMFS Offices', title.position = c('center', 'top'), title.size = 2) 
  
mainland4
tmap_save(mainland4, "content/code/output/Mainland.4.png", dpi = 900)


#### Alaska  ####

bbox_AK <- st_bbox(alaska) # current bounding box

yrange <- bbox_AK$ymax - bbox_AK$ymin # range of y values

bbox_AK[4] <- bbox_AK[4] + (0.1 * yrange) # ymax - top

bbox_AK <- bbox_AK %>%  # take the bounding box ...
  st_as_sfc() # ... and make it a sf polygon


regional_offices.alaska <- read.csv("content/code/Regional_offices_alaska.csv")
geocode.alaska <- st_as_sf(regional_offices.alaska, coords = c("Long", "Lat"), crs = 4326)

alaska <- tm_shape(alaska, bbox = bbox_AK) +
  tm_fill() +
  tm_shape(geocode.alaska) +
  tm_bubbles(col = "springgreen3", fill = "springgreen3", size = 0.8, alpha = 1) +
  tm_text("Name1", size = 1.3, ymod = 1, xmod = 0, col = "black") +
  tm_text("Name2", size = 1.3, ymod = -.8, xmod = -.6, col = "black") +
  tm_layout(title = 'Alaska NMFS Offices', title.position = c('center', 'top'), title.size = 2) 

alaska
tmap_save(alaska, "content/code/output/Alaska.png", dpi = 900)


#### Hawaii ####
bbox_HI <- st_bbox(hawaii) # current bounding box

yrange <- bbox_HI$ymax - bbox_HI$ymin # range of y values

bbox_HI[4] <- bbox_HI[4] + (0.1 * yrange) # ymax - top

bbox_HI <- bbox_HI %>%  # take the bounding box ...
  st_as_sfc() # ... and make it a sf polygon

regional_offices.hawaii <- read.csv("content/code/Regional_offices_hawaii.csv")
geocode.hawaii <- st_as_sf(regional_offices.hawaii, coords = c("Long", "Lat"), crs = 4326)

hawaii <- tm_shape(hawaii, bbox = bbox_HI) +
  tm_fill() +
  tm_borders() +
  tm_shape(geocode.hawaii) +
  tm_bubbles(col = "coral2", fill = "coral2", size = 0.8, alpha = 1) +
  tm_text("Name", size = 1.3, ymod = 0, xmod = -5, col = "coral2") +
  tm_layout(title = 'Hawaii NMFS Offices', title.position = c('center', 'top'), title.size = 2) +
  tm_add_legend(type = "fill", 
                labels = c("NEFSC", "SEFSC", "NWFSC", "SWFSC", "AFSC", "PIFSC", "Multiple Offices"),
                col = c("royalblue","aquamarine","darkred","darkgoldenrod2","springgreen3","coral2", "gray"),
                border.lwd = 0.5,
                title = "Office",
                is.portrait = F)

hawaii
tmap_save(hawaii, "content/code/output/Hawaii.2.png", dpi = 900)

       