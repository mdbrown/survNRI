PtfromCox <-
function(data, predict.time) {
 
   x <- data[,-c(1,2), drop = FALSE]
   #formula =  paste(names(x), collapse = "+")
   myfit = coxph(Surv(data[,1],data[,2])~., data =x)

   junk = basehaz(myfit, centered=FALSE)	
   Lambdat = max(junk[junk[,2]<=predict.time,1])
   newz = model.matrix(myfit)
   c(1-exp(-Lambdat*exp(myfit$coef%*%t(newz))))	
  }
