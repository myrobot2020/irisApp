library(shiny)

ui <- fluidPage(
  selectInput("a", "a", choices = names(iris)),
  selectInput("b", "b", choices = unique(iris$Species)),
  plotOutput("c"),
  actionButton('d', "d")
)


m<-modalDialog(
  "Make plot?",
  title = "Are you sure you want to continue?",
  footer = tagList(
    actionButton("cancel", "Ok"),
    actionButton("Ok", "Ok", class = "btn btn-danger")
  )
)


server <- function(input, output, session) {
  r <- eventReactive(input$d, {
    withProgress(message = "Computing graph",{
    showNotification("all done")
    Sys.sleep(5)
    iris[iris$Species == input$b, input$a]})
  })
  
  observeEvent(input$d, {
    showModal(m)
  })
  
  output$c <- renderPlot({
    plot(r())
  })
  observeEvent(input$Ok, {
    removeModal()
  })
}

shinyApp(ui, server)
