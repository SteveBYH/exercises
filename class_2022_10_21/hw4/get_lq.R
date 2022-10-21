# Get LQ hotel pages

dir.create("data/lq", recursive = TRUE, showWarnings = FALSE)

url = "http://www2.stat.duke.edu/~cr173/data/lq/www.wyndhamhotels.com/laquinta/locations.html"
download.file(
  url = url,
  destfile = file.path("data/lq", basename(url)),
  quiet = TRUE
)
