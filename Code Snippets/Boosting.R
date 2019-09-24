# Boosting
library (gbm)
set.seed (1231)
boost.regTree =gbm(lprice~.,data=regTree [train ,], 
                   distribution='gaussian', n.trees =5000, 
                   interaction.depth =7)
summary (boost.regTree )

# Partial Dependence Plots
par(mfrow =c(1,3))
plot(boost.regTree ,i="rmType")
plot(boost.regTree ,i="revPerMonth")
plot(boost.regTree ,i="neighbPIN")
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =5000)

# MSE
mean(( yhat.boost -regTree.test)^2)

# Use shrinkage factor of 0.01 rather than default 0.001.  
# Increase n tree to 10000.
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=10000,shrinkage=0.01,interaction.depth=7)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =10000)
mean(( yhat.boost -regTree.test)^2)

# Based on the relative influence plot and the relative influence 
# statistics output, one can see that rmType, revPerMonth, and neighbPIN
# are by far the most important variables.

# The partial dependence plots for these three variables illustrate the marginal 
# effect of the selected variables on the response after integrating out the other variables. 
# These plots show that the median room price decreases rmType from Entire home/apt to other
# categories and number of revPerMonth while no definite pattern with respect to neighbPIN.

# The test MSE obtained is 0.292; little inferior to the test MSE for random forests and superior to that for bagging.

# Prediction on the test set. With boosting, the number of trees is a tuning parameter,
# computing the test error as a function of the number of trees, and make a plot.
n.trees=seq(from=100,to=10000,by=100)
predmat=predict(boost.regTree,newdata=regTree[-train,],n.trees=n.trees)
dim(predmat)
berr=with(regTree[-train,],apply( (predmat-lprice)^2,2,mean))
plot(n.trees,berr,pch=19,ylab="Mean Squared Error", 
     xlab="# Trees",main="Boosting Test Error")
abline(h=min(test.err),col="red")


# Using n.trees=2000 and interaction.depth=7:
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=7)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)

# So far we have used the interaction.depth = 7 i.e., we are using 7 splits that may not be appropriate. 
# In order to improve the boost model, one needs to find the optimal value of the interaction.depth parameter using cross-validation.
# Use n.trees=2000 and varying interaction.depth
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=6)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=5)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=4)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)