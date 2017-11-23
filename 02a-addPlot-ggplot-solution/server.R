##CHG: Render Plot function

shinyServer(function(input, output) {

## RENDER ___________________________________________________________________________________________
## in the next example, we'll se how to take advantage of reactive values outside of render-slot
  
  ## Render table
  output$TableOut.byNetwork <- renderTable({DFagg.LN[network == input$NetWork.In, -"network"]}, align = "r")
  
  ##CHG: Render plot
  output$PlotOut.byNetwork <- renderPlot({ ggarrange(plot.NB.canc(DFagg.LND[network == input$NetWork.In],
                                                        "date", "NB.rate", "canc.rate", "LOB"),
                                                     plot.NetInflow(DFagg.LND[network == input$NetWork.In],
                                                                    "date", "netInflow", "LOB"),
                                                     align = "v", nrow = 2)
                                          })
  
  
})


