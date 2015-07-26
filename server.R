library(shiny)
require(reshape2)
#
data <- read.csv("./data/ny.gdp.mktp.cd_Indicator_en_csv_v2.csv", skip=4, header=TRUE, check.names = FALSE);
colnames(data)[1]="Country"

shinyServer(
  function(input, output, session){
    
    #reactive input processing
    plot_data <- reactive({
      
      columns <- c("Country", input$input_years[1]:input$input_years[2]);
      input_countries <- input$input_countries;
      
      plot_data <-data[data$Country %in% input_countries,columns]
      #reshape columns for plotting
      plot_data <- melt(plot_data)
      colnames(plot_data) = c("Country","Year","GDP");
      #convert to billion
      plot_data[3] = plot_data[3]/100000000
      plot_data
    })
    ## output ggplot
    output$gdpPlot <- renderPlot({
      print(ggplot(plot_data(), aes(x=Year, y=GDP, color=Country)) +
        geom_line(aes(group=Country))+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))+
        ylab("GDP in billion $") + 
        ggtitle("GDP Growth"))
    });
    #bind option values of countries selectio box to the session
    observe({
      updateSelectInput(session, "input_countries", 
                        choices = as.character(data[[1]]),
                        selected = as.character(data[[1,1]]))
    });
    
  }
  )
  