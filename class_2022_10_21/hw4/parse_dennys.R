library(tidyverse)

stopifnot(dir.exists("data/"))

d = tibble(
  files = dir("data/dennys")
)

saveRDS(d, "data/dennys.rds")
