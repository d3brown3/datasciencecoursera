library(ggplot2)
library(plotly)
library(shiny)

shinyServer(function(input, output){
  
  output$something <- renderPlotly({
    
    rn <- seq(from = input$delta*.5, to = input$delta*1.5, length.out = 1000)
    d <- data.frame(rn, 
                    "0.95"=unlist(lapply(rn, function(data) power.t.test(d=data, sd = input$Noise, power=0.95)$n)),
                    "0.9"=unlist(lapply(rn, function(data) power.t.test(d=data, sd = input$Noise, power=0.9)$n)),
                    "0.8"=unlist(lapply(rn, function(data) power.t.test(d=data, sd = input$Noise, power=0.8)$n)))
    
    ggplotly(ggplot() + 
               geom_line(data = d, aes(x=rn,y=X0.8), col = "blue")+
               geom_line(data = d, aes(x=rn,y=X0.9), col = "red")+
               geom_line(data = d, aes(x=rn,y=X0.95), col = "green")+
               ylab("n") + xlab("delta") + ggtitle("Sample Size")+
               scale_y_continuous(limits = c(0,100000)))})
  
  output$yay <- renderPlotly({
    mu0 <- 30
    g = ggplot(data.frame(mu = c(25, 40)), aes(x = mu))
    g = g + stat_function(fun=dnorm, geom = "line", 
                          args = list(mean = mu0, sd = input$sigma / sqrt(input$n)), size = 1, col = "red")
    g = g + stat_function(fun=dnorm, geom = "line", 
                          args = list(mean = input$mua, sd = input$sigma / sqrt(input$n)), size = 1, col = "blue")
    xitc = mu0 + qnorm(1 - round(input$alpha,digits = 2)) * input$sigma / sqrt(input$n)
    g = g + geom_vline(xintercept=xitc, size = 2)
    
    ggplotly(g)
    
    
  })
  
  output$ohyeah <- renderPrint({paste("Your sample size is:", 
                                      round(power.t.test(delta = input$delta, sd = input$noise, power = input$power, type = "one.sample")$n))})
})