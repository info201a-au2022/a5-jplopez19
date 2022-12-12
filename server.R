library(ggplot2)
library(plotly)
library(dplyr)

data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)
View(data)

server <- function(input, output) {
  
  output$climate_plot <- renderPlotly({
    co2_data <- data %>% 
      filter(country %in% input$country_selection) %>% 
      group_by(country, year)
    
    slider_df <- data %>% 
      filter(country %in% input$country_selection) %>% 
      filter(year <= input$year_selection[2], year >= input$year_selection[1] )
    
    co2_data_plot <- ggplot(data = slider_df) + 
      geom_line(aes(x = year, 
                    y = co2, 
                    color = country)) +
    labs(title = "Total yearly CO2 production by Country",
         x = "Year",
         y = "CO2 emissions measured in million tonnes") 
    
    
    
    plot <- ggplotly(co2_data_plot)
    
    return(plot)
  })
  
      
  
}
