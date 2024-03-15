library(shiny)

irisUI <- function(id) {
  tagList(
    selectInput(NS(id,"a"),"a",choices = unique(iris$Species)),
    plotOutput(NS(id,"b"))
  )
}


irisServer <- function(id) {
  moduleServer(id,function(input,output,session) {
    r<-reactive({
      iris[iris$Species==input$a,"Sepal.Length"]
    })
    output$b<-renderPlot({
      hist(r())
    })
  })
}

irisApp<-function() {
  ui<-fluidPage(
    irisUI("iris1")
  )
  server<-function(input,output,session){
    irisServer("iris1")
  }
  shinyApp(ui,server)
}


irisApp()
