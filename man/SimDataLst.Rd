% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SimDataLst.R
\docType{data}
\name{SimDataLst}
\alias{SimDataLst}
\title{A list of data from K=20 sites}
\format{
A list contains 20 data tables. Each data contains 100 rows and 10 variables.
\describe{
  \item{SimDataLst}{A list contains 20 data tables}
  \item{S}{Site index (for each data table within `SimDataLst`)}
  \item{idx}{subject index (for each data table within `SimDataLst`)}
  \item{Z}{Binary treatment assignment (for each data table within `SimDataLst`)}
  \item{X1 - X5}{Covariates (for each data table within `SimDataLst`)}
  \item{tau}{True treatment effect (for each data table within `SimDataLst`)}
  \item{Y}{Outcome (for each data table within `SimDataLst`)}


}
}
\usage{
SimDataLst
}
\description{
A list of data from K=20 sites where odd sites and even sites form two distinct groups.
Each data contains information of site index, subject index, treatment assignment,
covariates, true treatment effect, outcome.
}
\details{
Obtained by the following codes: \cr
coord_id <- 1 \cr
K <- 20 \cr
SimDataLst <- list() \cr
for (k in 1:K) \{ \cr
    tmpdf <- GenSimData(k) \cr
    SimDataLst[[k]] <- tmpdf \cr
\} \cr
}
\keyword{datasets}
