###__Trees__



####__Classification Tree__
```{r}
tree.fit =tree(highPrice~.-lprice ,mydf )
summary (tree.fit )
plot(tree.fit )
text(tree.fit ,pretty =0)
tree.fit
set.seed (1023)
train=sample (1: nrow(x ), 2450)
mydf.test=mydf [-train ,]
#str(mydf.test)
highPrice.test=highPrice[-train ]
#str(highPrice.test)
```

###### __Fitting the tree model using training data: __
```{r}
tree.fit =tree(highPrice~.-lprice ,mydf ,subset =train )
```

###### __Prediction using the fitted model and test data: __
```{r}
tree.pred=predict (tree.fit ,mydf.test ,type ="class")
table(tree.pred ,highPrice.test)
```
######__Results:__

* Cross Validation:
![](addplot2.png)

* Number of terminal nodes: 7

* Residual mean deviance: 0.9099 = 3428 / 3767

* Misclassification error rate: 0.2101 = 793 / 3774

* The Training Error rate is about 21%

* The residual deviance rate is about 91% indicating that the tree model does not give a good fit. 


#####__Pruning of Classification Tree__
```{r}
set.seed (3199)
prune.mydf =prune.misclass (tree.fit ,best =3)
plot(prune.mydf )
text(prune.mydf ,pretty =0)
tree.pred=predict (prune.mydf , mydf.test ,type="class")
table(tree.pred ,highPrice.test)
```
* Cross Validation:

![](addplot3.png)
####__Fitting A Regression Tree__

######__Define data that will be used for fitting Regression Tree:__
```{r}
regTree<-mydf[c(-11)]
str(regTree)
```
######__regTree data contains 3774 obs. of  10 variables__
```{r}
set.seed (1001)
train = sample (1: nrow(regTree ),2*nrow(regTree )/3)
```
######__training data set = 2516 obs, and testing = 1258 obs.__
```{r}
tree.regTree =tree(lprice~.,regTree ,subset =train)
summary (tree.regTree )
plot(tree.regTree )
text(tree.regTree ,pretty =0)
```

######__Determining Model improvement using pruning:__

* Cross Validation:
![](addplot4.png)
* Cross-Validation function cv.tree() function is used  to determine whether pruning the tree will improve performance: It indicates that the optimal single tree size is = 7 terminal nodes. 
```{r}
##********cv.regTree =cv.tree(tree.regTree )
#********plot(cv.regTree$size ,cv.regTree$dev ,type='b')
#Pruning the tree selected by cross-validation.
prune.regTree =prune.tree(tree.regTree ,best =7)
plot(prune.regTree )
text(prune.regTree ,pretty =0)
```

######__Predictions using unpruned tree:__
```{r}
yhat=predict (tree.regTree ,newdata =regTree [-train ,])
regTree.test=regTree [-train ,"lprice"]
plot(yhat ,regTree.test)
abline (0,1)
```

######__MSE:__

```{r}
mean((yhat -regTree.test)^2)
```