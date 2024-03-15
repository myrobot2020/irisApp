require(nnet)
df<-iris
df$s.area<-df$Sepal.Length*df$Sepal.Width
df$p.area<-df$Petal.Length*df$Petal.Width
df<-df[,5:7]
logistic_model <- glm(Species ~ s.area + p.area, data = df, family = "multinomial")
summary(logistic_model)