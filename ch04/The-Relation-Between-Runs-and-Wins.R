library(Lahman)

# Look at the final lines of Teams dataset
Teams |>
  slice_tail(n = 3)


# The description of every column is provided in the help files
help(Teams)


# The proportion of wins with the runs scored and runs allowed for all of the teams.
# - G: the number of games played
# - W: the number of team wins
# - L: the number of losses
# - R: the total number of runs scored
# - RA: the total number of runs allowed

my_teams <- Teams |>
  filter(yearID > 2000) |>
  select(teamID, yearID, lgID, G, W, L, R, RA)

my_teams |>
  slice_tail(n = 6)

# The run differential is defined as the difference between the runs scored and the runs allowed by a team.
# RD = R - RA

# The winning proportion is the fraction of games won by a team. In baseball winning percentage is commonly used instead.
# Wpct = W / (W + L)

my_teams <- my_teams |>
  mutate(RD = R - RA, Wpct = W / (W + L))

# A first scatterplot of the run differential and the winning percentage
run_diff <- ggplot(my_teams, aes(x = RD, y = Wpct)) +
  geom_point() +
  scale_x_continuous("Run differential") +
  scale_y_continuous("Winning percentage")


# Linear Regression
linfit <- lm(Wpct ~ RD, data = my_teams)
linfit


run_diff +
  geom_smooth(method = "lm", se = FALSE, color = "blue")

# Calculate the predicted values from the model, as well as the residuals, 
# which measure the difference between the response values and the fitted values
library(broom)
my_teams_aug <- augment(linfit, data = my_teams)

# Display a plot of the residuals against the run differential.
# We use the ggrepel package to label a few teams with the largest residuals
base_plot <- ggplot(my_teams_aug, aes(x = RD, y = .resid)) +
  geom_point(alpha = 0.3) +
  geom_hline(yintercept = 0, linetype = 3) +
  xlab("Run differential") +
  ylab("Residual")

highlight_teams <- my_teams_aug |>
  arrange(desc(abs(.resid))) |>
  slice_head(n = 4)

library(ggrepel)
base_plot +
  geom_point(data = highlight_teams, color = "blue") +
  geom_text_repel(
    data = highlight_teams, color = "blue", aes(label = paste(teamID, yearID))
  )

# The root mean square error
resid_summary <- my_teams_aug |>
  summarize(
    N = n(),
    avg = mean(.resid),
    RMSE = sqrt(mean(.resid^2))
  )
resid_summary

rmse <- resid_summary |>
  pull(RMSE)

# If the errors are normally distributed, approximately two thirds of the residuals
# fall between -RMSE and +RMSE
my_teams_aug |>
  summarize(
    N = n(),
    within_one = sum(abs(.resid) < rmse),
    within_two = sum(abs(.resid) < 2 * rmse)
  ) |>
  mutate(
    within_one_pct = within_one / N,
    within_two_pct = within_two / N
  )
