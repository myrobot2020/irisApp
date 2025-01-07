library(shiny)
library(tibble)
library(sodium)
library(shinyauthr)

# Sample user data
user_base <- tibble(
  user = c("user1", "user2"),
  password = sapply(c("pass1", "pass2"), sodium::password_store),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)



ui <- fluidPage(
  shinyauthr::logoutUI(id = "logout"),
  shinyauthr::loginUI(id = "login"),
  plotOutput("a"))

server <- function(input, output, session) {
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
  
  output$a <- renderPlot({
    req(credentials()$user_auth)
    plot(iris$Sepal.Length)
  })
}

shinyApp(ui = ui, server = server)
