library(tidyverse)

## Example 1

grades = tibble::tribble(
  ~name,   ~hw_1, ~hw_2, ~hw_3, ~hw_4, ~proj_1, ~proj_2,
  "Alice",    19,    19,    18,    20,      89,      95,
  "Bob",      18,    20,    18,    16,      77,      88,
  "Carol",    18,    20,    18,    17,      96,      99,
  "Dave",     19,    19,    18,    19,      86,      82
)

grades %>%
  pivot_longer(
    cols = -name,
    names_to = "assignment",
    values_to = "score"
  ) %>%
  separate(
    col = assignment,
    into = c("type", "number"),
    sep = "_"
  ) %>%
  group_by(name, type) %>%
  summarize(
    avg_score = mean(score)
  ) %>%
  pivot_wider(
    id_cols = name,
    names_from = type,
    values_from = avg_score
  ) %>%
  mutate(
    overall = 0.5 * hw / 20 + 0.5 * proj / 100
  )

grades %>%
  mutate(
    hw_avg = (hw_1+hw_2+hw_3+hw_4)/4,
    proj_avg = (proj_1+proj_2)/2
  ) %>%
  mutate(
    overall = 0.5*(proj_avg/100) + 0.5*(hw_avg/20)
  )


## Exercise 1

palmerpenguins::penguins %>%
  count(island, species) %>%
  pivot_wider(id_cols=species, names_from=island, values_from = n, values_fill = 0)

palmerpenguins::penguins %>%
  count(island, species) %>%
  pivot_wider(
    id_cols=island, 
    names_from=species, 
    values_from = n,
    values_fill = 0
  )


## Exercise 2

repurrrsive::sw_planets

repurrrsive::sw_people


### Which planet appeared in the most starwars film 
### (according to the data in sw_planet)?

tibble(
  planet = repurrrsive::sw_planets
) %>%
  unnest_wider(planet) %>%
  select(name, url, films) %>%
  unnest_longer(films) %>%
  count(name) %>%
# arrange(desc(n)) %>%
# filter(n >= n[6])
  top_n(n = 1, wt = n)
  


### Which planet was the homeworld of the most characters 
### in the starwars films?

tibble(
  people = repurrrsive::sw_people
) %>%
  unnest_wider(people) %>%
  select(name, homeworld) %>%
  count(homeworld) %>%
  top_n(1, wt=n) %>%
  left_join(
    tibble(
      planet = repurrrsive::sw_planets
    ) %>%
      unnest_wider(planet) %>%
      select(name, url),
    by = c("homeworld" = "url")
  )




