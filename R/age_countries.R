#' Get a data.frame (in long format) of population by age for multiple countries
#'
#' @inheritParams contact_df_countries
#'
#' @return A data.frame (in long format) with 3 columns:
#'   * `country`: the country name
#'   * `age`: the age group
#'   * `pop`: the number of people in this age group
#'
#' @examples
#' age_df_countries(c("Austria", "Belgium"))
#'
#' @export
#'
#' @references
#' <https://www.census.gov/programs-surveys/international-programs/about/idb.html>
#'
age_df_countries <- function(countries) {

  pop_byage <- readRDS(
    system.file("extdata", "population_byage.rds",
                package = "contactdata")
  )

  unknown_countries <- countries[!countries %in% pop_byage$country]

  if (length(unknown_countries) != 0) {
    warning(
      "The following countries are not included in the dataset:\n",
      paste0(unknown_countries, collapse = ", "), "\n",
      "Use the list_countries() function to get a list of all ",
      "countries in the dataset.",
      call. = FALSE
    )
  }

  return(pop_byage[pop_byage$country %in% countries, ])

}
