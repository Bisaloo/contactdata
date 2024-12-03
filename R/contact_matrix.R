#' Get contact data matrix for a specific country
#'
#' @param country Character. The name of the country for which you want contact
#'    data.
#' @param location Character. One of "all" (default), "home", "school", "work"
#'   or "other".
#' @param geographic_setting Character. One of "all" (default), "rural", "urban"
#' @param data_source Character. Either "202O" (default) or "2017"
#' @param age_limits A numeric vector specifying the targeted age limits. 
#' If set to `NULL` (default), the function assumes 16 predefined age groups: 
#' 0-4, 5-9, ..., 75-79, and 80+.
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
  data_source = c("2020", "2017"),
  age_limits = NULL
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
  if (age_limits != NULL)
  {
    groups_name <- colnames(matrix_country)
  old_limits <- unname(sapply(groups_name, function(x) as.integer(strsplit(x, split = "_")[[1]][1])))

  colnames(matrix_country) <- as.character(reduce_agegroups(old_limits, age_limits))
  rownames(matrix_country) <- as.character(reduce_agegroups(old_limits, age_limits))
  
  unique_names <-  unique(colnames(matrix_country))
  
  row_sums <- sapply(unique_names, function(x) rowSums(matrix_country[, which(colnames(matrix_country)==x), drop = FALSE]))
  
  new_matrix <- sapply(unique_names, function(x) colSums(row_sums[which(rownames(matrix_country)==x), , drop = FALSE]))
  rownames(new_matrix) <- c(sprintf("[%s,%s)", age_limits[-length(age_limits)], age_limits[-1]), paste(toString(age_limits[length(age_limits)]),"+", sep = ""))
  colnames(new_matrix) <-  c(sprintf("[%s,%s)", age_limits[-length(age_limits)], age_limits[-1]), paste(toString(age_limits[length(age_limits)]),"+", sep = ""))
  
  return(new_matrix)
  } else {
    old_limits <- unname(sapply(groups_name, function(x) as.integer(strsplit(x, split = "_")[[1]][1])))

  colnames(matrix_country) <- as.character(reduce_agegroups(old_limits, age_limits))
  rownames(matrix_country) <- as.character(reduce_agegroups(old_limits, age_limits))
    return(matrix_country)
    }
}
