get.CI <- function(  time, event, model1,
                                  model2,
                                  data,
                                  predict.time,
                                  method,
                                  bw.power, 
                                  bootMethod, 
                                  bootstraps, 
                                  alpha
){

bootdat <- replicate(bootstraps, one.boot(time, event, model1,
                                  model2,
                                  data,
                                  predict.time,
                                  method,
                                  bw.power))
#lower bounds

bootdat.NRI.event    <- bootdat[,1,]
bootdat.NRI.nonevent <- bootdat[,2,]
bootdat.NRI          <- bootdat[,3,]  

if(bootMethod == "percentile"){

NRI.event    <- apply(bootdat.NRI.event, 1, quantile, probs = c(alpha/2, 1-alpha/2))
NRI.nonevent <- apply(bootdat.NRI.nonevent, 1, quantile, probs = c(alpha/2, 1-alpha/2))
NRI          <- apply(bootdat.NRI, 1, quantile, probs = c(alpha/2, 1-alpha/2))

}else if(bootMethod == "normal"){

sd.event <- apply(bootdat.NRI.event, 1, sd, na.rm = TRUE)
sd.nonevent <- apply(bootdat.NRI.nonevent, 1, sd, na.rm = TRUE)
sd.nri <- apply(bootdat.NRI, 1, sd, na.rm = TRUE)

estimates <- get.estimates(time, event, model1, model2, data,  predict.time, method,  bw.power)


#event
NRI.event <- data.frame(matrix(nrow = 2, ncol = length(method)))
names(NRI.event) = method

NRI.event[1,] <- estimates[,1] + qnorm(alpha/2)*sd.event 
NRI.event[2,] <- estimates[,1] + qnorm(1-alpha/2)*sd.event 

#non event
NRI.nonevent <- data.frame(matrix(nrow = 2, ncol = length(method)))
names(NRI.nonevent) = method

NRI.nonevent[1,] <- estimates[,2] + qnorm(alpha/2)*sd.nonevent 
NRI.nonevent[2,] <- estimates[,3] + qnorm(1-alpha/2)*sd.nonevent 

#nri

NRI <- data.frame(matrix(nrow = 2, ncol = length(method)))
names(NRI) = method
NRI[1,] <- estimates[,2] + qnorm(alpha/2)*sd.nri 
NRI[2,] <- estimates[,3] + qnorm(1-alpha/2)*sd.nri 


}


row.names(NRI.event) = row.names(NRI.nonevent) = row.names(NRI) = c("lowerbound", "upperbound")

return(list("NRI.event" = NRI.event,"NRI.nonevent" =  NRI.nonevent, "NRI" = NRI))
} 