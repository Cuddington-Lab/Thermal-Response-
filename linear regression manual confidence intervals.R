#making manual confidence intervals

#lots of code from
#https://rstudio-pubs-static.s3.amazonaws.com/195401_20b3272a8bb04615ae7ee4c81d18ffb5.html


#you need:

#your x data
#your y data
#number of observations
#the x data you are trying to fit confidence intervals to
  #could be the range of x to plot the CIs
  #in my case, it was rasters of temperature data
#you also need a slope and intercept
  #either from doing a regression or from past analysis

#example
random.x<-rnorm(30)
random.y<-rnorm(30)

plot(random.x,random.y)
reg<-lm(random.y~random.x)


x<-random.x
y<-random.y
intercept<-reg$coef[1]
slope<-reg$coef[2]
#get number of observations (n)
n<-length(x)

#for this example, the x data I want to fit will just be the x axis
pred.x<-seq(min(x),max(x),0.1)

#these will be our predicted y
pred.y<-intercept+slope*pred.x


#we need the fitted values of y based on our x and y (our line of best fit)
y.fitted<-intercept+slope*x
plot(x,y)
points(x,y.fitted,type="l") #double check this looks right

# Find SSE and MSE
sse <- sum((y - y.fitted)^2)
mse <- sse / (n - 2)

#get our critical value of t
t.value<-qt(0.975, n - 2) 

#this gives the standard error of the mean estimate
mean.se.fit <- (1 / n + (pred.x - mean(x))^2 / (sum((x - mean(x))^2)))


mean.conf.upper <- pred.y + t.value * sqrt(mse * mean.se.fit)
mean.conf.lower <- pred.y - t.value * sqrt(mse * mean.se.fit)


plot(x,y)
points(pred.x,mean.conf.upper,type="l",col="blue")
points(pred.x,mean.conf.lower,type="l",col="blue")
points(x,y.fitted,type="l")

