library(dplyr)
library(purrr)
library(Lahman)
library(lubridate)
library(stringr)
library(ggplot2)

# Getting the data
retro1998 <- read_rds(here::here("data/retro1998.rds"))

# Get player ids
sosa_id <- People |>
  filter(nameFirst == "Sammy", nameLast == "Sosa") |>
  pull(retroID)

mac_id <- People |>
  filter(nameFirst == "Mark", nameLast == "McGwire") |>
  pull(retroID)

# Extract McGwire's and Sosa's plate appearance data
hr_race <- retro1998 |>
  filter(bat_id %in% c(sosa_id, mac_id))


# Extracting the variables
cum_hr <- function(data) {
  data |>
    mutate(Date = ymd(str_sub(game_id, 4, 11))) |>
    arrange(Date) |>
    mutate(
      HR = if_else(event_cd == 23, 1, 0),
      cumHR = cumsum(HR)
    ) |>
    select(Date, cumHR)
}


hr_grouped <- hr_race |>
  group_by(bat_id)

keys <- hr_grouped |>
  group_keys() |>
  pull(bat_id)

hr_ytd <- hr_grouped |>
  group_split() |>
  map(cum_hr) |>
  set_names(keys) |>
  bind_rows(.id = "bat_id") |>
  inner_join(People, by = c("bat_id" = "retroID"))


# Constructing the graph
ggplot(hr_ytd, aes(Date, cumHR, color = nameLast)) +
  geom_line() +
  geom_hline(yintercept = 62, color = "blue") +
  annotate(
    "text", ymd("1998-04-15") , 65,
    label = "62", color = "blue"
  ) +
  ylab("Home Runs in the Season")
