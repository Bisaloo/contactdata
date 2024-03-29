% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/age_countries.R
\name{age_df_countries}
\alias{age_df_countries}
\title{Get a data.frame (in long format) of population by age for multiple countries}
\usage{
age_df_countries(countries)
}
\arguments{
\item{countries}{A character string or a vector of character containing the
names of the countries for which to return contact data}
}
\value{
A data.frame (in long format) with 3 columns:
\itemize{
\item \code{country}: the country name
\item \code{age}: the age group
\item \code{population}: the number of people in this age group
}
}
\description{
Get a data.frame (in long format) of population by age for multiple countries
}
\examples{
age_df_countries(c("Austria", "Belgium"))

}
\references{
\url{https://www.census.gov/programs-surveys/international-programs/about/idb.html}
}
