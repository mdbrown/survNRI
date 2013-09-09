PtfromCox <-
function(data, predict.time) {

   myfit = coxph(Surv(data[,1],data[,2])~as.matrix(data[,-c(1,2)]))
   junk = basehaz(myfit, centered=FALSE)	
   Lambdat = max(junk[junk[,2]<=predict.time,1])
   newz = data[,-(1:2)]
   c(1-exp(-Lambdat*exp(myfit$coef%*%t(newz))))	
  }
