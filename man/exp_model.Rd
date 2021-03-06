% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/progmod.R
\name{exp_model}
\alias{exp_model}
\title{Overparametrized exponential function.}
\usage{
exp_model(t, l, s, g, v)
}
\arguments{
\item{t}{Time variable}

\item{l}{Scale parameter for the exponential function}

\item{s}{Time-shift parameter}

\item{g}{Time-scaling parameter}

\item{v}{Intercept parameter}
}
\value{
The function values at the supplied time values along with a
        "gradient" attribute.
}
\description{
Overparametrized exponential function.
}
\examples{
exp_model(t = c(0, 1), l = 1, s = 0, g = 0, v = 0)
}
