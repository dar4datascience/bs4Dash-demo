ui <- fluidPage(
  plotOutput("plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    withProgress(message = 'Calculation in progress', value = 0, {
                   for (i in 1:15) {
                     if(i < 10) {
                       incProgress(1/15, detail = 'This may take a while...')
                       Sys.sleep(0.25)
                     }else{
                     incProgress(1/15,
                                 message = 'Getting there',
                                 detail = "")
                     Sys.sleep(0.25)
                     }
                   }
                 })
    plot(cars)
  })
}

shinyApp(ui, server)