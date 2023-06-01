library(shiny)
library(waiter)

ui <- fluidPage(
  useWaitress(),
  actionButton("btn", "Render"),
  plotOutput("plot", width = 400)
)

server <- function(input, output){
  
  waitress <- Waitress$new("#plot", hide_on_render = TRUE) # call the waitress
  
  output$plot <- renderPlot({
    input$btn
    
    waitress$start(h3("Loading Stuff..."))
    
    for(i in 1:10){
      waitress$inc(10) # increase by 10%
      Sys.sleep(.3)
    }
    
    plot(runif(100))
  })
  
}

shinyApp(ui, server)