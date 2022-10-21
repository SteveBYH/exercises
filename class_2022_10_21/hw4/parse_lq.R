library(tidyverse)

stopifnot(dir.exists("data/"))

d = tibble(
  files = dir("data/lq")
)

saveRDS(d, "data/lq.rds")
