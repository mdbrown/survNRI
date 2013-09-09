Hhat.yy.FUN <-
function(xi,di,yi,tt,bw,yy=NULL){

  ## estimating P(C > tt | Y = yy), use KM if yi=NULL, CondKM otherwise ##

   if(is.null(yy)){yy = yi}

   if(is.null(yi)){
      H.yy.tt = 1-PtfromKm(cbind(xi,1-di),tt)
   }else{        
      H.yy.tt = CondSurv.FUN(xi=xi,di=1-di,yi=yi,tt0=tt,bw=bw,yy=yy,rtn="Shat")
   }
  
   H.yy.tt	  	
}
