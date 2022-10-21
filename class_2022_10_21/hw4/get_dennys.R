# Get Dennys restaraunt pages

dir.create("data/dennys", recursive = TRUE, showWarnings = FALSE)

url = "http://www2.stat.duke.edu/~cr173/data/dennys/locations.dennys.com/index.html"
download.file(
  url = url,
  destfile = file.path("data/dennys", basename(url)),
  quiet = TRUE
)
