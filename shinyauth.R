library(shiny)
library(tibble)
library(sodium)
library(shinyauthr)

# Sample user data
user_base <- tibble(
  user = c("1", "2"),
  password = sapply(c("1", "2"), sodium::password_store),
  permissions = c("admin", "standard"),
  name = c("User One", "User Two")
)



ui <- fluidPage(
  shinyauthr::logoutUI(id = "logout"),
  shinyauthr::loginUI(id = "login"),
  plotOutput("a"),
  tableOutput("b"),
  uiOutput("c")
  )

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
    if (credentials()$info$permissions=="admin") {
      plot(iris$Sepal.Length)
    }
    else if (credentials()$info$permissions=="standard") {
      plot(iris$Petal.Length)
      }
  })
  

  output$c<-renderUI({
    req(credentials()$user_auth)
    if (credentials()$info$permissions=="admin"){
      tabsetPanel(
        tabPanel("Tab 1"),
        tabPanel("Tab 2"),
        tabPanel("Tab 3"))
    }
    else if (credentials()$info$permissions=="standard") {
      tabsetPanel(
        tabPanel("Tab 1"),
        tabPanel("Tab 2")
      )
    }
  })
}

shinyApp(ui = ui, server = server)
