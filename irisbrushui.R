library(shiny)

library(shiny)

ui <- fluidPage(
  plotOutput("a",brush = "brush"),
  tableOutput("c")
)

server <- function(input, output, session) {
  output$a<-renderPlot({
    plot(iris$Sepal.Length,iris$Petal.Length)
  })
  

  output$c<-renderTable({
    brushedPoints(iris,input$brush,xvar = "Sepal.Length",yvar = "Petal.Length")
  })
  
}
  
shinyApp(ui, server)
