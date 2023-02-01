#' Get the list of countries included in the dataset
#'
#' @inheritParams contact_matrix
#'
#' @return A character vector with the name of all countries included in the
#'    dataset
#'
#' @examples
#' list_countries()
#'
#' @note This package uses the nomenclature from the \pkg{countrycode} package.
#'    If your names differ from the names used here, you should use
#'    \pkg{countrycode} as well to update them.
#'
#' @export
#'
#' @references Kiesha Prem, Alex R. Cook, Mark Jit, *Projecting social contact
#'   matrices in 152 countries using contact surveys and demographic data*, PLoS
#'   Comp. Biol. (2017), \doi{10.1371/journal.pcbi.1005697}
#' @references Kiesha Prem, Kevin van Zandvoort, Petra Klepac, Rosalind M. Eggo,
#'   Nicholas G. Davies, CMMID COVID-19 Working Group, Alex R. Cook, Mark Jit,
#'   *Projecting contact matrices in 177 geographical regions: An update and
#'   comparison with empirical data for the COVID-19 era*, PLoS Comp. Biol.
#'   (2021), \doi{10.1371/journal.pcbi.1009098}.

list_countries <- function(
  setting = c("all", "rural", "urban"),
  data_source = c("2020", "2017")
) {

  # match.arg() only accepts characters in arg
  data_source <- as.character(data_source)
  data_source <- match.arg(data_source)

  if (data_source != "2020" & !missing(setting)) {
    stop("`setting` is only defined for `data_source = 2020`", call. = FALSE)
  }

  setting <- match.arg(setting)

  all_contacts <- readRDS(
    system.file(
      "extdata", paste0("contact_", data_source, "_all_", setting, ".rds"),
      package = "contactdata"
    )
  )

  return(names(all_contacts))

}
