# Random Forest
bag.regTree =randomForest(lprice~.,data=regTree ,subset =train ,
                          mtry=9, ntree =100)
yhat.bag = predict (bag.regTree ,newdata =regTree [-train ,])

# MSE
mean(( yhat.bag -regTree.test)^2)

# Use Smaller tree using mtry = p/3 around 3
set.seed (1012)
rf.regTree =randomForest(lprice~.,data=regTree ,subset =train ,
                         mtry=3, importance =TRUE)
yhat.rf = predict (rf.regTree ,newdata =regTree [-train ,])

# MSE
mean(( yhat.rf -regTree.test)^2)

# Importance of each factor:
importance (rf.regTree )
varImpPlot (rf.regTree )

# Performance of Random Forest:
rf.regTree=randomForest(lprice~.,data=regTree,subset=train)
rf.regTree

# The MSE and % variance explained are based on OOB (out-of-bag) estimates,
# a very clever device in random forests to get honest error estimates. The model 
# reports that $mtry=3$, which is the number of variables randomly chosen at each split. 
# Since $p=9$ here, we could try all 9 possible values of mtry We will do so, record the results, 
# and make a plot.
oob.err=double(9)
test.err=double(9)
for(mtry in 1:9){
  fit=randomForest(lprice~.,data=regTree,subset=train,mtry=mtry,ntree=400)
  oob.err[mtry]=fit$mse[400]
  pred=predict(fit,regTree[-train,])
  test.err[mtry]=with(regTree[-train,],mean((lprice-pred)^2))
  cat(mtry," ")
}
matplot(1:mtry,cbind(test.err,oob.err),pch=19,col=c("red","blue"),
        type="b",ylab="Mean Squared Error")
legend("topright",legend=c("OOB","Test"),pch=19,col=c("red","blue"))
# (Note: mtry=9`corresponds to bagging.)

# Based on the plot above, it appears that the best m-value is 2 or 3 at which MSE based on 
# OOB and Test are equal and hence have no uncertainty. The random forest based model uses m = 3, 
# and have the least MSE of 0.283 and it explains about 59.46% variation of the data.
