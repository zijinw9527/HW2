#This part is written by Zijin Wang
#Third part: choose a model 

#Compare with K-fold cross-validation errors
library(caret)
set.seed(1)
train.control <- trainControl(method = "cv", number = 5)
cv1 <- train(model1$terms, data = cleandata, method = "lm",trControl = train.control)
cv1$results$RMSE
cv2 <- train(model2$terms, data = cleandata, method = "lm",trControl = train.control)
cv2$results$RMSE
cv3 <- train(model3$terms, data = cleandata, method = "lm",trControl = train.control)
cv3$results$RMSE
cv4 <- train(model4$terms, data = cleandata, method = "lm",trControl = train.control)
cv4$results$RMSE
#1st(AIC) has the lowest error. 
#1st(AIC)'s error is not much less than 2nd(BIC)'s, but much more complicated
#Use anova to figure the significance of difference.
anova(model2,model1)
anova(model4,model1)
#p=0.00037<0.05, reject H0, which means adding those terms offers significant difference
#to outcomes. So model1 is chosen.

