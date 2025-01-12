library(shiny)

ui <- fluidPage(
  fileInput("a","a"),
  tableOutput("b"),
  downloadButton("c")
)
server <- function(input, output, session) {
  df<-reactive({
    read.csv(input$a$datapath)
  })
  output$b<-renderTable({
    df()
  })
  output$c <- downloadHandler(paste0(input$a, ".csv"),
    content = function(file) {
      write.csv(df(), file)
    }
  ) 
}
shinyApp(ui, server)
