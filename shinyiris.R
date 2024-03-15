library(shiny)
library(waiter)

ui <- fluidPage(
  textInput("t","t"),
  selectInput("a","a",choices = unique(iris$Species),selected = "setosa"),
  plotOutput("b",click = "plot_click"),
  use_waiter()
)

server <- function(input, output, session) {
  w<-Waiter$new(id = "b")
  #thematic::thematic_shiny()
  #timer <- reactiveTimer(50000)
  r<-reactive({
    #timer()
    iris[iris$Species==input$a,"Sepal.Length"]
  })
  
  datas <- reactive({
    req(input$t)
    
    exists <- exists(input$t, "setosa")
    shinyFeedback::feedbackDanger("t", !exists, "Unknown spec")
    req(exists, cancelOutput = TRUE)
    
    get(input$t, "setosa")
  })
  
  
  
  output$b<-renderPlot({
    w$show()
    Sys.sleep(2)
    plot(r())
  })
}

shinyApp(ui, server)