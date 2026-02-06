# Who hit the most home run in the 1960s?
# The data frame Batting contains the season batting statistics for all players in baseball history
library(Lahman)
library(dplyr)

Batting_60 <- Batting |>
  filter(yearID >= 1960, yearID <= 1969)

# Compute the total number of home runs for each player in the data frame Batting_60
hr_60 <- Batting_60 |>
  group_by(playerID) |>
  summarise(HR = sum(HR))

# Sort the data frame hr_60 in descending order so that the best home run hitters are on the top
# The most prolific home run hitters in the 1960s were Harmon Killebrew, Hank Aaron, Willie Mays, and Frank Robinson.
hr_60 |>
  arrange(desc(HR)) |>
  slice(1:4)


# We could also perform this sequence of operations in a single pipeline.
Batting |>
  filter(yearID >= 1960, yearID <= 1969) |>
  group_by(playerID) |>
  summarise(HR = sum(HR)) |>
  arrange(desc(HR)) |>
  slice(1:4)
