library(tidyverse)
library(abdwr3edata)

hof <- hof_batting

# Use the geom_plot() function to construct a scatterplot of OBP and SLG
(p <- ggplot(hof, aes(OBP, SLG)) + geom_point())

# Use the xlab() and ylab() functions to replace OBP and SLG
# OBP: On-Base Percentage
# SLG: Slugging Percentage
(p <- p +
    xlab("On Base Percentage") +
    ylab("Slugging Percentage"))

# Draw constant values of OPS using geom_abline() function
(p <- p +
    geom_abline(
      slope = -1,
      intercept = seq(0.7, 1, by = 0.1),
      color = "red"
    ))

# Add labels to the lines showing the constant values of OPS using annotate() function
p +
  annotate(
    "text", angle = -13,
    x = rep(0.31, 4),
    y = seq(0.4, 0.7, by = 0.1) + 0.02,
    label = paste("OPS = ", seq(0.7, 1, by = 0.1)),
    color = "red"
  )


# Rather that input these labels manually, we could create a data frame
# with the coordinates and labels
ops_labels <- tibble(
  OBP = rep(0.3, 4),
  SLG = seq(0.4, 0.7, by = 0.1) + 0.02,
  label = paste("OPS = ", OBP + SLG),
  angle = -13
)

# Use the geom_text() function to add the labels to the plot
p +
  geom_text(
    data = ops_labels,
    hjust = "left",
    aes(label = label, angle = angle),
    color = "red"
  )
