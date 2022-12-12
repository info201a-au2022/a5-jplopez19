library(plotly)
library(bslib)

# Load climate data
climate_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Home page tab
intro_tab <- tabPanel(
  "Introduction",
  sidebarLayout(
    sidebarPanel(
      p("My project explores the trend of carbon dioxide production based emissions, which is measured in million tonnes from countries around the world from as early as 1750 to 2020.")
    ),
    mainPanel(
      h2("Information about the Dataset"),
      p("Climate Change is one of the biggest issues facing the world today. The temperature of the world is increasing, but it is increasing rapidly because of man-made causes. As we have more greenhouse gas emissions, such as carbon dioxide, being produced, it traps the sun’s heat and leads to climate change. The dataset that we are using will help us identify which countries contribute and produce the most amount of CO2 gas and we can also compare different countries, and see if we can identify a pattern or trend. The dataset that we are using is from the Global Carbon Project and the Climate Data Explorer, which are one of the many main sources of data. The dataset that I am using was collected and aggregated by Hannah Ritchie, Max Roser, Edouard Mathieu, Bobbie Macdonald, and Pablo Rosado. Some of the possible limitations with this data is that there are some data values that are not included in the dataset, and as always, we should consider that it is not always perfect and that there may be human errors or biases in the dataset."),
      h2("Summary Information"), 
      p("I was able to use my DPLYR skills to be able to find a number of answers to questions I was curious about when I was looking at the dataset. I found that the country with that produced the highest co2 in 2020 was China, emitting 10667.887 million tonnes, while the country that emitted the lowest was Tuvalu. The country with the highest co2 production per capita was Qatar and the country that had the highest oil co2 produced per capita was the Democratic Republic of Congo."),
      h2("Conclusions from my Data Viz"),
      p("My chart displays the amount of CO2 that is produced for any country or countries that the user selects. Although every country as produces a different amount of CO2, I was able to see a clear trend with the production of CO2 is that it is trending upwards and we are producing more and more CO2 into the air every year. There is a little bit of decline in the recent years, probably because climate change is becoming more apparent in the world and we are trying to bring change.")
    )
  )
)

# We want our next tab to have a sidebar layout
# So we're going to create a sidebarPanel() and a mainPanel() and then add them together

# Create sidebar panel for widget
sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "country_selection",
    label = "Country",
    choices = climate_df$country,
    multiple = TRUE 
  ),
  sliderInput(
    inputId = "year_selection", 
    label = h3("Slider"),
    min = min(climate_df$year),
    max = max(climate_df$year), 
    sep = "",
    value = c(1950,2020))
)

# Put a plot in the middle of the page
main_panel_plot <- mainPanel(
  #  plotOutput(outputId = "climate_plot")
  # Make plot interactive
  plotlyOutput(outputId = "climate_plot")
)
chart_description <- mainPanel(
  h2("Purpose and Trends"),
  p("The purpose of this chart is to see the trend of the production of CO2 over the years in different countries around the world. The biggest trend one can notice in the chart is that the production of CO2 is increasing throughout the years, which is pretty alarming.")
)

# Plot Tab  — combine sidebar panel and main panel
climate_tab <- tabPanel(
  "Climate Visualization",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
  chart_description
)

ui <- navbarPage(
  # Home page title
  theme = bs_theme(version = 5, bootswatch = "minty"),
  "Climate Change",
  intro_tab,
  climate_tab
)
