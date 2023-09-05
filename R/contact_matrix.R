#' Get contact data matrix for a specific country
#'
#' @param country Character. The name of the country for which you want contact
#'    data.
#' @param location Character. One of "all" (default), "home", "school", "work"
#'   or "other".
#' @param geographic_setting Character. One of "all" (default), "rural", "urban"
#' @param data_source Character. Either "202O" (default) or "2017"
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
  geographic_setting = c("all", "rural", "urban"),
  data_source = c("2020", "2017")
) {

  if (length(country) != 1) {
    stop("Please provide a single country", call. = FALSE)
  }

  location <- match.arg(location)
  # match.arg() only accepts characters in arg
  data_source <- as.character(data_source)
  data_source <- match.arg(data_source)

  if (data_source != "2020" && !missing(geographic_setting)) {
    stop(
      "`geographic_setting` is only defined for `data_source = 2020`",
      call. = FALSE
    )
  }

  geographic_setting <- match.arg(geographic_setting)

  all <- readRDS(
    system.file(
      "extdata",
      paste0("contact_", data_source, "_", location, "_", geographic_setting, ".rds"),
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

  res <- contactmatrix::new_contactmatrix(
    from      = rep(rownames(matrix_country),
                    each = length(colnames(matrix_country))),
    to        = rep(colnames(matrix_country),
                    length(rownames(matrix_country))),
    value     = c(t(matrix_country)),
    symmetric = FALSE
  )

  return(res)
}
