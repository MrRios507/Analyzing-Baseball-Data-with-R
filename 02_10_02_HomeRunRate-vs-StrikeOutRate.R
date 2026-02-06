library(Lahman)
library(dplyr)

# Is there an association between a player's home run rate and his strikeout rate?

# Create a data frame consisting of the career AB, HR, and SO for all batters in baseball history with at least 5000 AB.
long_careers <- Batting |>
  group_by(playerID) |>
  summarize(
    tAB = sum(AB, na.rm = TRUE),
    tHR = sum(HR, na.rm = TRUE),
    tSO = sum(SO, na.rm = TRUE)
  )

Batting_5000 <- long_careers |>
  filter(tAB >= 5000)

# Construct a scatterplot of HR/AB and SO/AB
ggplot(Batting_5000, aes(x = tHR / tAB, y = tSO / tAB)) +
  geom_point() + geom_smooth(color = "blue")


# Batters with higher run rates tend to have higher strikeout rates.