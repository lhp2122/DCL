## Import Mouse Data File (.json format)

install.packages("rjson")
library(rjson)
dat <- fromJSON(file = file.choose())

## Tidy Data as Tibble
library(tidyverse)
dat <- as_tibble(dat)


# all the data are spread out in different columns
# so we need to combine them into a single columns with xpos, ypos, and audiotime
# code is the name of the new column, value is the actual value
data <- gather(dat, "code", "value", 4:3543) 

# separate the name so that we can have the similar labels by the "." to combine xpos, ypos, and audiotime later
data2 <- separate(data, code, c("mouse", "order", "type"))

# now we create new columns for xpos, ypos, and audiotime into a table
dat2 <- data2 %>%
  pivot_wider(names_from = type, values_from = value)


## Analysis
datxtime <- ts(dat2$xpos)
plot.ts(datxtime, ylab = "Emotions (Negative-Positive)")

