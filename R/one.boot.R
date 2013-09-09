one.boot <- function(  time, event, model1,
                                  model2,
                                  data,
                                  predict.time,
                                  method,
                                  bw.power){


bootind = sample(nrow(data), replace = TRUE)

bootdata <- data[bootind,]

result <- get.estimates( time = time[bootind], event = event[bootind], model1 = model1,
                                                       model2 = model2,
                                                       data = bootdata,
                                                       predict.time = predict.time,
                                                       method =method,
                                                       bw.power = bw.power)
result <- as.matrix(result)
return(result)



} 
