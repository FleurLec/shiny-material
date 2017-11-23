
classic = 0

if (classic == 1) {
  
  ### Classic UI ######################################################
    
  shinyUI(fluidPage(theme = "mycss.css", 
      titlePanel("P&C reporting"),
      sidebarLayout(
      ## SIDEBAR PANEL ###
      sidebarPanel(
          ## select NetWork
          selectInput("NetWork.In", 
                     label = h3("Options"),
                     choices = network, 
                     selected = levels(network)[1])
                  ),    
      ## MAIN PANEL ###
      mainPanel(
          tabsetPanel(type = "tabs", 
                      ## TAB 1 ####
                      tabPanel("Main KPIs", 
                                tableOutput("TableOut.byNetwork")
                                ),
                      ##CHG: TAB 2 ####
                      tabPanel("Chart:NB/Canc", 
                               plotOutput("PlotOut.byNetwork.NBC")      ##CHG: Add a plotOutput
                      ),
                      tabPanel("Chart:NetInflow", 
                               plotOutput("PlotOut.byNetwork.NI")      ##CHG: Add a plotOutput
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
                    choices = network, 
                    selected = levels(network)[1])
      )
    ),
    
    ## 3/ a body                           ##CHG: add a CSS inside. Better outside (see next example)
    dashboardBody(
      tags$head(
        tags$style(HTML(".content { background-color: white; height: 90vh; overflow-y:scroll; }"))),
      fluidRow(tableOutput("TableOut.byNetwork"),
               plotOutput("PlotOut.byNetwork.NBC",  height = "300"),             ##CHG: Add a plotOutput
               plotOutput("PlotOut.byNetwork.NI",  height = "300"))              ##CHG: Add a plotOutput
      )
    )
}

  
