```{r setup, include=FALSE}
library(ggplot2)
library (tree)
load('rdata.RData')
load('mydf.RData')
#srcFile <- 'clean_listings_summary1.csv'
#datin <- read.csv(srcFile, header=T)
#rdata<-datin[c(6:12,14:16)]
#rdata<-rdata[which(rdata$neighbPIN!='78733'),]
#rdata<-rdata[which(rdata$neighbPIN!='78717'),]# Remove data with PIN='78717'
#rdata<-rdata[which(rdata$neighbPIN!='78724'),]# Remove data with PIN='78724'
#rdata<-rdata[which(rdata$neighbPIN!='78726'),]# Remove data with PIN='78726'
#rdata<-rdata[which(rdata$neighbPIN!='78728'),]# Remove data with PIN='78728'
#rdata<-rdata[which(rdata$neighbPIN!='78730'),]# Remove data with PIN='78730'
#rdata<-rdata[which(rdata$neighbPIN!='78736'),]# Remove data with PIN='78736'
#rdata<-rdata[which(rdata$neighbPIN!='78738'),]# Remove data with PIN='78738'
############rdata<-rdata[which(rdata$neighbPIN!='78739'),]# Remove data with PIN='78739'
#rdata<-rdata[which(rdata$neighbPIN!='78754'),]# Remove data with PIN='78754'
#rdata$neighbPIN<-factor(rdata$neighbPIN) #changing to factor
#rdata<- na.omit(rdata)
#with(rdata,sum(is.na(revPerMonth)))
lprice<-log(rdata$price)
#rdata$lprice<-lprice
#mydf<-rdata[c(-5)] 
highPrice=ifelse (lprice <=5.03,"No"," Yes ")
#summary(mydf)
#head(mydf)
#str(mydf)
x<-mydf
```