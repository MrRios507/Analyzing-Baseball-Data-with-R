source("scripts/hr_rates.R")

HR <- c(13, 23, 21, 27, 37, 52, 34, 42, 31, 40, 54)
AB <- c(341, 549, 461, 543, 517, 533, 474, 519, 541, 527, 514)
Age <- 19 : 29

# hr_rates(Age, HR, AB)

plot(hr_rates(Age, HR, AB))