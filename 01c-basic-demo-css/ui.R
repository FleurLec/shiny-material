##CHG: Add CSS

shinyUI(fluidPage(theme = "mycss.css",                 ##CHG: add css files
  ## 1/ a header
  shiny::titlePanel("My Application Title"),
  hr(),                                                ##CHG: add horizontal line  
  
  ## 2/ a Sidebar
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      selectInput("NetWork.In", 
                  label = h4("Options"),
                  choices = list("Agent" = "Agt",
                                 "Direct" = "Dir",
                                 "Brokers" = "Brk"), 
                  selected = "Agent")
    ),
    ## 3/ a body                  
    shiny::mainPanel(
      shiny::tabsetPanel(type = "tabs", 
                         tabPanel("My first tab", 
                                  br(),                ##CHG: add break line
                                  tableOutput("NetWork.Out"))
      )
    )
  )
))
