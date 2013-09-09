survNRI <-
function(time, event, model1, model2, data,  predict.time, 
                method ="all",  bw.power = 0.35,  bootMethod = "normal",bootstraps = 500, alpha = 0.05
){

if(!is.element(time, names(data))) stop("'time' variable not recognized")
if(!is.element(event, names(data))) stop("'event' variable not recognized")
if(!all(is.element(model1, names(data)))) stop("'model1' variable names not recognized")
if(!all(is.element(model2, names(data)))) stop("'model2' variable names not recognized")
if(!is.element(bootMethod, c("normal", "percentile"))) stop("bootMethod must be either 'normal', 'percentile' or 'none'")


tmpdat <- data[,-which(c(time, event)==names(data)) ]


time = data[,time]
event= data[,event]

data <- tmpdat

method = c(method)
if( !all(is.element(method, c("IPW", "KM", "SEM", "SmoothIPW", "Combined", "all")))){

   tmpind <- which(!is.element(method,  c("KM", "IPW", "SmoothIPW", "SEM", "Combined", "all")))
   
   stop(paste( "Unknown method '", method[tmpind], "' \n 'method' must be a vector subset of c('IPW', 'KM', 'SEM', 'SmoothIPW', 'Combined', 'all')", sep = ""))
} 

  if(any(is.element(method, "all"))) method = c("KM","IPW", "SmoothIPW",  "SEM", "Combined")
  method <- c(method)
  
  result <- get.estimates( time = time, event = event, model1 = model1,
                                                       model2 = model2,
                                                       data = data,
                                                       predict.time = predict.time,
                                                       method =method,
                                                       bw.power = bw.power)

  if(bootMethod != "none"){

  if(bootstraps < 2) stop("bootstraps must be greater than 2 to compute CI's")

  ci <- get.CI(  time = time, event = event, model1 = model1,
                                                       model2 = model2,
                                                       data = data,
                                                       predict.time = predict.time,
                                                       method =method,
                                                       bw.power = bw.power, 
                                                       bootMethod = bootMethod, 
                                                       bootstraps = bootstraps,
                                                       alpha = alpha) 
  }else{
  ci<- NULL
  } 

  out <- list("estimates" = result, "CI" = ci, "bootMethod" = bootMethod, "predict.time" = predict.time, "alpha" = alpha)
  class(out) = "survNRI"

  return(out)


 }
