library(Lahman)
library(tidyverse)

# Data frame ws containing data from all of the World Series with fewer than 8 games played.
# The data frame SeriesPost in the Lahman package contains information about all MLB playoff games.
ws <- SeriesPost |>
  filter(yearID >= 1903, round == "WS", wins + losses < 8)

ggplot(ws, aes(x = wins + losses)) +
  geom_bar(fill = "blue") +
  labs(x = "Number of games", y = "Frequency")