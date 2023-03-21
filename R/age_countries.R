#' Get a data.frame (in long format) of population by age for multiple
#' geographical regions
#'
#' @inheritParams contact_df_countries
#'
#' @return A data.frame (in long format) with 3 columns:
#'   * `country`: the geographical region name
#'   * `age`: the age group
#'   * `population`: the number of people in this age group
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

  unknown_regions <- countries[!countries %in% pop_byage$country]

  if (length(unknown_regions) != 0) {
    warning(
      "The following geographical regions are not included in the dataset:\n",
      toString(unknown_regions), "\n",
      "Use the list_countries() function to get a list of all ",
      "geographical regions in the dataset.",
      call. = FALSE
    )
  }

  return(pop_byage[pop_byage$country %in% countries, ])

}
