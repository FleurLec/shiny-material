##CHG: main change : add Leaflet + share reactive input outside of render functions

shinyServer(function(input, output) {
  
## RENDER ___________________________________________________________________________________________
  
  netw <- reactive(input$NetWork.In)     ##CHG: add reactive input ouside of render function
  lob <- reactive(input$LOB.In)          ##CHG: add reactive input ouside of render function
  kpi <- reactive(input$KPI.In)          ##CHG: add reactive input ouside of render function
  ## Render Variables selected
  selected.var <-  reactive(paste(lob(), netw(), kpi(), sep="_"))

   
  ## Render table
  output$TableOut.byNetwork <- renderTable({DFagg.LN[network == netw(), -"network"]}, align = "r")
  
  ## Render plot
  output$PlotOut.byNetwork <- renderPlotly({ p <- plotly.KPI(DFagg.LND, netw(), lob(), T)
                                             p$elementId <- NULL # to avoid a known warning cf ropensci/plotly/issues/985
                                             p
  })
  

  ##CHG:  Render Leaflet
  output$LeafletOut.byAll <- renderLeaflet({
                                pal <- colorBin("RdYlBu", domain = France@data[, selected.var()], 
                                                bins = quantile(France@data[, selected.var()], c(0, .25, .5, .75, 1)),
                                                na.color = "grey40", reverse = T)
                                    
                                l %>%  addLegend(pal = pal, 
                                                 values = round(France@data[, selected.var()], 1), 
                                                 opacity = 0.7, position = "bottomright", title = "") %>%
                                        addPolygons(data=France, weight = 1, 
                                                    fill = France@data[, selected.var()], 
                                                    fillColor = pal(France@data[, selected.var()]),
                                                    opacity=1, fillOpacity = 0.6, color=grey(0.5),
                                                    highlight = highlightOptions( weight = 1,
                                                                                  color = "white",
                                                                                  dashArray = "",
                                                                                  fillOpacity = 0.7,
                                                                                  bringToFront = TRUE),
                                                    label = ~as.character(
                                                      paste(DEPT_ID, DEPT, get(selected.var()), sep=" / "))
                                        )

  })
})

