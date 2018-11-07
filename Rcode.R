library(tidyverse)
library(maptools)
library(RColorBrewer)
library(classInt)
library(OpenStreetMap)
library(sp)
library(rgeos)
library(tmap)
library(tmaptools)
library(sf)
library(rgdal)
library(geojsonio)

NHSData<- read_csv("NHSDATA.csv")
NHSData <- data.frame(NHSData)
NHSMapSF <- read_shape("England_nhsat_2013/england_nhsat_2013.shp", as.sf = TRUE)
NHSMapSP <- as(NHSMapSF, "Spatial")
NHSDataMap <- append_data(NHSMapSF,NHSData, key.shp = "code", key.data = "New.code", ignore.duplicates = TRUE)
tmap_mode("view")
qtm(NHSDataMap)+
  tm_shape(NHSDataMap) + 
  tm_polygons("One.year.net.survival.for.woman.in.1997", 
              style="jenks",
              palette="YlOrBr",
              midpoint=NA,
              title="Rate for survival",
              alpha = 0.5) + 
  tm_scale_bar(position = c("left", "bottom")) +
  tm_layout(title = "One year net survival for woman diagnosed esophagus cancer in 1997")
