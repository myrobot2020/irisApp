library(dplyr)

df<-iris

df %>% 
  filter(Species %in% c("setosa","virginica")) %>% 
  mutate(s.area=Sepal.Width*Sepal.Length,p.area=Petal.Length*Petal.Width) %>% 
  select(Species,s.area,p.area) %>% 
  group_by(Species) %>% 
  summarise(mean.s.area=mean(s.area),
            mean.p.area=mean(p.area)) %>% 
  arrange(desc(mean.s.area)) %>% 
  rename(spec="Species") %>%
  collect() %>% 
 print()
  
  
