survNRI
============================

This package contains a single function `survNRI` which calculates the NRI for survival data using up to five different estimators. The different methods available are:

- *KM* = Kaplan- Meier estimator 
- *IPW* = Inverse probability weighted estimator 
- *SmoothIPW* = Smooth inverse probability weighted estimator 
- *SEM* = Semi-parametric estimator
- *Combined*= Combined estimator as described (along with all other estimates) in the reference paper.

### Tutorial



```r
library(survNRI)
```

```
## Loading required package: MASS Loading required package: survival Loading
## required package: splines
```

```r
# some simulated data for example.
data(SimData)

# take a look
head(SimData)
```

```
##     stime status      y1      y2
## 1  3.9739      1  0.6942 -1.3600
## 2  4.2777      0 -1.8042 -0.4032
## 3  6.3922      0 -0.3542 -1.0478
## 4  7.8257      1 -1.7860 -0.7711
## 5  0.7346      0 -1.0068  1.2008
## 6 22.4002      0 -0.6357 -0.4936
```


Calculate the NRI using all estimators at future time 2.



```r
# bootstrap only 10 times to reduce computation for this example.
survNRI(time = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), 
    data = SimData, predict.time = 2, method = "all", bootMethod = "normal", 
    bootstraps = 10, alpha = 0.05)
```

```
## 
##  Net Reclassification Improvement at time t = 2
##   with 95% bootstrap confidence intervals based on normal approximation.
## 
##  method     |  event NRI              non-event NRI             NRI 
## -------------------------------------------------------------------------------
##   KM        |  0.529 (0.457,0.600)   0.380 (0.349,0.328)   0.297 (0.217,0.460)   
##   IPW       |  0.531 (0.461,0.600)   0.380 (0.345,0.336)   0.301 (0.211,0.470)   
##   SmoothIPW |  0.527 (0.456,0.598)   0.381 (0.350,0.323)   0.291 (0.219,0.454)   
##   SEM       |  0.566 (0.528,0.603)   0.365 (0.319,0.447)   0.401 (0.224,0.542)   
##   Combined  |  0.544 (0.478,0.609)   0.374 (0.341,0.372)   0.339 (0.221,0.492)   
## -------------------------------------------------------------------------------
```


Now only estimate using the smooth IPW, SEM and combined methods. 


```r
tmp <- survNRI(time = "stime", event = "status", model1 = "y1", model2 = c("y1", 
    "y2"), data = SimData, predict.time = 3, method = c("SmoothIPW", "SEM", 
    "Combined"), bootMethod = "percentile", bootstraps = 10, alpha = 0.01)

# look at the results
tmp
```

```
## 
##  Net Reclassification Improvement at time t = 3
##   with 99% bootstrap confidence intervals based on percentiles.
## 
##  method     |  event NRI              non-event NRI             NRI 
## -------------------------------------------------------------------------------
##   SmoothIPW |  0.565 (0.475,0.621)   0.379 (0.361,0.468)   0.373 (0.190,0.440)   
##   SEM       |  0.582 (0.540,0.617)   0.368 (0.336,0.452)   0.428 (0.289,0.493)   
##   Combined  |  0.573 (0.476,0.611)   0.374 (0.357,0.454)   0.397 (0.193,0.451)   
## -------------------------------------------------------------------------------
```



```r
# access estimates and ci's
tmp$estimates
```

```
##           NRI.event NRI.nonevent    NRI
## SmoothIPW    0.5652       0.3787 0.3730
## SEM          0.5819       0.3680 0.4279
## Combined     0.5725       0.3740 0.3970
```

```r
tmp$CI
```

```
## $NRI.event
##            SmoothIPW    SEM Combined
## lowerbound    0.4748 0.5398   0.4756
## upperbound    0.6205 0.6169   0.6114
## 
## $NRI.nonevent
##            SmoothIPW    SEM Combined
## lowerbound    0.3614 0.3356   0.3573
## upperbound    0.4678 0.4525   0.4543
## 
## $NRI
##            SmoothIPW    SEM Combined
## lowerbound    0.1905 0.2889   0.1931
## upperbound    0.4397 0.4934   0.4510
```



for more information see `?survNRI`. 

### References 

*Lifetime Data Analysis* 2012 Dec 20. [Epub ahead of print] Evaluating incremental values from new predictors with net reclassification improvement in survival analysis. Zheng Y, Parast L, Cai T, Brown M. PMID: 23254468



