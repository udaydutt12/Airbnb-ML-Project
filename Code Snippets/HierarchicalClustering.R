
####__Hierarchical Clustering__


######__Create new data for KMEAN by removing categorial variables__
```{r}
clust.dat<-mydf[c(6:7)]
#head(clust.dat)
#Remove missing observations from the data
#na.omit(clust.dat)
```
######__Use Complete cluster method__
```{r}
clust.complete=hclust(dist(clust.dat),method="complete")
plot(clust.complete)
```
######__Cut off the tree at the desired number of clusters using cutree__
```{r}
clusterCut <- cutree(clust.complete, 3)
table(clusterCut, mydf$rmType)
```
######__Try whether one can improve using a different linkage method__
```{r}
clust.average=hclust(dist(clust.dat),method="average")
plot(clust.average)
```
######__Try whether one can improve using a different linkage method__
```{r}
clust.single=hclust(dist(clust.dat),method="single")
plot(clust.single)
```
# Plot Identified Clusters
```{r}
ggplot(mydf, aes(numReviews, revPerMonth, color = mydf$rmType)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

ggplot(mydf, aes(numReviews, lprice, color = mydf$rmType)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))

ggplot(mydf, aes(revPerMonth, lprice, color = mydf$rmType)) + 
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) + 
  scale_color_manual(values = c('black', 'red', 'green'))