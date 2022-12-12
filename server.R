library(ggplot2)
library(plotly)
library(dplyr)

climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  
  output$climate_plot <- renderPlotly({
    co2_data <- climate_df %>% 
      filter(country %in% input$country_selection) %>% 
      group_by(country, year)
    
    slider_df <- climate_df %>% 
      filter(country %in% input$country_selection) %>% 
      filter(year <= input$year_selection[2], year >= input$year_selection[1] )
    
    co2_data_plot <- ggplot(data = slider_df) + 
      geom_line(aes(x = year, 
                    y = co2, 
                    color = country)) +
    labs(title = "CO2 produced per Year",
         x = "Year",
         y = "CO2 measured in million tonnes") 
    
    
    
    plot <- ggplotly(co2_data_plot)
    
    return(plot)
  })
  
      
  
}
