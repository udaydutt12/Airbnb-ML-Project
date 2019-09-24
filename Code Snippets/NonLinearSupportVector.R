# Nonlinear SVM
svmfit =svm(y~.,data=dat [itrain ,], kernel ="radial", 
            gamma =1,cost =1)
plot(svmfit,dat[itrain ,])

# Information about the SVM fit
summary (svmfit)

# Increase the value of cost to reduce the number of training errors
svmfit=svm(y~.,data=dat[itrain ,], kernel="radial",gamma=1,cost=100)
plot(svmfit ,dat [itrain ,])


# Perform cross-validation using tune()
# to select the best choice of variables 
# and cost for an SVM with a radial kernel
set.seed (1)
tune.out=tune(svm, y~.,data=dat[itrain ,],kernel ="radial",
              ranges =list(cost=c(0.1 ,1 ,10 ,100 ,1000),
                           gamma=c(0.5,1,2,3,4)))
summary (tune.out)

# Make Predictions
table(true=dat[-itrain ,"y"], pred=predict (tune.out$best.model ,
                                            newdata =dat[-itrain,]))
