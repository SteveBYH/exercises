library(tidyverse)

## Example 1 - MC Pi Estimate

draw_points = function(n) {
  list(
    x = runif(n, -1, 1),
    y = runif(n, -1, 1)
  )
}

in_unit_circle = function(d) {
  sqrt(d$x^2 + d$y^2) <= 1
}

## By hand
draw_points(1e5) %>%
  in_unit_circle() %>%
  { 4 * sum(.) / length(.) }

draw_points(1e6) %>%
  in_unit_circle() %>%
  { 4 * sum(.) / length(.) }

## By data frame

d = tibble(
  n = 10^(2:6)
) %>%
  mutate(
    draws = map(n, draw_points)
  )


d %>%
  mutate(
    in_unit_circle = map(draws, in_unit_circle),
    pi_est = map_dbl(in_unit_circle, ~ 4 * sum(.) / length(.)),
    abs_err = abs(pi_est - pi)
  )
  
## Example 2 - repurrrsive::discog

tibble(
  disc = repurrrsive::discog
) %>%
  mutate(
    id      = map_int(disc, "id"),
    year    = map_int(disc, c("basic_information", "year")),
    title   = map_chr(disc, c("basic_information", "title")),
    artist  = map_chr(disc, list("basic_information", "artists", 1, "name")),
    artist2 = map_chr(disc, list("basic_information", "artists", 2, "name"), .default = NA)
  )

tibble(
  disc = repurrrsive::discog
) %>%
  hoist(
    disc,
    id = "id",
    year = c("basic_information", "year"),
    title = c("basic_information", "title"),
    artist = list("basic_information", "artists", 1, "name"),
    .ptype = list(
      id = integer(),
      year = integer(),
      title = character(),
      artist = integer()
    )
  )
