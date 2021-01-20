library(shiny)
source("src/metric_correlations.R")
library(shinydashboard)

ui = tabsetPanel(
  
  tabPanel("Performance Metric Interplay",fluidPage(
  
      
      sidebarLayout(
        sidebarPanel(
          helpText("Explore the interation between two performance metrics for a chosen virtual machine(s)"),
          
          selectInput("serial",
                      label = "Choose the host machine",
                      choices = unique(all_data$gpuSerial),
                      selected = unique(all_data$gpuSerial)[1]),
          
          selectInput("var1",
                      label = "Choose the first variable",
                      choices = c("tempC",
                                  "powerDraw",
                                  "GpuUtilPerc",
                                  "MemUtilPerc",
                                  "runtime"),
                      selected = "tempC"),
          
          selectInput("var2",
                      label = "Choose the second variable",
                      choices = c("tempC",
                                  "powerDraw",
                                  "GpuUtilPerc",
                                  "MemUtilPerc",
                                  "runtime"),
                      selected = "runtime")
          
        ), 
        
        
        
        
        mainPanel(
          infoBoxOutput("corr"),
          
          plotOutput("metric_variation")
         
        )
      
      
      ) 
      
)), 

  tabPanel("Tile Variation",fluidPage(
  
  
  sidebarLayout(
    sidebarPanel(
      helpText("Visualise the variation a each performance metric over the image tiles"),
      
      selectInput("metric",
                  label = "Select a performance metric",
                  choices = c("tempC",
                              "powerDraw",
                              "GpuUtilPerc",
                              "MemUtilPerc",
                              "runtime"),
                  selected = "tempC"),
      
      helpText("Final terapixel image for comparison:"),
      
      img(src = "full_terapixel_image.png", height = 210, width = 210),
    ),
    
    mainPanel(
      plotOutput("tile_variation")
    )
    
    
  ) 
))

)
  

server = function(input,output) {
  
  output$metric_variation = renderPlot({
    ggplot(filter(all_data,gpuSerial == input$serial), aes_string(x = input$var1, y = input$var2)) + 
      geom_point() + geom_text(aes(label = task_no), vjust = 1.2)
  })
  
  output$tile_variation = renderPlot({ 
    
    mid = mean(unlist(all_data[,input$metric]))
    
    ggplot(filter(all_data,level == 12), aes_string(x = "x", y = "y", colour = input$metric)) + 
      geom_point() +
      scale_color_gradient2(midpoint=mid, low="green", mid="white",
                              high="red", space = "Lab",guide = "colourbar")
    })

  output$corr = renderInfoBox({
    infoBox("Correlation Coefficient",
            round(cor(unlist(all_data[all_data$gpuSerial == input$serial,input$var1]),
                                          unlist(all_data[all_data$gpuSerial == input$serial,input$var2])),2),
            color = "blue",fill = TRUE)
  })

}

shinyApp(ui = ui, server = server)