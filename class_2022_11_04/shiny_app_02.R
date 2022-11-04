library(tidyverse)
library(shiny)

shinyApp(
  ui = fluidPage(
    title = "Beta-Binomial",
    titlePanel("Beta-Binomial Visualizer"),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        "Widgets go here"
      ),
      mainPanel = mainPanel(
        "Outputs go here"
      )
    )
  ),
  server = function(input, output, session) {
    
  }
)