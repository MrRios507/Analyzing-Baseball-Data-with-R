library(tidyverse)
library(abdwr3edata)

hof <- hof_batting

hof <- hof |>
  mutate(
    MidCareer = (From + To) / 2,
    Era = cut(
      MidCareer,
      breaks = c(1800, 1900, 1919, 1941, 1960, 1976, 1993, 2050),
      labels = c(
        "19th Century", "Dead Ball", "Lively Ball", "Integration", "Expansion", "Free Agency", "Long Ball"
      )
    )
  )

hof_eras <- hof |>
  group_by(Era) |>
  summarize(N = n())
hof_eras

ggplot(hof, aes(x = Era)) + 
  geom_bar() +
  xlab("Baseball Era") +
  ylab("Frequency") +
  ggtitle("Era of the Nonpitching Hall of Famers")

ggplot(hof_eras, aes(Era, N)) +
  geom_point(color = "red") +
  xlab("Baseball Era") + 
  ylab("Frequency") +
  ggtitle("Era of the Nonpitching Hall of Famers") +
  coord_flip()

## Saving Graphs
ggplot(hof, aes(Era)) +
  geom_bar() +
  labs(x = "Baseball Era",
       y = "Frequency", 
       title = "Era of the Nonpitching Hall of Famers")
ggsave("bargraph.png")

## Save a number of graphs in a single file.
library(patchwork)

p1 <- ggplot(hof, aes(Era)) + geom_bar()
p2 <- ggplot(hof_eras, aes(Era, N)) + geom_point()

p1 + p2
ggsave("graphs.pdf")

# Numeric Variable: One-Dimensional Scatterplot
ggplot(hof, aes(x = OPS, y = 1)) +
  geom_jitter(height = 0.2) +
  ylim(0, 2) +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  coord_fixed(ratio = 0.03)

# Numeric Variable: Histograms
ggplot(hof, aes(x = OPS)) +
  geom_histogram(
    breaks = seq(0.4, 1.2, by = 0.1),
    color = "white", fill = "orange"
  )
