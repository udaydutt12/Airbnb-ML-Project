####__Nonlinear SVM__
```{r}
svmfit =svm(y~.,data=dat [itrain ,], kernel ="radial", 
            gamma =1,cost =1)
plot(svmfit,dat[itrain ,])
```

######__Information about the SVM fit__
```{r}
summary (svmfit)
```
######__Increase the value of cost to reduce the number of training errors__
```{r}
svmfit=svm(y~.,data=dat[itrain ,], kernel="radial",gamma=1,cost=100)
plot(svmfit ,dat [itrain ,])
```


######__Perform cross-validation using tune() to select the best choice of variables and cost for an SVM with a radial kernel__


```{r}
set.seed (1)
tune.out=tune(svm, y~.,data=dat[itrain ,],kernel ="radial",
              ranges =list(cost=c(0.1 ,1 ,10 ,100 ,1000),
                           gamma=c(0.5,1,2,3,4)))
summary (tune.out)
```
######__Making Predictions__
```{r}
table(true=dat[-itrain ,"y"], pred=predict (tune.out$best.model ,
                                            newdata =dat[-itrain,]))
```
