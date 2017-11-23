

  # NB and Cancellation
plotly.nbcc <- function(df, ntw, lob, legend) {
  p.nbcc <- plot_ly(df[network == ntw & LOB == lob]) %>%
    add_lines(x = ~date, y = ~canc.rate*100, 
              name = '% Cancellation',  
              line = list(color = "red", dash = "dot"),
              showlegend = legend,
              hoverinfo = 'text', 
              text = ~paste('% Cancellation : ', round(canc.rate*100, 1), "% ", '<br> (', ntw, '-', lob, ')')) %>%
    add_lines(x = ~date, y = ~NB.rate*100, 
              name = '% NewBusiness',  
              line = list(color = "green"),
              showlegend = legend,
              hoverinfo = 'text', 
              text = ~paste('% New Business : ', round(NB.rate*100, 1), "% ", '<br> (', ntw, '-', lob, ')')) %>%
    layout(xaxis = list(title = ""),
           yaxis = list(ticksuffix = '%', 
                        tickfont = list(size = 8)))
  }

  # Net Inflow
  plotly.ni <- function(df, ntw, lob, legend) {
    p.ni <- plot_ly(df[network == ntw & LOB == lob],
                    x = ~date, y = ~netInflow, 
                    type = 'bar', 
                    name = "Net Inflow",
                    marker = list(color = cols[v==lob, colors] ) ,
                    showlegend = legend,
                    opacity = .6,
                    hoverinfo = 'text', 
                    text = ~paste('Net Inflow : ', comma(netInflow), '<br> (', ntw, '-', lob, ')')) %>%
      layout(xaxis = list(tickangle = -90,
                          side = "top",
                          title = "",
                          autotick = F, 
                          dtick = "M2",
                          tickfont = list(size = 8)),
             yaxis = list(tickfont = list(size = 8)))
    
  }
  
  ## paste plots together
  plotly.KPI <- function(df, ntw, lob, legend) {
    
    subplot(plotly.nbcc(df, ntw, lob, legend), 
            plotly.ni(df, ntw, lob, legend), 
            nrows = 2, shareX = TRUE, margin = .08) %>%
      layout( title = paste("Net Inflow, New Business & Cancellation rates  : <b>", ntw, "-", lob, "</b>"),
              margin = list(t=70, b=70),
              legend = list( x = 1.05,                        # avoid overlap of legend and y-axis
                             y = 0.5, yanchor = "center") )   # valign
    
  }
  
  
