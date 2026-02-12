library(ggplot2)

Player <- c("Rickey Henderson", "Lou Brock", "Ty Cobb", "Tim Raines", "Eddie Collins", "Max Carey", "Joe Morgan", "Ozzie Smith", "Barry Bonds", "Ichiro Suzuki", "Luis Aparicio", "Paul Molitor", "Roberto Alomar")
SB <- c(1406, 938, 896, 808, 741, 738, 689, 580, 514, 509, 506, 504, 474)
CS <- c(335, 307, 178, 146, 173, 92, 162, 148, 141, 117, 136, 131, 114)
G <- c(3081, 2616, 3035, 2502, 2826, 2476, 2649, 2573, 2986, 2653, 2601, 2683, 2379)

# Compute the number of stolen base attempts SB + CS and store in the vector SB.Attempt
SB.Attempt <- SB + CS

# Compute the success rate Success.Rate = SB / SB.Attempt
Success.Rate <- SB / SB.Attempt

# Compute the number of stolen bases per game SB.Game = SB / Game
SB.Game = SB / G


TopBaseStealers <- data.frame(
  Player,
  SB,
  CS,
  G,
  SB.Attempt,
  Success.Rate,
  SB.Game
)

# Construct a scatterplot of the stolen bases per game against the success rates.
ggplot(TopBaseStealers, aes(x = SB.Game, y = Success.Rate, label = Player)) +
  geom_point() +
  geom_text(vjust = -0.5, hjust = 0.5)

