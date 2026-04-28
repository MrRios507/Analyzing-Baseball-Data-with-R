library(tidyverse)
library(abdwr3edata)
library(ggrepel)

hof <- hof_batting

hof <- hof |>
  mutate(
    MidCareer = (From + To) / 2,
    Era = cut(
      MidCareer,
      breaks = c(1800, 1900, 1919, 1941, 1960, 1976, 1993, 2050),
      labels = c(
        "19th Century", "Dead Ball", "Lively Ball", "Integration", "Expansion", "Free Agency", "Long Ball"
      )
    )
  )

# Scatterplot
ggplot(hof, aes(MidCareer, OPS)) +
  geom_point() +
  geom_smooth() +
  geom_text_repel(
    data = filter(hof, OPS > 1.05 | OPS < .5),
    aes(MidCareer, OPS, label = Player), color = "red"
  )