
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
                    selected = levels(network)[1]),
        selectInput("LOB.In",                                      ##CHG: add LOB selection
                    label = h4("Select your Line of Business"),
                    choices = LOB, 
                    selected = levels(LOB)[1])
      )
    ),
    
    ## 3/ a body                                                  ##CHG: add update css
    dashboardBody(
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "mycss.css")),
      fluidRow(tableOutput("TableOut.byNetwork"),
               plotlyOutput("PlotOut.byNetwork"))                   ##CHG: add plotlyOutput
    )
  )


  
  
