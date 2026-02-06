#' Identify the home run leader in a dataset
#'
#' This function takes a data frame of batting statistics and returns
#' a single row corresponding to the player with the highest total
#' number of home runs in the dataset.
#'
#' @param data A data frame containing at least `playerID` and `HR` columns
#' @return A data frame with one row: the player who hit the most home runs
#' @export
hr_leader <- function(data) {
  data |>
    group_by(playerID) |>
    summarise(HR = sum(HR)) |>
    arrange(desc(HR)) |>
    slice(1)
}