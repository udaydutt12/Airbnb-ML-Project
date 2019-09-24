# Bagging
library (randomForest)
set.seed (1111)
bag.regTree =randomForest(lprice~.,data=regTree ,subset =train ,
                          mtry=9, importance =TRUE)
bag.regTree

# Performance of the bagged model:
yhat.bag = predict (bag.regTree ,newdata =regTree [-train ,])
plot(yhat.bag , regTree.test)
abline (0,1)

# MSE
mean(( yhat.bag -regTree.test)^2)