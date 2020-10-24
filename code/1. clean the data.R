#This part is written by Daiyi Shi
#First part: find possible outliers

BFdata<-read.csv("BodyFat.csv")
outlier<-c()

#Find outliers from quantiles.
library(car)
sddata<-scale(BFdata[,-1])
sddata<-as.data.frame(sddata)
quartz(16,6)
layout(matrix(c(1,2,2,1,2,2), nrow = 2, ncol = 3, byrow = TRUE))
box1<-Boxplot(sddata,id.method="row",col="lightskyblue2")#draw boxplot
barplot(table(box1),col="lightskyblue2")#some outliers show in different variables repeatedly
outlier<-c(outlier,39,41,216,175,31,42)

#Find outliers from "Siri's equation"
outdet<-BFdata[,-1]
outdet$error1=495 / outdet$DENSITY - 450-outdet$BODYFAT
quartz(12,6)
par(mfrow=c(1,2))
plot(outdet$error1,pch=20)
box2<-Boxplot(outdet$error1,id.method="row",col="lightskyblue2")
outlier<-c(outlier,96,48)

#Find outliers from BMI formula
outdet$error2=703 * outdet$WEIGHT /outdet$HEIGHT ^ 2-outdet$ADIPOSITY
quartz(12,6)
par(mfrow=c(1,2))
plot(outdet$error2,pch=20)
box3<-Boxplot(outdet$error2,id.method="row",col="lightskyblue2")

#Delete outliers
cleandata=BFdata[-outlier,-c(1,3)]

