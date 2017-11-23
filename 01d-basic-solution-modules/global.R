##CHG: data management should be done outside shiny application
##     Here we still embedd data management in shiny app but at least 
##     externalize it so it will be easier to detach it from the app in the future


library(data.table)
library(shiny)
library(dplyr)              ##CHG: add needed package
library(scales)             ##CHG: add needed package

## Load databases
  source("./modules/data_management.R")      ##CHG: call data management file.


## Create axis
  network <- unique(DFagg.LN$network)        ##CHG: create needed axis for UI

