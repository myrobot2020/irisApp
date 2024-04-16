library(shiny)
library(httr)

# UI
ui <- fluidPage(
  titlePanel("IRIS Predictor"),
  sidebarLayout(
    sidebarPanel(
      numericInput("sepal_width", "Sepal Width:", value = 3.9, min = 0, max = 10),
      selectInput("species", "Species:", choices = c("setosa", "versicolor", "virginica")),
      actionButton("predict_button", "Predict")
    ),
    mainPanel(
      textOutput("prediction_output")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$predict_button, {
    req(input$sepal_width, input$species)
    
    # Show progress bar
    withProgress(
      message = "Making prediction...",
      value = 0,
      {
        # Construct API URL
        url <- paste0("https://s1-653gqgoqqq-uc.a.run.app/predict?Sepal.Width=", input$sepal_width, "&Species=", input$species)
        
        # Make API request
        response <- GET(url)
        
        # Extract prediction from response
        prediction <- content(response, "text")
        
        # Display prediction
        output$prediction_output <- renderText({
          paste("Prediction of Sepal Length:", prediction)
        })
        
        # Complete progress bar
        incProgress(100, detail = "Prediction complete.")
      }
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
