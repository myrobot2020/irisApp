library(shiny)

ui <- fluidPage(
  selectInput("a","a",choices = names(iris)),
  selectInput("b","b",choices = unique(iris$Species)),
  plotOutput("c")
)

server <- function(input, output, session) {
  
  output$c<-renderPlot({
      
      validate(
        need(input$a=="Sepal.Width",label = "pick SL"),
        need(input$b=="virginica",label = "pick virginica")
      )
    
      plot(iris[iris$Species==input$b,input$a])
    })
  
}


shinyApp(ui, server)