library(ggplot2)
library(shiny)
library(reshape2)

ui <- fluidPage(
  numericInput(inputId = "n",
               "Sample size", value = 25),
  plotOutput(outputId = "density")
)
server <- function(input, output) {
  
  output$density <- renderPlot({
    
    pop <- rnorm(1000, mean = 3000, sd = 1500) ##store daily sales assumptions
    mns1 <- NULL
    mns2 <- NULL
    for (i in 1:1000) mns1 = c(mns1, mean(sample(pop, input$n, replace = TRUE)))
    for (i in 1:1000) mns2 = c(mns2, mean(sample(pop, input$n*2, replace = TRUE)))
    df <- melt(data = data.frame(mns1 = mns1, mns2 = mns2), measure.vars = c("mns1", "mns2"))
    
    ggplot() + geom_density(data = df, aes(value, color = variable), size = 2) + 
      geom_vline(aes(xintercept = 3000))})
}
shinyApp(ui = ui, server = server)