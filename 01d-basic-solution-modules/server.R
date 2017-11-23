##CHG: NO CHANGE

shinyServer(function(input, output) {

  ## Render table
  output$TableOut.byNetwork <- renderTable({
    
    DFagg.LN[network == input$NetWork.In, -"network"]
    
    }, align = "r")

})




