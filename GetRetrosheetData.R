library(purrr)
library(readr)

# Download the Retrosheet data
retro_data <- baseballr::retrosheet_data(
  here::here("data_large/retrosheet"),
  c(1992, 1996, 1998, 2016)
)

# To isolate the play-by-play data for a single year, use the pluck() function.
retro1998 <- retro_data |>
  pluck("1998") |>
  pluck("events")


# Saving data
retro1998 |>
  write_rds(
    file = here::here("data/retro1998.rds"),
    compress = "xz"
  )
