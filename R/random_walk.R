library(circular)

# length of walk
  N<-1000

# make weibull distributed steps
  steps <- rweibull(N,2,1)
# check out their distribution
  hist(steps)

# make clustered turning angles
  theta <- rwrappedcauchy(N,mu=0,rho=.8)
# check out their distribution
  rose.diag(theta,bins=24)

# cumulative angle (absolute orientation)
  Phi <- cumsum(theta)

# step length components
  dX <- steps*cos(Phi)
  dY <- steps*sin(Phi)

# actual X-Y values
  X<-cumsum(dX)
  Y<-cumsum(dY)

# plot that puppy
  plot(X,Y,type="l")
