#' Get the list of countries included in the dataset
#'
#' @return A character vector with the name of all countries included in the
#'    dataset
#'
#' @examples
#' available_contacts()
#'
#' @note This package uses the nomenclature from the \pkg{countrycode} package.
#'    If your names differ from the names used here, you should use
#'    \pkg{countrycode} as well to update them.
#'
#' @export
#'
#' @references Kiesha Prem, Alex R. Cook, Mark Jit, Projecting social contact
#' matrices in 152 countries using contact surveys and demographic data, PLoS
#' Comp. Biol. (2017), \doi{10.1371/journal.pcbi.1005697}

available_contacts <- function() {

  all_contacts <- readRDS(system.file("extdata", "all.rds", package = "contactdata"))

  return(names(all_contacts))

}
