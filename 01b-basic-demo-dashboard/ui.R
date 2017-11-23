##CHG: selectInput and tableOutput are wrapped in new functions.
##CHG : Please note in #comment the possibility to load css as well



shinydashboard::dashboardPage(                                        ##CHG: instead of shinyUI(fluidPage(
  ## 1/ a header
  shinydashboard::dashboardHeader(title = "My App. Title"),           ##CHG: instead of titlePanel(),
        
  ## 2/ a Sidebar
  shinydashboard::dashboardSidebar(                                   ##CHG: instead of sidebarPanel()
    shinydashboard::sidebarMenu(                                      ##CHG: instead of sidebarPanel()
                                 selectInput("NetWork.In", 
                                                     label = h4("Options"),
                                                     choices = list("Agent" = "Agt",
                                                                    "Direct" = "Dir",
                                                                    "Brokers" = "Brk"), 
                                                     selected = "Agent")
    )
  ),
  
  ## 3/ a body
  shinydashboard::dashboardBody(                                       ##CHG: instead of mainPanel
                                fluidRow(tableOutput("NetWork.Out"))
    )
)

