NRI.KM <-
function(Pt2, Pt1, data, predict.time) {

   Pt = PtfromKm(data,predict.time)
   
   data = data[Pt2>Pt1,]

   Pt.P2geP1 = PtfromKm(data,predict.time)
   Pt2gePt1  = mean(Pt2>Pt1)

   NRI.event = Pt.P2geP1*Pt2gePt1/Pt
   NRI.nonevent = (1-Pt.P2geP1)*Pt2gePt1/(1-Pt)

   c(NRI.event=NRI.event,NRI.nonevent=NRI.nonevent, NRI=2*(NRI.event-NRI.nonevent)) 
}
