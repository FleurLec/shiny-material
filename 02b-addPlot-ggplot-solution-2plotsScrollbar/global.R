

library(data.table)
library(shiny)
library(dplyr)
library(scales)
library(ggplot2)     ##CHG: add needed package


## Load modules 
  source("./modules/data_management.R")   
  source("./modules/ggplot_functions.R")    ##CHG: add a ggplot functions file

## Create axis
  network <- unique(DFagg.LN$network)


