library(tidyverse)
library(shiny)

# See the widget gallery - https://shiny.rstudio.com/gallery/widget-gallery.html

shinyApp(
  ui = fluidPage(
    title = "Beta-Binomial",
    titlePanel("Beta-Binomial Visualizer"),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        h4("Data:"),
        sliderInput("x", "# of heads", min=0, max=100, value=7),
        sliderInput("n", "# of flips", min=0, max=100, value=10),
        h4("Prior:"),
        numericInput("alpha", "Prior # of head", min=0, value=5),
        numericInput("beta", "Prior # of tails", min=0, value=5),
      ),
      mainPanel = mainPanel(
        plotOutput("plot")
      )
    )
  ),
  server = function(input, output, session) {
 
  }
)