list(
  f = "y~x",
  d = data.frame(x=1:3, y=1:3)
) %>%
  (function(l) {
      lm(as.formula(l$f), data=l$d)
  })
