library(shiny)
library(waiter)

ui <- fluidPage(
  useWaiter(),
  useHostess(),
  # include dependencies
  actionButton("btn", "render"),
  fluidRow(column(6, plotOutput("plot1")),
           column(6, plotOutput("plot2")))
)

server <- function(input, output) {
  # n = 2 loaders
  host <- Hostess$new(n = 2)
  w <- Waiter$new(
    c("plot1", "plot2"),
    html = host$get_loader(
      preset = 'bubble',
      progress_type = 'fill',
      fill_direction = "ttb",
      svg = 'Matrix-1s-1084px.svg'
    )
  )
  
  dataset <- reactive({
    input$btn
    
    w$show()
    
    for (i in 1:10) {
      Sys.sleep(.3)
      host$set(i * 10)
    }
    
    runif(100)
  })
  
  output$plot1 <- renderPlot(plot(dataset()))
  output$plot2 <- renderPlot(plot(dataset()))
}

shinyApp(ui, server)