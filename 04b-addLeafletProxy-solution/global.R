##CHG: NO CHANGE

library(data.table)
library(shiny)
library(dplyr)
library(scales)
library(plotly)
library(tidyr)         
library(rgdal)         
library(rgeos)         
library(leaflet)       
library(RColorBrewer)  


## Load modules 
  source("./modules/data_management.R")    
  source("./modules/plotly_functions.R")    
  source("./modules/geodata_management.R")    ##CHG: load and manage geodata (should be already done and directly loaded)

  
## Create axis
  network <- unique(DFagg.LN$network)
  LOB <- unique(DFagg.LN$LOB)               
  cols <- data.table(v = levels(DFagg.LN$LOB), colors = c("steelblue", "#dee5e4"))

  
  