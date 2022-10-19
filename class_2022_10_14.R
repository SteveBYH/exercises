library(tidyverse)

## GoT - Books

jsonlite::read_json("https://www.anapioficeandfire.com/api/books") %>%
 length()

jsonlite::read_json("https://www.anapioficeandfire.com/api/books?page=2") %>%
  length()

jsonlite::read_json("https://www.anapioficeandfire.com/api/books?pageSize=50") %>%
  length()


## GoT - Houses

jsonlite::read_json("https://www.anapioficeandfire.com/api/houses?pageSize=50") %>%
  length()

jsonlite::read_json("https://www.anapioficeandfire.com/api/houses?pageSize=500") %>%
  length()


page = 1
res = list()
repeat {
  has_died_out = TRUE
  url = stringr::str_glue(
    "https://www.anapioficeandfire.com/api/houses?page={page}&pageSize=50&hasDiedOut={has_died_out}" 
  )
  cat("Getting page", page, "\n")
  
  cur_res = jsonlite::read_json(url)
  
  res = c(res, cur_res)
  
  if (length(cur_res) != 50)
    break
  
  page = page + 1
}

tibble(res = res) %>%
  unnest_wider(res) %>%
  View()


# httr2

library(httr2)

  
resp = request("https://www.anapioficeandfire.com/api/houses") %>%
  req_url_query(
    page = 1,
    pageSize = 50
  ) %>%
  #req_dry_run()
  req_perform()

resp %>%
  resp_status()


last_response() %>%
  resp_body_json() %>%
  tibble(res = .) %>%
  unnest_wider(res)

last_response() %>%
  resp_header("link")


## aaoif function

aaoif = function(
  resource = c("root", "books", "characters", "houses"),
  base_url = "https://www.anapioficeandfire.com/api/"
) {
  resource = match.arg(resource)
  
  if (resource == "root") resource = ""
  
  url = paste0(base_url, resource)
  
  resp = request(url) %>%
    req_url_query(
      page = 1,
      pageSize = 50
    ) %>%
    req_perform()
  
  stopifnot(resp_status(last_response()) == 200)
  
  res = resp %>% resp_body_json()  
  
  n_pages = resp %>% 
    resp_header("link") %>%
    str_match(
      "page=(\\d+)&pageSize=50>; rel=\"last\"$"
    ) %>%
    { .[,2] } %>%
    as.numeric()
  
  if (n_pages > 1) {
    for (i in 2:n_pages) {
      resp = request(url) %>%
        req_url_query(
          page = i,
          pageSize = 50
        ) %>%
        req_perform()
      
      res = c(res, resp %>% resp_body_json())
    }
    
    cat("Downloaded page ", i, " / ", n_pages, "\n")
  }
  
  res %>%
    tibble(res = .) %>%
    unnest_wider(res)
}

aaoif("houses") 
aaoif("characters") 


