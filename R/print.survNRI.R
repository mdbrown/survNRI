print.survNRI <- function(x, ...){

  if(is.null(x$CI)){
  cat("\n")
  cat(paste(" Net Reclassification Improvement at time t = ", x$predict.time, "\n", sep = ""))  

  cat("\n method       |  event NRI     non-event NRI     NRI \n")
  cat("------------------------------------------------------\n")

  for( i in 1:nrow(x$estimates)){
   cat(paste("  ", sprintf("%-10s",row.names(x$estimates)[i]), "|  ",  paste(round(x$estimates[i,], 3), collapse = "         "), "\n"))
  }
  cat("------------------------------------------------------\n")

  }else{

  cat("\n")
  cat(paste(" Net Reclassification Improvement at time t = ", x$predict.time, "\n", sep = ""))  
  cat(paste("  with ", 100*(1-x$alpha), "% bootstrap confidence intervals based on ", ifelse(x$bootMethod =="normal", "normal approximation.\n", "percentiles.\n"), sep= ""))
  cat("\n method     |  event NRI              non-event NRI             NRI \n")
  cat("-------------------------------------------------------------------------------\n")

  for( i in 1:nrow(x$estimates)){
   cat(paste(" ", sprintf("%-10s",row.names(x$estimates)[i])), "|  ", sep = "")
   
   cat(paste(sprintf("%0.3f", round( x$estimates[i,1], 3)), " (", sprintf("%0.3f",round(x$CI$NRI.event[1,i], 3)), ",", sprintf("%0.3f",round( x$CI$NRI.event[2,i], 3)), ")   ", sep = ""))
   cat(paste(sprintf("%0.3f", round( x$estimates[i,2], 3)), " (", sprintf("%0.3f",round(x$CI$NRI.nonevent[1,i], 3)), ",", sprintf("%0.3f",round( x$CI$NRI.nonevent[2,i], 3)), ")   ", sep = ""))
   cat(paste(sprintf("%0.3f", round( x$estimates[i,3], 3)), " (", sprintf("%0.3f",round(x$CI$NRI[1,i], 3)), ",", sprintf("%0.3f",round( x$CI$NRI[2,i], 3)), ")   ", sep = ""))
  
   cat("\n")
  }
  cat("-------------------------------------------------------------------------------\n")

 
  }




}
