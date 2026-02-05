#' Calculate the home run rate of a baseball player
#'
#' This function compute the player's home run rates (as a percentage, roundend to the nearest tenth).
#' 
#' @param age A vector of player ages
#' @param hr A vector of home run counts
#' @param ab A vector of at-bats
#' @export
hr_rates <- function(age, hr, ab) {
  rates <- round(100 * hr / ab, 1)
  list(x = age, y = rates)
}