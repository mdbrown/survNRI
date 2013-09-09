NRI.SEM <-
function(Pt2,Pt1) {

   #Pt2 is the risk estimated from the full model (with all markers)
   Pt = mean(Pt2)
   NRI.event = mean(Pt2*(Pt1<Pt2))/Pt
   NRI.nonevent = mean((1-Pt2)*(Pt1<Pt2))/(1-Pt)
   c(NRI.event=NRI.event,NRI.nonevent=NRI.nonevent, NRI=2*(NRI.event-NRI.nonevent)) 
}
