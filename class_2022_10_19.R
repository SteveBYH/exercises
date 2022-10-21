basename("/home/c/cr173")
basename("/home/c/cr173/.bash_profile")

dirname("/home/c/cr173")
dirname("/home/c/cr173/.bash_profile")

dir.create("tmp/")
dir.create("tmp/", showWarnings = FALSE)
unlink("tmp/")

dir.create("tmp/tmp2/tmp3", recursive = TRUE)


## LQ



## Dennys

jsonlist::read_json(
  paste0(
    "https://nomnom-prod-api.dennys.com/restaurants/near?",
    "lat=35.780398&long=-78.639099",
    "&radius=15&limit=20",
    "&nomnom=calendars&nomnom_calendars_from=20221018&nomnom_calendars_to=20221026&nomnom_exclude_extref=999"
  )
)
