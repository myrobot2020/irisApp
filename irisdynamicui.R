library(shiny)

library(shiny)

ui <- fluidPage(
  selectInput("a","a",choices = unique(iris$Species)),
  selectInput("b","b",choices = NULL),
  textOutput("c")
)

server <- function(input, output, session) {
  r<-reactive({
    filter(iris,Species == input$a)
  })
  
  observeEvent(r(),{
    freezeReactiveValue(input,"b")
    updateSelectInput(session,"b",choices = unique(r()$Sepal.Length))
  })
  
  output$c<-renderText({
    range(r()$Sepal.Length)
  })
  
  
}

shinyApp(ui, server)