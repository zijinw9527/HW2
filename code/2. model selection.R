#This part is written by Haoran Teng
#Second part: model selection 

#Use step() to select models with two-way interactions by AIC and BIC
lm0 <- lm(BODYFAT~1, data=cleandata)
lm1 <- lm(BODYFAT~ .*., data=cleandata)
#AIC
model1= step(lm0, scope = list(upper=lm1), direction = "both",k=2)
#Check assumptions and influential points
quartz(12,6)
par(mfrow = c(2,3))
plot(model1, which  = 1)
plot(model1, which  = 2)
plot(model1, which  = 3)
plot(model1, which  = 4)
plot(model1, which  = 5)
plot(model1, which  = 6)
#meets assumptions well
#BIC
model2=step(lm0, scope = list(upper=lm1), direction = "both",k=log(244))
quartz(12,6)
par(mfrow = c(2,3))
plot(model2, which  = 1)
plot(model2, which  = 2)
plot(model2, which  = 3)
plot(model2, which  = 4)
plot(model2, which  = 5)
plot(model2, which  = 6)
#meets assumptions well

#Use regsubsets() to select one-way models by adjr2, Cp, BIC
library(leaps)
leap0= regsubsets(BODYFAT~.,data=cleandata, nvmax = 15)
leapsum = summary(leap0)
quartz(12,6)
par(mfrow=c(1,3), pty="s") 
plot(leap0, scale = "adjr2",col="lightskyblue2")
plot(leap0, scale = "Cp",col="lightskyblue2")
plot(leap0, scale = "bic",col="lightskyblue2")

#From this plot:
#adjr2
model3 = lm(BODYFAT~AGE +HEIGHT+NECK+HIP+THIGH+CHEST+FOREARM+ABDOMEN +WRIST, data = cleandata)
#Check assumptions
quartz(12,6)
par(mfrow = c(2,3))
plot(model3, which  = 1)
plot(model3, which  = 2)
plot(model3, which  = 3)
plot(model3, which  = 4)
plot(model3, which  = 5)
plot(model3, which  = 6)
#meets assumptions well
#Cp
model4 = lm(BODYFAT~AGE +HEIGHT+NECK+CHEST+FOREARM+ABDOMEN +WRIST, data = cleandata)
#Check assumptions
quartz(12,6)
par(mfrow = c(2,3))
plot(model4, which  = 1)
plot(model4, which  = 2)
plot(model4, which  = 3)
plot(model4, which  = 4)
plot(model4, which  = 5)
plot(model4, which  = 6)
#meets assumptions well

