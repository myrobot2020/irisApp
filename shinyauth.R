library(shiny)
library(tibble)
library(sodium)
library(shinyauthr)

# Sample user data
user_base <- tibble(
  user = c("user1", "user2"),
  password = sapply(c("pass1", "pass2"), password_store),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)



ui <- fluidPage(
  
  titlePanel("Old Faithful Geyser Data"),
  div(class = "pull-right", 
      shinyauthr::logoutUI(id = "logout")),
  shinyauthr::loginUI(id = "login"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output, session) {
  
  # Define login credentials
  credentials <- shinyauthr::loginServer(
    id = "login",
    data = user_base,
    user_col = "user",
    pwd_col = "password",
    sodium_hashed = TRUE,
    log_out = reactive(logout_init())
  )
  
  # Logout to hide
  logout_init <- shinyauthr::logoutServer(
    id = "logout",
    active = reactive(credentials()$user_auth)
  )
  
  output$distPlot <- renderPlot({
    req(credentials()$user_auth)
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
    })
  }

shinyApp(ui = ui, server = server)
