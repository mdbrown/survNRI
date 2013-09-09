
library(survNRI)


data(SimData)

?survNRI

survNRI( time  = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), data = SimData, 
         predict.time = 2, method = "all", bootMethod = "normal",  bootstraps = 10, alpha = .05)


tmp <- survNRI( time  = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), data = SimData, 
         predict.time = 2, method = c("SmoothIPW", "SEM", "Combined"), bootMethod = "percentile", bootstraps = 10)


tmp <- survNRI( time  = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), data = SimData, 
         predict.time = 3, method = "all", bootMethod = "percentile", bootstraps = 10, alpha = .01)

#look at the results
tmp

#access estimates and ci's
tmp$estimates
tmp$CI



