library(plumber)

m<-lm(formula = Sepal.Length ~ Sepal.Width + Species, data = iris)

#* @param Sepal.Width
#* @param Species
#* @get /predict


p <- function(Sepal.Width, Species) {
  Sepal.Width<-as.numeric(Sepal.Width)
  new_data <- data.frame(Sepal.Width = Sepal.Width, Species = Species)
  predicted_length <- predict(m, newdata = new_data)
  return(predicted_length)
}

modellist<-vector(mode = "list")
modellist$modelbject <- m
modellist$NewPrediction <- p





