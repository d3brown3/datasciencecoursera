library(ggplot2)
library(plotly)
library(shiny)

ui <- fluidPage(tabsetPanel(tabPanel("tab1", h1("Sample Size Estimator"),
                 numericInput(inputId = "delta", label = "delta:",value = 1),
                 numericInput(inputId = "noise", label = "sd:",value = 10),
                 numericInput(inputId = "power", label = "power:",value = .8),
                 verbatimTextOutput("ohyeah"),
                 hr(strong("Documentation")),
                 hr(p("- delta is the absolute difference in your actual mean and expected mean (e.g. normally expect 5 but with treatment we hypothesize 7)"),
                 p("- noise is the standard deviation of your mean (e.g. take sd of your observations during the timeframe)"),
                 p("- power is the probability of not getting a false negative (e.g. the likelihood of correctly measuring a lift)"),
                 p("- input these details about your experiment to retrieve the n that you need to meet your requirements"))),
tabPanel("tab2", mainPanel(sliderInput(inputId = "Noise", 
                 "Variance", value = 10, min = 10*.5, max = 10*1.5, step = 1), 
                 plotlyOutput(outputId = "something"), width = 12)),
tabPanel("tab3", sidebarPanel(
                 sliderInput(inputId = "sigma", "noise", value = 4, min = 1, max = 10),
                 sliderInput(inputId = "mua", "average", value = 32, min = 30, max = 35),
                 sliderInput(inputId = "n", "samplesize", value = 16, min = 1, max = 50),
                 sliderInput(inputId = "alpha", "significance", value = 0.05, min = 0.01, max = 0.2, step = .01)),
mainPanel(plotlyOutput(outputId = "yay")), 
                 p(em("plot comes from Brian Caffo's Statistical Inference lecture on Power")))))

server <- function(input, output){

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
}
shinyApp(ui = ui, server = server)