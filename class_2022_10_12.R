library(tidyverse)
library(rvest)

## polite

polite::bow("https://www.rottentomatoes.com/")

## Rotten tomatoes example

page = read_html("https://www.rottentomatoes.com/")

get_audience_score = function(url) {
  url %>%
    read_html() %>%
    html_elements(".scoreboard") %>%
    html_attr("audiencescore") %>%
    as.numeric()
}

tibble(
  title = page %>% 
    html_elements(".ordered-layout__list--score:nth-child(1) .clamp-1") %>%
    html_text(),
  score = page %>%
    html_elements(".ordered-layout__list--score:nth-child(1) .dynamic-text-list__tomatometer-group") %>%
    html_text2() %>%
    str_remove("%$") %>%
    as.numeric() %>%
    {./100},
  badge = page %>%
    html_elements(".ordered-layout__list--score:nth-child(1) .icon--tiny") %>%
    html_attr("class") %>%
    str_match("icon__(certified_fresh|rotten|fresh)") %>%
    {.[,2]} %>%
    str_replace("_", " ") %>%
    str_to_title(),
  url = page %>%
    html_elements(".ordered-layout__list--score:nth-child(1) .dynamic-text-list__tomatometer-group") %>%
    html_attr("href") %>%
    paste0("https://www.rottentomatoes.com", .)
) %>%
  mutate(
    aud_score = purrr::map_dbl(
      url, get_audience_score
    )
  )





 
