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
                                                  div(class="outer", 
                                                  leafletOutput("LeafletOut.byAll", width="100%", height="100%"),
                                                  
                                                  absolutePanel(id = "controls", fixed = TRUE,
                                                                draggable = TRUE, top = 100, left = "auto", right = 20, bottom = "auto",
                                                                width = 330, height = "auto", 
                                                                selectInput("KPI.In",            
                                                                            label = h5("Selection panel"),
                                                                            choices =  list("<Select your LOB>"= "void",
                                                                                            "New Business Rate (%)" = "NB.rate",
                                                                                            "Cancellation Rate(%)" = "canc.rate",
                                                                                            "NetInflow" = "netInflow"), 
                                                                            selected = "<Select your LOB>")
                                                  ))
                                  )
                                )
        )  
      )
)