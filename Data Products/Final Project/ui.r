library(ggplot2)
library(plotly)
library(shiny)

shinyUI(fluidPage(tabsetPanel(tabPanel("tab1", h1("Sample Size Estimator"),
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
                        p(em("plot comes from Brian Caffo's Statistical Inference lecture on Power"))))))
