# Tutorial for R package `survNRI`
October 16, 2017  

This package contains a single function, `survNRI`, which calculates the NRI for survival data using up to five different estimators. The different methods available are:

- *KM* = Kaplan- Meier estimator 
- *IPW* = Inverse probability weighted estimator 
- *SmoothIPW* = Smooth inverse probability weighted estimator 
- *SEM* = Semi-parametric estimator
- *Combined*= Combined estimator as described (along with all other estimates) in the reference paper.

### Tutorial



Install the package from Github using the `devtools` package. 


```r
library(devtools) 
install_github("mdbrown/survNRI")
```


```r
library(survNRI)
```


```r
#some simulated data for example. 
data(SimData)

#take a look 
head(SimData)
```

```
##        stime status         y1         y2
## 1  3.9739276      1  0.6941739 -1.3600205
## 2  4.2776989      0 -1.8042212 -0.4031856
## 3  6.3921888      0 -0.3541849 -1.0477879
## 4  7.8256953      1 -1.7860011 -0.7711128
## 5  0.7346158      0 -1.0067846  1.2007543
## 6 22.4002292      0 -0.6357343 -0.4936282
```

Calculate the NRI using all estimators at future time 2.



```r
#bootstrap only 10 times to reduce computation for this example. 
survNRI( time  = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), data = SimData, 
         predict.time = 2, method = "all", bootMethod = "normal",  bootstraps = 10, alpha = .05)
```

```
## 
##  Net Reclassification Improvement at time t = 2
##   with 95% bootstrap confidence intervals based on normal approximation.
## 
##  method     |  event NRI              non-event NRI             NRI 
## -------------------------------------------------------------------------------
##   KM        |  0.058 (-0.140,0.255)   0.239 (0.121,0.415)   0.297 (-0.040,0.576)   
##   IPW       |  0.056 (-0.141,0.253)   0.238 (0.121,0.412)   0.294 (-0.041,0.573)   
##   SmoothIPW |  0.054 (-0.146,0.253)   0.237 (0.122,0.406)   0.291 (-0.042,0.570)   
##   SEM       |  0.131 (0.041,0.221)   0.270 (0.174,0.496)   0.401 (0.136,0.535)   
##   Combined  |  0.088 (-0.086,0.261)   0.251 (0.132,0.458)   0.339 (-0.008,0.598)   
## -------------------------------------------------------------------------------
```

Now only estimate using the smooth IPW, SEM and combined methods. 


```r
tmp <- survNRI( time  = "stime", event = "status", model1 = "y1", model2 = c("y1", "y2"), data = SimData, 
         predict.time = 3, method = c("SmoothIPW", "SEM", "Combined"), bootMethod = "percentile", bootstraps = 10, alpha = .01)

#look at the results
tmp
```

```
## 
##  Net Reclassification Improvement at time t = 3
##   with 99% bootstrap confidence intervals based on percentiles.
## 
##  method     |  event NRI              non-event NRI             NRI 
## -------------------------------------------------------------------------------
##   SmoothIPW |  0.130 (0.052,0.185)   0.243 (0.177,0.311)   0.373 (0.299,0.450)   
##   SEM       |  0.164 (0.084,0.202)   0.264 (0.184,0.317)   0.428 (0.325,0.496)   
##   Combined  |  0.145 (0.062,0.191)   0.252 (0.181,0.307)   0.397 (0.303,0.464)   
## -------------------------------------------------------------------------------
```


```r
#access estimates and ci's
tmp$estimates
```

```
##           NRI.event NRI.nonevent       NRI
## SmoothIPW 0.1304272    0.2425232 0.3729504
## SEM       0.1638181    0.2640453 0.4278633
## Combined  0.1450687    0.2519604 0.3970291
```

```r
tmp$CI
```

```
## $NRI.event
##             SmoothIPW       SEM   Combined
## lowerbound 0.05170142 0.0840699 0.06211513
## upperbound 0.18481643 0.2020702 0.19120167
## 
## $NRI.nonevent
##            SmoothIPW       SEM  Combined
## lowerbound 0.1772579 0.1838134 0.1807217
## upperbound 0.3106670 0.3168780 0.3069153
## 
## $NRI
##            SmoothIPW       SEM  Combined
## lowerbound 0.2994608 0.3254050 0.3025600
## upperbound 0.4501999 0.4964829 0.4636058
```


for more information see `?survNRI`. 

### References 

*Lifetime Data Analysis* 2012 Dec 20. [Epub ahead of print] Evaluating incremental values from new predictors with net reclassification improvement in survival analysis. Zheng Y, Parast L, Cai T, Brown M. PMID: 23254468



