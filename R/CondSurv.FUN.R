CondSurv.FUN <-
function(xi, di, yi, tt0, bw, yy,rtn="ALL"){

   nv = length(xi); 
   kerni.yy = Kern.FUN(yy,yi,bw); ## nv x ny matrix
   skern.yy = apply(kerni.yy,2,sum)
   tmpind = (xi<=tt0)&(di==1); tj = xi[tmpind]; nj = length(tj)
   pi.tj.yy = sum.I(tj,"<=",xi,kerni.yy)/VTM(skern.yy,nj) ## n.tj x ny matrix ##
   dLam.tj.yy = kerni.yy[tmpind,,drop=F]/pi.tj.yy/VTM(skern.yy,nj); 
   dLam.tj.yy[is.na(dLam.tj.yy)] <- 0
   Shat.t0.yy = exp(-apply(as.matrix(dLam.tj.yy),2,sum))

   if(rtn=="ALL"){
      dLam.tj.yy = dLam.tj.yy/pi.tj.yy 
      dLam.tj.yy[is.na(dLam.tj.yy)] <- 0
      dLam.tj.yy[pi.tj.yy==0] <- 0

      Mi = rep(0,length(yi))
      Mi[tmpind] = 1/pi.tj.yy[cbind(1:nj,(1:nv)[tmpind])]        
      Mi = Mi - apply(dLam.tj.yy*(tj<=VTM(xi,length(tj))),2,sum)

      return(cbind(Shat.t0.yy,Mi) )
   }else{
      return(Shat.t0.yy)    
   }  	   
}
