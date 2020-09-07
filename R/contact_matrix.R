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

contact_matrix <- function(country, location = c("all", "home", "school", "work", "other")) {

  if (length(country) != 1) {
    stop("Please provide a single country", call. = FALSE)
  }

  location <- match.arg(location)

  all <- readRDS(system.file("extdata", paste0(location, ".rds"), package = "contactdata"))

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
