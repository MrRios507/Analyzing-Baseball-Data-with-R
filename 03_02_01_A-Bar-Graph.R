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
    )
  )

hof_eras <- hof |>
  group_by(Era) |>
  summarize(N = n())
hof_eras

ggplot(hof, aes(x = Era)) + geom_bar()