## Exercise 1

### Part 1

typeof( c(1, NA+1L, "C") ) # character

typeof( c(1L / 0, NA) ) # double

typeof( c(1:3, 5) ) # double

typeof( c(3L, NaN+1L) ) # double

typeof( c(NA, TRUE) ) # logical

### Part 2

# character > complex > double > integer > logical


## Exercise 2

f = function(x) {
  # Check small prime
  #if (any(x > 10 | x < -10)) {
  if (x > 10 || x < -10) {
    stop("Input too big")
  } else if (x %in% c(2, 3, 5, 7)) {
    cat("Input is prime!\n")
  } else if (as.numeric(x) %% 2 == 0) {
    cat("Input is even!\n")
  } else if (x %% 2 == 1) {
    cat("Input is odd!\n")
  }
}

f(1)      # Odd
f(3)      # Prime
f(8)      # Even
f(-1)     # Odd
f(-3)     # Odd
f(1:2)    # Odd + Warning
f(c(1,11))# Odd + Warning
f(c(11,1))# Too big
f("0")    # Error
f("3")    # Error
f("zero") # Error

