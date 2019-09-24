# Linear Support Vector Machine(SVM)

# Create binary variable from 'lprice'.
# Normalize the lat and long co-ordinates data.
mydf$hiprice=ifelse (mydf$lprice <=5.03,1,2)
mydf$nlat<-(mydf$lat-min(mydf$lat))/(max(mydf$lat)-min(mydf$lat))
mydf$nlong<-(mydf$long-min(mydf$long))/(max(mydf$long)-min(mydf$long))
head(mydf)

x<-mydf[c(13,14)]
y<-mydf$hiprice

# Plot the normalized coordinates and hiprice data
plot(x,col=y,pch=19)
legend("topright",legend=c("lprice <= 5.03","hiprice>5.03"),
       pch=19,col=c("red","black"))

# load the package `e1071` which contains the `svm` function
library(e1071)
dat=data.frame(x,y=as.factor(y))
str(dat)

# Select Training & Test Data Sets Randomly for SVM Classification. 
# Training data set = 65% of 3774 = 2450. Test data set = 3774 - 2450 = 1324
set.seed (1023)
itrain=sample (1: nrow(mydf), 2450)
traindat =dat[c(itrain),]
testdat =dat[c(-itrain),]
str(traindat)
str(testdat)
svmfit=svm(y~.,data=traindat,kernel="linear",cost=0.01,scale=FALSE)
print(svmfit)
plot(svmfit,traindat)

# Code for a better PLOT:
make.grid=function(x,n=100){
  grange=apply(x,2,range)
  nlong=seq(from=grange[1,1],to=grange[2,1],length=n)
  nlat=seq(from=grange[1,2],to=grange[2,2],length=n)
  expand.grid(nlong=nlong,nlat=nlat)
}
xgrid=make.grid(x)
ygrid=predict(svmfit,xgrid)
plot(xgrid,col=c("red","blue")[as.numeric(ygrid)],pch=20,cex=.2)
points(x,col=y,pch=19)
points(x[svmfit$index,],pch=5,cex=2)

# Identifying observations that are Support Vectors
svmfit$index

# Basic information about the support vector classifier
summary (svmfit)

# What happens if a larger value of the cost parameter used?
svmfit=svm(y~.,data=dat,kernel="linear",cost=1,scale=FALSE)
plot(svmfit , dat)
svmfit$index
summary (svmfit )

# Tuning SVMs with a linear kernel, using a range of values of the cost parameter.
set.seed (101)
tune.out=tune(svm,y~.,data=dat ,kernel ="linear",
              ranges =list(cost=c(0.001 , 0.01, 0.1, 1,5,10,100)))
summary(tune.out)

# Best model parameters based on CV (automatically stored into tune function)
bestmod =tune.out$best.model
summary (bestmod)

# Predict the class label on a set of test observations
ypred = predict(bestmod,testdat)
table(predict =ypred,truth=testdat$y)