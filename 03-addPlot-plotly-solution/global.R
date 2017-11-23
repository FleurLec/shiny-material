

library(data.table)
library(shiny)
library(dplyr)
library(scales)
library(plotly)    ##CHG: replace ggplot2 by plotly


## Load modules 
  source("./modules/data_management.R")   
  source("./modules/plotly_functions.R")    ##CHG: add a ggplot functions file

## Create axis
  network <- unique(DFagg.LN$network)
  LOB <- unique(DFagg.LN$LOB)                 ##CHG: add LOB + choose color for LOB
  cols <- data.table(v = levels(DFagg.LN$LOB), colors = c("steelblue", "#dee5e4"))


  
