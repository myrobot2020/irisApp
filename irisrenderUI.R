library(shiny)

library(shiny)

ui <- fluidPage(
  selectInput("a","a",choices = unique(iris$Species)),
  uiOutput("b")
)

server <- function(input, output, session) {
  r<-reactive({
    iris[iris$Species==input$a,1]
  })
  output$b<-renderUI({
    sliderInput("c","c",min = min(r()),max = max(r()),value = mean(r()))
  })
  
}

shinyApp(ui, server)