library(shiny)
library(waiter)

ui <- fluidPage(
  plotOutput("b"),
  actionButton("c","c"),
  selectInput("a","a",choices = unique(iris$Species),selected = "setosa"),
  use_waiter()
)

server <- function(input, output, session) {
  w<-Waiter$new(id = "b")
  r<-reactive({
    iris[iris$Species==input$a,"Sepal.Length"]
  })
  
  observeEvent(input$c,{
    output$b<-renderPlot({
    w$show()
    Sys.sleep(2)
    plot(r())
  })
  })
}

shinyApp(ui, server)
