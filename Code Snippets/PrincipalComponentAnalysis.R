
####__Principal COmponent Analysis__

The objective of PCA is the understand how to group the multi-variate data into groups. Further, understanding whether it is possible to transform correlated variables into a smaller number of uncorrelated variables.

###### __Create new data for PCA by removing categorial variables__
```{r}
pcadat<-mydf[c(5:10)]
head(pcadat)
apply(pcadat,2,mean) # Determine column means
apply(pcadat,2,var) # Determine column stdev
# Standardize/normalize the data 
pcadat <- scale(pcadat)
head(pcadat)
pca.out=prcomp(pcadat, scale=TRUE)
pca.out
names(pca.out)
```
######__Plot the first two principal components__
```{r}
biplot(pca.out, scale=0)
```
######__Principal component loading vectors (Eigen Vectors)__
```{r}
pca.out$rotation
```
######__Standard deviation of each principal component__
```{r}
pca.out$sdev
```
######__Variance explained by each principal component__
```{r}
pca.var <- pca.out$sdev ^2
pca.var
```
######__Proportion of variance explained by each principal component__
```{r}
pve=pca.var/sum(pca.var )
pve
```
######__Plot the PVE explained by each component, as well as the cumulative PVE, as follows:__
```{r}
plot(pve , xlab="Principal Component", ylab =" Proportion of Variance Explained ", 
     ylim=c(0,1) ,type='b')
plot(cumsum (pve ), xlab=" Principal Component ", ylab ="
     Cumulative Proportion of Variance Explained ", ylim=c(0,1) ,
     type='b')
summary(pca.out)
```
