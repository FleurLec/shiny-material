
shinyServer(function(input, output) {
  
  ## RENDER ___________________________________________________________________________________________
  ## When input data are called outside of a reactive function, they should be embedded in reactive()
  ## in our case, network is called once even if we switch from  table to chart
  ## netw will be updated when input box will change
  
  netw <- reactive(input$NetWork.In)      ##CHG: 2 PLOTS => we should factorize input call using reactive()
  
  ## Render table
  output$TableOut.byNetwork <- renderTable({DFagg.LN[network == netw(), -"network"]}, align = "r")
  
  ##CHG: Render plot with plotly
  output$PlotOut.byNetwork <- renderPlotly({ p <- plotly.KPI(DFagg.LND, netw(), input$LOB.In, T)
                                             
  })
  
  
})


