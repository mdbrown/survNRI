NRI.smooth.IPW <-
function(times, status, predict.time, Pt2,Pt1,bw=NULL, bw.power =bw.power, yes.smooth=TRUE) {
           
   nn = length(Pt2); uQi = Pt2; uPi = c(Pt1);

   Bi = Pt2 > Pt1; 

   if(is.null(bw)){
      bw=1.06*min(sd(uQi),IQR(uQi)/1.34)*nn^(-bw.power)
      bwB=1.06*min(sd(uQi[Bi]),IQR(uQi[Bi])/1.34)*sum(Bi)^(-bw.power)
   }

   if(yes.smooth){
      
      wgti    = IPW.FUN(times,    status    ,yi=uQi,    tt0=predict.time,bw=bw)
      wgti.Bi = IPW.FUN(times[Bi],status[Bi],yi=uQi[Bi],tt0=predict.time,bw=bwB)

   }else{
      wgti = IPW.FUN(times,status,yi=NULL,tt0=predict.time,bw=bw)
      wgti.Bi = wgti[Bi]
   }

   Pt = mean(wgti*(times<=predict.time), na.rm=TRUE); 
   Pt.B1 = mean(wgti.Bi*(times[Bi]<=predict.time), na.rm=TRUE); 

   NRI.event   = Pt.B1*mean(Bi, na.rm=TRUE)/Pt
   NRI.nonevent = (1-Pt.B1)*mean(Bi, na.rm=TRUE)/(1-Pt)
   
   c(NRI.event=NRI.event,NRI.nonevent=NRI.nonevent, NRI=2*(NRI.event-NRI.nonevent)) 
}
