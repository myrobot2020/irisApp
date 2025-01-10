library(shiny)

ui <- fluidPage(
  selectInput("a","a",choices = names(iris),selected = NULL,multiple = T),
  textInput("b","b"),
  plotOutput("c")
)

server <- function(input, output, session) {
  r<-reactive({
    validate(
      need(input$a==names(iris),label = "pick dim"),
      need(input$b==unique(iris$Species),label = "pick spec")
    )
    iris[iris$Species==input$b,input$a]
  })
  
  output$c<-renderPlot({
    plot(r())
  })
  
}


shinyApp(ui, server)
