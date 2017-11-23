
library(data.table)
library(shiny)
library(shinydashboard)
library(dplyr)
library(scales)
library(plotly)
library(ggplot2) 
library(tidyr)         
library(rgdal)        
library(rgeos)       
library(leaflet)      
library(RColorBrewer) 
library(DT)               ##CHG: nice table viz
library(shinyjqui)        ##CHG: javascript capabilities to play with UI applets
library(formattable)      ##CHG: add viz inside tables

## Load modules 
  source("./modules/data_management.R")    
  source("./modules/plotly_functions.R")    
  source("./modules/geodata_management.R")    
  source("./modules/ggplot_functions.R")
  
## Create axis
  network <- unique(DFagg.LN$network)
  LOB <- unique(DFagg.LN$LOB)               
  cols <- data.table(v = levels(DFagg.LN$LOB), colors = c("steelblue", "#dee5e4"))

  
  