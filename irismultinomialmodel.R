library(nnet)
df <- iris
df$s.area <- df$Sepal.Length * df$Sepal.Width
df$p.area <- df$Petal.Length * df$Petal.Width
df <- df[, 5:7]

# Fit multinomial logistic regression using the multinom function
logistic_model <- multinom(Species ~ s.area + p.area, data = df)

# View the model summary
summary(logistic_model)


new_data <- data.frame(
  s.area = 5.1 * 3.5,  # Sepal.Length * Sepal.Width
  p.area = 1.4 * 0.2   # Petal.Length * Petal.Width
)

# Make predictions using the fitted model
predicted_species <- predict(logistic_model, new_data, type = "class")
predicted_species
