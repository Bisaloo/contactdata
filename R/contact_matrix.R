#' Get contact data matrix for a specific country
#'
#' @param country Character. The name of the country for which you want contact
#'    data.
#' @param location Character. One of "all", "home", "school", "work" or "other".
#'
#' @return A square (16 by 16) matrix containing the contact data between
#'    the different age classes for a given country.
#'
#' @examples
#' contact_matrix("France", location = "all")
#'
#' contact_matrix("Belgium", location = "school")
#'
#' @export
#'
#' @inherit list_countries references

contact_matrix <- function(
  country,
  location = c("all", "home", "school", "work", "other"),
  setting = c("all", "rural", "urban"),
  data_source = c("2017", "2020")
) {

  if (length(country) != 1) {
    stop("Please provide a single country", call. = FALSE)
  }

  location <- match.arg(location)
  data_source <- match.arg(data_source)
  if (data_source != 2020 & !missing(setting)) {
    stop("`setting` is only defined for `data_source = 2020`", call. = FALSE)
  }
  setting <- match.arg(setting)

  all <- readRDS(
    system.file(
      "extdata", paste0("contact_", data_source, "_", location, "_", setting, ".rds"),
      package = "contactdata"
    )
  )

  matrix_country <- all[[country]]

  if (is.null(matrix_country)) {
    stop(
      "The country ", country, " is not included in the dataset.\n",
      "Use the list_countries() function to get a list of all countries in",
      " the dataset.",
      call. = FALSE
    )
  }

  return(matrix_country)
}
