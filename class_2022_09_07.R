## Exercise 1

x = 1
y = 2


f = function(x, y) {
  
  if ( x %% 2 == 1 & y %% 2 == 0) { # stop() execution if x is odd and y is even and report 
    stop("x is odd and y is even")  # an error, don’t print any of the text strings above.
  } else if ( x > 3 & y <=3 ) {   # If x is greater than 3 and y is less than or equal to 3 
    print("Hello world!")         # then print “Hello world!”
  } else if ( x > 3 ) {
    print("!dlrow olleh")  # Otherwise if x is greater than 3 print “!dlrow olleH”
  } else if (x <= 3 ) {    # If x is less than or equal to 3 then print  “Something else …”
    print("Something else ...")
  } 
}

f(1, 2)
f(2, 1)
f(4, 1)
f(4, 4)


## Exercise 2

z = 1

f = function(x, y, z) {         # x=3, y=1, z=2
  z = x+y                       # x=3, y=1, z=4
  
  g = function(m = x, n = y) {  # m=3, n=1, z=4
    m/z + n/z                   # 3/4 + 1/4 = 1 
  }
  
  z * g()                       # z=4, g()=1
}

f(1, 2, x = 3)                  # 4
z





