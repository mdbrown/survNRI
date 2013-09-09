PtfromKm <-
function(data,predict.time) {
   km = survfit(Surv(data[,1],data[,2])~1)

   1-approx(km$time,km$surv,predict.time)$y
}
