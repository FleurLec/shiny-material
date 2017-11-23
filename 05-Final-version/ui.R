##CHG: NO CHANGE

### Dashboard UI ######################################################


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
        #shinydashboard::tabItem("xx",                                                  
                                shiny::tabsetPanel(                                    
                                      shiny::tabPanel("Table",
                                                      fluidRow(##CHG: DT library for tables
                                                                br(),
                                                                dataTableOutput("TableOut.byNetwork"),
                                                                br(),
                                                                plotlyOutput("PlotOut.byNetwork"))
                                      ),
                                      shiny::tabPanel("GGplot",
                                                      ##CHG: possibility to adjust plots with shinyjqui::jqui_sortabled
                                                         jqui_sortabled(div(id = 'plots',
                                                                         plotOutput("PlotOut.byNetwork.NBC",  height = "300", width = "600"),             
                                                                         plotOutput("PlotOut.byNetwork.NI",  height = "300", width = "600")
                                                      ))
                                      ),
                                      shiny::tabPanel("Leaflet",
                                                          leafletOutput("LeafletOut.byAll", width="100%", height=600),
                                                          
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
                                                          )
                                      ),
                                    ##CHG: add my aggregated table to demonstrate formattable
                                    shiny::tabPanel("Table Agg",
                                                    fluidRow(br(),
                                                             formattableOutput("TableOut.allAgg")
                                                    )
                                    )
                                )
        #)  
      )
)