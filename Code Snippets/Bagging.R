
####__Bagging__
```{r}
library (randomForest)
set.seed (1111)
bag.regTree =randomForest(lprice~.,data=regTree ,subset =train ,
                          mtry=9, importance =TRUE)
bag.regTree
```



###### __Performance of the bagged model:__
```{r}
yhat.bag = predict (bag.regTree ,newdata =regTree [-train ,])
plot(yhat.bag , regTree.test)
abline (0,1)
```

######__MSE:__

```{r}
mean(( yhat.bag -regTree.test)^2)
```