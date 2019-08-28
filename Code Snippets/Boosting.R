
####__Boosting__
```{r}
library (gbm)
set.seed (1231)
boost.regTree =gbm(lprice~.,data=regTree [train ,], 
                   distribution='gaussian', n.trees =5000, 
                   interaction.depth =7)
summary (boost.regTree )
```
######__Partial Dependence Plots__
```{r}
par(mfrow =c(1,3))
plot(boost.regTree ,i="rmType")
plot(boost.regTree ,i="revPerMonth")
plot(boost.regTree ,i="neighbPIN")
```

```{r}
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =5000)
```

######__MSE:__
```{r}
mean(( yhat.boost -regTree.test)^2)
```
######__Using shrinkage factor of 0.01 rather default 0.001 and increasing n.tree to 10000__
```{r}
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=10000,shrinkage=0.01,interaction.depth=7)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =10000)
mean(( yhat.boost -regTree.test)^2)
```

Based on the relative influence plot and the relative influence statistics output, one can see that rmType, revPerMonth, and neighbPIN are by far the most important variables.

The partial dependence plots for these three variables illustrate the marginal effect of the selected variables on the response after integrating out the other variables. These plots show that the median room price decreases rmType from Entire home/apt to other categories and number of revPerMonth while no definite pattern with respect to neighbPIN.

The test MSE obtained is 0.292; little inferior to the test MSE for random forests and superior to that for bagging.







######__Prediction on the test set. With boosting, the number of trees is a tuning parameter, computing the test error as a function of the number of trees, and make a plot.__
```{r}
n.trees=seq(from=100,to=10000,by=100)
predmat=predict(boost.regTree,newdata=regTree[-train,],n.trees=n.trees)
dim(predmat)
berr=with(regTree[-train,],apply( (predmat-lprice)^2,2,mean))
plot(n.trees,berr,pch=19,ylab="Mean Squared Error", 
     xlab="# Trees",main="Boosting Test Error")
abline(h=min(test.err),col="red")
```

###### __Using n.trees=2000 and interaction.depth=7:__
So far we have used the interaction.depth = 7 i.e., we are using 7 splits that may not be appropriate. In order to improve the boost model, one needs to find the optimal value of the interaction.depth parameter using cross-validation.
```{r}
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=7)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
```

######__Using n.tree to 2000 and varying interaction.depth__
```{r}
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=6)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
#
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=5)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
#
boost.regTree=gbm(lprice~.,data=regTree[train,],distribution="gaussian",
                  n.trees=2000,shrinkage=0.01,interaction.depth=4)
yhat.boost=predict (boost.regTree ,newdata =regTree [-train ,],
                    n.trees =2000)
mean(( yhat.boost -regTree.test)^2)
```