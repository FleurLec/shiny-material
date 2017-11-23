##CHG: Create 2 functions to plot NB, cancellation rate and NetInflow



## generic theme  :
  myTheme <-  function(x) { theme(axis.text.x = element_text(angle = 90),                  
                                  axis.title.x = element_blank(),
                                  axis.title.y = element_blank(),
                                  legend.position = "top")
  }
  

## function to draw plots

  plot.NB.canc <- function(DF, x.date, y.nb, y.canc, grp) {
    ggplot(DF) + 
      geom_line(aes_string(x=x.date, y=y.nb, color = shQuote("vert"))) +
      geom_line(aes_string(x=x.date, y=y.canc, color = shQuote("rouge"))) +
      # LOB
      facet_wrap(grp, dir="h") +
      # axis
      scale_y_continuous(labels = scales::percent ) +
      scale_x_date(date_labels = "%b %y", date_breaks = "3 months") +
      # legend    
      scale_color_manual(name="KPI's", 
                         values= c(vert = "#00FF00", rouge = "#FF0000"),
                         label = c(vert = "New Business", rouge = "Cancellation"),
                         position = "bottom") +
      myTheme() +
      ggtitle("Evolution of New Business/Cancellation rate per Line of Business")
  }     
  

## function to plot New Business / Cancellation Rate typical line plot

  plot.NetInflow <- function(DF, x.date, y.netinflow, grp) {
    ggplot(DF) + 
      geom_bar(aes_string(x.date, y.netinflow), fill = "khaki", color = "grey80",
               stat = "identity", position = "dodge") +
      # LOB
      facet_wrap(grp, dir="h") +
      # axis
      scale_y_continuous(labels = scales::comma ) +
      scale_x_date(date_labels = "%b %y", date_breaks = "3 months") +
      # legend    
      myTheme()  
  }
