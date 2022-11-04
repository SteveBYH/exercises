library(tidyverse)
library(shiny)

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
    observe({
      updateSliderInput(session, "x", max = input$n)
    }) %>%
      bindEvent(input$n)
    
    output$plot = renderPlot({      
      d = tibble(
        p = seq(0, 1, length.out = 1000)
      ) %>%
        mutate(
          prior = dbeta(p, input$alpha, input$beta),
          likelihood = dbinom(input$x, size = input$n, prob = p) %>% 
            {. / (sum(.) / n())},
          posterior = dbeta(p, input$alpha + input$x, input$beta + input$n - input$x)
        ) %>%
        pivot_longer(
          cols = -p,
          names_to = "distribution",
          values_to = "density"
        ) %>%
        mutate(
          distribution = forcats::as_factor(distribution)
        )
      
      ggplot(d, aes(x=p, y=density, color=distribution)) +
        geom_line(size=1.5) +
        geom_ribbon(aes(ymax=density, fill=distribution), ymin=0, alpha=0.5)
    })
  }
)
