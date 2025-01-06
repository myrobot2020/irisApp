library(shiny)

mtcar<-data.frame(mtcars)
mtcar$model <- rownames(mtcar)
rownames(mtcar)<-NULL

ui <- fluidPage(
  selectInput("a","a",choices = mtcar$model),
  selectInput("b","b",choices = NULL),
  textOutput("c")
)

server <- function(input, output, session) {
  r<-reactive({
    mtcar[mtcar$model==input$a,"gear"]
    })

  observeEvent(input$a,{
    updateSelectInput(session,"b",choices = r())
  })
}

shinyApp(ui, server)
