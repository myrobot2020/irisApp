library(shiny)
library(waiter)

ui <- fluidPage(
  selectInput("species", "Species", choices = unique(iris$Species), selected = "setosa"),
  tableOutput("b")
)

server <- function(input, output, session) {
  rv <- reactiveValues(data = NULL)
  
  observe({
    rv$data <- iris[iris$Species == input$species, ]
  })
  
  
  output$b <- renderTable({
    head(rv$data)
  })
}

shinyApp(ui, server)
