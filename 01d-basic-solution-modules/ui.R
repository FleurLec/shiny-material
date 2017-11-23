
classic = 0

if (classic == 1) {
  
### Classic UI ######################################################

  shinyUI(fluidPage(theme = "mycss.css", 
      titlePanel("P&C reporting"),                    ##CHG: app title
      sidebarLayout(
      sidebarPanel(
          ## select NetWork
          selectInput("NetWork.In", 
                     label = h3("Options"),
                     choices = network,               ##CHG: change sources of listbox
                     selected = levels(network)[1])   ##CHG: change first item of listbox
                  ),    
      
      mainPanel(
          tabsetPanel(type = "tabs", 
                      tabPanel("Main KPIs",                          ##CHG: change tab name
                                tableOutput("TableOut.byNetwork")    ##CHG: change dataset loaded
                                )
                   ))
  )))
  
} else
{
### Dashboard UI ######################################################
library(shinydashboard)

  dashboardPage(
    ## 1/ a header
    dashboardHeader(title = "P&C reporting"),
    
    ## 2/ a Sidebar
    dashboardSidebar(
      sidebarMenu(
        selectInput("NetWork.In", 
                    label = h4("Options"),
                    choices = network,                 ##CHG: change sources of listbox
                    selected = levels(network)[1])     ##CHG: change first item of listbox
      )
    ),
    
    ## 3/ a body
    dashboardBody(
      fluidRow(tableOutput("TableOut.byNetwork"))      ##CHG: change dataset loaded
    )
  )
}
