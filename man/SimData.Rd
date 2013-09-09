\name{SimData}
\alias{SimData}
\docType{data}
\title{
 Simulated data for package 'survNRI'
}
\description{
Simulated survival data. 
}
\usage{data(SimData)}
\format{
  A data frame with 500 observations on the following 4 variables.
  \describe{
    \item{\code{stime}}{a numeric vector of survival time}
    \item{\code{status}}{a numeric vector indicating event status}
    \item{\code{y1}}{a numeric vector of values for marker 1}
    \item{\code{y2}}{a numeric vector of values for marker 2}
  }
}


\examples{
data(SimData)
 
head(SimData)

}
\keyword{datasets}
