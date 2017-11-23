##CHG: library(DT) for nice interactive table

shinyServer(function(input, output) {
  traceback()
## RENDER ___________________________________________________________________________________________
  
  netw <- reactive(input$NetWork.In)     
  lob <- reactive(input$LOB.In)          
  kpi <- reactive(input$KPI.In)  

  ## Render Variables selected
  selected.var <-  reactive(paste(lob(), netw(), kpi(), sep="_"))
 
  observeEvent(selected.var(), {print(selected.var())})
  observeEvent(kpi(), {print(paste("is null KPI : ", is.null(kpi())))})
  
  ########################
  ## Render table       ##
  ########################
  output$TableOut.byNetwork <- renderDataTable({DFagg.LN[network == netw(), -"network"]})

  ##CHG: add new table to show formattable
  ########################
  ## Render all table   ##
  ########################
  output$TableOut.allAgg <- renderFormattable({ formattable(DFagg.LN %>% mutate(ok = ifelse(netInflow<=0, FALSE, TRUE),
                                                                                NB.rate = NB.rate*100,
                                                                                canc.rate = canc.rate*100), 
                                                            list(
                                                              area(col =portfolio) ~ normalize_bar("lightgrey", 0.2),
                                                              NB.rate   = color_tile("lightpink", "palegreen") ,
                                                              canc.rate = color_tile("palegreen", "lightpink") ,
                                                              ok = formatter("span",
                                                                             style = x ~ style(color = ifelse(x, "green", "red")),
                                                                             x ~ icontext(ifelse(x, "ok", "remove"), 
                                                                                          ifelse(x, "Net Inflow <0", "NetInflow >0")))
                                                            ))  
                            })
    ?normalize_bar
  ########################
  ## Render plotly      ##
  ########################
  output$PlotOut.byNetwork <- renderPlotly({ p <- plotly.KPI(DFagg.LND, netw(), lob(), T)
                                             p$elementId <- NULL # to avoid a known warning cf ropensci/plotly/issues/985
                                             p
  })
  ########################
  ## Render GGplot      ##
  ########################
  output$PlotOut.byNetwork.NBC <- renderPlot({ p1 <- plot.NB.canc(DFagg.LND[network == netw()],
                                                                  "date", "NB.rate", "canc.rate", "LOB")
                                               p1
  })
  
  output$PlotOut.byNetwork.NI <- renderPlot({ plot.NetInflow(DFagg.LND[network == netw()],
                                                             "date", "netInflow", "LOB")
  })

  ########################
  ## Render Leaflet     ##
  ########################  
  output$LeafletOut.byAll <- renderLeaflet({l})

  ## Observe selection change
  observe({
    if (kpi() != "void" ) {
        ## pal depends on selected var
        pal <- colorBin("RdYlBu", domain = France@data[, selected.var()], 
                        bins = quantile(France@data[, selected.var()], c(0, .25, .5, .75, 1)),
                        na.color = "grey40", reverse = T)
        
        ## layer containing KPIs
        ##CHG: Manage separately percent and integers
        if (kpi() == "netInflow") {
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
        }     
        else {
                                  leafletProxy("LeafletOut.byAll", data = France) %>%
                                    clearShapes() %>%
                                    clearControls() %>%
                                    addLegend(pal = pal, values = round(France@data[, selected.var()], 1), 
                                              opacity = 0.7, position = "bottomright", title = "",
                                              ##CHG: labFormat : 
                                              labFormat = labelFormat(suffix = '%', transform = function(x) {round(100 * x, 2)})) %>%
                                    addPolygons(data=France, weight = 1, 
                                                fill = France@data[, selected.var()], 
                                                fillColor = pal(France@data[, selected.var()]),
                                                opacity=1, fillOpacity = 0.6, color=grey(0.5),
                                                label = ~as.character(paste(DEPT_ID, DEPT, 
                                                                            ##CHG: add percent
                                                                            scales::percent(round(get(selected.var()), 1)), sep=" / ")),
                                                highlight = highlightOptions( weight = 1,
                                                                              color = "white",
                                                                              dashArray = "",
                                                                              fillOpacity = 0.7,
                                                                              bringToFront = TRUE)
                                    )
                                    
      
          }
    }        
      
  })

  
  
})

