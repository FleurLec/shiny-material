##CHG: use LeafletProxy to avoid reaload.  

shinyServer(function(input, output) {
  
## RENDER ___________________________________________________________________________________________
  
  netw <- reactive(input$NetWork.In)     
  lob <- reactive(input$LOB.In)          
  kpi <- reactive(input$KPI.In)          
  ## Render Variables selected
  selected.var <-  reactive(paste(lob(), netw(), kpi(), sep="_"))

  
  ## Render table
  output$TableOut.byNetwork <- renderTable({DFagg.LN[network == netw(), -"network"]}, align = "r")
  
  ## Render plot
  output$PlotOut.byNetwork <- renderPlotly({ p <- plotly.KPI(DFagg.LND, netw(), lob(), T)
                                             p$elementId <- NULL # to avoid a known warning cf ropensci/plotly/issues/985
                                             p
                              })
  

  ##CHG: Render Leaflet :  map background is plotted without reactive features is plotted once
  output$LeafletOut.byAll <- renderLeaflet({l})

  ##CHG: Observe reactive value changing map rendering and add the layer dynamically
  observe({
    ## pal depends on selected var
    pal <- colorBin("RdYlBu", domain = France@data[, selected.var()], 
                    bins = quantile(France@data[, selected.var()], c(0, .25, .5, .75, 1)),
                    na.color = "grey40", reverse = T)

    ## layer containing KPIs
      ##CHG: specify leaflet map in leafletProxy(mapId=)
      ##CHG: clearShapes to delete previous shapes
      ##CHG: clearControls to delete previous controls
    
    leafletProxy("LeafletOut.byAll", data = France) %>%
      clearShapes() %>%
      clearControls() %>%
      addLegend(pal = pal, values = round(France@data[, selected.var()], 1), 
                     opacity = 0.7, position = "bottomright", title = "") %>%
      addPolygons(data=France, weight = 1, 
                  fill = France@data[, selected.var()], 
                  fillColor = pal(France@data[, selected.var()]),
                  opacity=1, fillOpacity = 0.6, color=grey(0.5),
                  label = ~as.character(paste(DEPT_ID, DEPT, 
                                              get(selected.var()), sep=" / ")),
                  highlight = highlightOptions( weight = 1,
                                                color = "white",
                                                dashArray = "",
                                                fillOpacity = 0.7,
                                                bringToFront = TRUE)
                  
      )
  })
  
})

