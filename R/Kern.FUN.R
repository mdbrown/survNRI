Kern.FUN <-
function(zz,zi,bw,kern0="gauss"){ 
    out = (VTM(zz,length(zi))- zi)/bw
    switch(kern0,
            "epan"= 0.75*(1-out^2)*(abs(out)<=1)/bw,
            "gauss"= dnorm(out)/bw
           )
}
