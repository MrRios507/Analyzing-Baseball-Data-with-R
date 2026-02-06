# Identify the player who hit the most home runs in each decade across baseball history.
source("scripts/hr_leader.R")

# Split the Batting data frame into pieces based on the decade.
Batting_decade <- Batting |>
  mutate(decade = 10 * floor(yearID / 10)) |>
  group_by(decade)

# We use the group_keys() function to retrieve a vector of the first year in each decade
decades <- Batting_decade |>
  group_keys() |>
  pull("decade")
decades


Batting_decade |>
  group_split() |>
  map(hr_leader) |>
  set_names(decades) |>
  bind_rows(.id = "decade")