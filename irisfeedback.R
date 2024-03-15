library(shiny)
library(shinyFeedback)

ui <- fluidPage(
  useShinyFeedback(),
  textInput("a","a")
)

server <- function(input, output, session) {
  observe({
    if (!(input$a %in% unique(iris$Species))) {
      showFeedbackWarning(
        inputId = "a",
        text = "incorrect species"
      )  
    } else {hideFeedback("a")}
    
  })
}

shinyApp(ui, server)