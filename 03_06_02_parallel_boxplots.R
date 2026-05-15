# The home run rate defined by HR/AB for our Hall of Fame players
library(tidyverse)
library(abdwr3edata)

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
    ),
    hr_rate = HR / AB
  )

# An alternative display for comparing distributions uses the geom_boxplo()
ggplot(hof, aes(Era, hr_rate)) +
  geom_boxplot(color = "brown", fill = "orange") +
  coord_flip()