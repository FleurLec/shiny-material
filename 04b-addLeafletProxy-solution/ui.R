##CHG: NO CHANGE

### Dashboard UI ######################################################
library(shinydashboard)

shinydashboard::dashboardPage(
  ## 1/ a header
  shinydashboard::dashboardHeader(title = "P&C reporting"),
  
  ## 2/ a Sidebar
  shinydashboard::dashboardSidebar(
    shinydashboard::sidebarMenu(id = "menu",
                                #shinydashboard::menuItem("Open Filters",
                                selectInput("NetWork.In", 
                                            label = h4("Options"),
                                            choices = network, 
                                            selected = levels(network)[1]),
                                selectInput("LOB.In", 
                                            label = h4("Select your Line of Business"),
                                            choices = LOB, 
                                            selected = levels(LOB)[1])
                                #)
    )
  ),
  
  ## 3/ a body
  shinydashboard::dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "mycss.css")),
    shinydashboard::tabItem("xx",                                                  
                            shiny::tabsetPanel(                                    
                              shiny::tabPanel("Table",
                                              fluidRow(tableOutput("TableOut.byNetwork"),
                                                       plotlyOutput("PlotOut.byNetwork"))
                              ),
                              shiny::tabPanel("Leaflet",                         
                                              fluidRow(
                                                selectInput("KPI.In",            
                                                            label = h4("Select your KPI"),
                                                            choices =  list("New Business Rate (%)" = "NB.rate",
                                                                            "Cancellation Rate(%)" = "canc.rate",
                                                                            "NetInflow" = "netInflow"), 
                                                            selected = "New Business Rate (%)"),
                                                leafletOutput("LeafletOut.byAll"))
                              )
                            )
    )  
  )
)