library(shiny)
library(ggplot2)
library(rCharts)
library(markdown)
shinyUI(
  navbarPage("Explore GDP Growth of Countries",
    tabPanel("Run",
        sidebarPanel(
          sliderInput("input_years", "Select Years:", min = 1960, max = 2014,
                      value = c(2001, 2010)),
          selectInput("input_countries", "Select Countries:", "", 
                      multiple = TRUE, selectize = TRUE)
        ),
        mainPanel(
         plotOutput("gdpPlot")
        )
    ),
    tabPanel("Help",
        mainPanel(includeMarkdown("README.md"))
    )
  )
)
  