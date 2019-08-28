
####__K-Means Clustering__
```{r, include=FALSE}
# Create new data for KMEAN by removing categorial variables
kmdat<-mydf[c(5:10)]
head(kmdat)
#Remove missing observations from the data
na.omit(kmdat)
```

```{r}
# Standardize numeric variables
skmdat <- scale(kmdat)
# check that we get mean of 0 and sd of 1
apply(skmdat, 2, mean)
apply(skmdat, 2, sd)
set.seed(101)
km.out<-kmeans(skmdat,3,nstart=50)
#km.out
km.out$size
km.out$cluster
```
######__Evaluation with respect to rmType__
```{r}
table(mydf$rmType,km.out$cluster)
plot(mydf[c("revPerMonth","lprice")], col=km.out$cluster)
plot(mydf[c("revPerMonth","lprice")], col=mydf$rmType)
```
######__Evaluation with respect to Price__
```{r}
set.seed(10101)
km.out<-kmeans(skmdat,2,nstart=50)
table(mydf$highPrice,km.out$cluster)
plot(mydf[c("revPerMonth","lprice")], col=km.out$cluster)
plot(mydf[c("revPerMonth","lprice")], col=mydf$highPrice)
```