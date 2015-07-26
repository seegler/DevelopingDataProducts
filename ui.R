library(shiny)
library(ggplot2)
library(rCharts)

shinyUI(pageWithSidebar(
  headerPanel("Explore GDP Growth of Countries"),
  sidebarPanel(
    sliderInput("input_years", "Select Years:", min = 1960, max = 2014,
                value = c(2001, 2010)),
    selectInput("input_countries", "Select Countries:", "", 
                multiple = TRUE, selectize = TRUE)
  ),
  mainPanel(
   plotOutput("gdpPlot")
  )
))
  