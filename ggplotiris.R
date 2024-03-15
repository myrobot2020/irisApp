library(ggplot2)

df <- iris

# Set colors for each species
species_colors <- c("setosa" = "lightgreen", "versicolor" = "green", "virginica" = "darkgreen")

ggplot(df, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(alpha=0.7,size=5) +
  facet_wrap(~Species)+
  geom_smooth(method = "lm", se = TRUE, color = "black", fill = "lightblue") +
  scale_color_manual(values = species_colors) +  # Specify colors manually
  labs(
    title = "Iris Plots",
    subtitle = "ggdemo",
    caption = "iristexts",
    tag = "P1",
    x = "S.Length",
    y = "S.Width"
  )+
  theme_grey()+
  theme(plot.background = element_rect(fill = "#D2B48C"))
  
