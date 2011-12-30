## Computational Statistics -- R tutorial
## Author: William Kong
## Date: 26 Feb 2010
## getting started
z <- c(8,13,21)
2*z 

## computing with vectors
fib <- c(1,1,2,3,5,z) # vector with first 8 Fibonacci numbers
fib
2*fib + 1 # element-wise operations
fib*fib # element-wise multiplication
log(fib) # takes the log of each element
s <- 2*(1:3) # vector holding 2, 4, 6
s1 <- seq(2,6,by=2) # same vector as s
fib[3] # 3rd element of vector fib
fib[4:7] # 4th, 5th, 6th and 7th element of fib
fib[s] # 2nd, 4th and 6th element of fib
fib[c(3,5)] # elements 3 and 5 of fib
fib[-c(3,5)] # vector fib without elements 3 and 5
x <- c(1,-3,5,-1,8,9,-2,1) # new vector x
x > 0 # elements 1, 3, 5, 6 and 8 of x are > 0
fib[x > 0] # elements 1, 3, 5, 6 and 8 of fib
rm(list = ls(all=TRUE)) #Remove all objects