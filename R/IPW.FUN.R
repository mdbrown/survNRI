IPW.FUN <-
function(xi,di,yi=NULL,tt0,bw){

   ## =================================================================== ##
   ## Censoring IPW weights: I(Xi <= t0)di/G_yi(Xi) + I(Xi > t0)/G_yi(t0) ##
   ## =================================================================== ##

   nn = length(xi)
   wgti = (xi > tt0)/Hhat.yy.FUN(xi=xi,di=di,yi=yi,tt=tt0,bw=bw)
 
   tmpind = di==1&xi<=tt0; ttj = xi[tmpind]; 
   
   if(!is.null(yi)){
  	
      yj = yi[tmpind]; H.yj.ttj = rep(0,sum(tmpind)) 
      for(kk in 1:length(ttj)){
         H.yj.ttj[kk] = Hhat.yy.FUN(xi=xi,di=di,yi=yi,tt=ttj[kk],bw=bw,yy=yj[kk]) 
      }

      wgti[tmpind] = 1/H.yj.ttj
   }else{
      wgti[tmpind] = 1/Hhat.yy.FUN(xi=xi,di=di,yi=NULL,tt=ttj)	
   }

   wgti
}
