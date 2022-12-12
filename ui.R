library(plotly)
library(bslib)

# Load climate data
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv", stringsAsFactors = FALSE)

# Home page tab
intro_tab <- tabPanel(
  "Introduction Page",
  sidebarLayout(
    sidebarPanel(
      p("The following is an exploration of Carbon Dioxide emission trends throughout wolrd beginning in 1750 to 2020.")
    ),
    mainPanel(
      h2("Climate Change"),
      p("Climate change has become one of the most pressing issues of the 21st century. As the issue
      continues creating implications on the world, we must persist in finding solutions. To do so, we must
      understand how climate change works, what are the causes, and who are the main contributors."),
      h2("Summary Information"), 
      p("To better understand climate change, I used DPLYR to ask and answer questions pertaining to
      what countries contribute the most and least to CO2 emissions. First, I found that China was the country
      with the highest C02 emissions in 2020, estimating to 10667.887 million tonnes emitted. Secondly, I found
      that the country with the lowest C02 emissions in 2020 was Tuvalu. For a more precise understanding of CO2
      emissions, I sought out to find emissions per capita. In 2020, Quatar had the highest C02 production per
      capita. Finally, the country with the highest oil CO2 production per capita was the Democratic Republic
      of Congo."),
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
  h2("Chart Description"),
  p("The line graph above demonsrates CO2 emission trends by individual country 
    from the years 1750 to 2020. One of the main trends observed shows an overall
    increase in the  C02 production througout the world. Since the data was first
    collected C02 emissions trends in nearly all countries has increased.")
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
  theme = bs_theme(version = 5, bootswatch = "superhero"),
  "A5: Climate Change",
  intro_tab,
  climate_tab
)
