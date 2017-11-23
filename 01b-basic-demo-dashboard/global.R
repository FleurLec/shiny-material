##CHG: NO CHANGES

library(data.table)
library(shiny)
library(shinydashboard)

DF <- data.table(
  network = c("Agt", "Dir", "Brk"),
  portfolio = c(4500000, 1200000, 3300000),
  CR = c(98.2, 97.3, 100.4)
  )


