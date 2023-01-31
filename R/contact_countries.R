#' Get a data.frame (in long format) of contact data for multiple countries
#'
#' @inheritParams contact_matrix
#' @param countries A character string or a vector of character containing the
#'    names of the countries for which to return contact data
#'
#' @return A data.frame (in long format) with 4 columns:
#'   * `country`: the country name
#'   * `age_from`: the age group of individual
#'   * `age_to`: the age group of contact
#'   * `contact`: the intensity of contact
#'
#' @examples
#' contact_df_countries(c("Austria", "Belgium"), location = "all")
#'
#' @export
#'
#' @importFrom stats reshape
#'
#' @inherit list_countries references

contact_df_countries <- function(
  countries,
  location = c("all", "home", "school", "work", "other"),
  setting = c("all", "rural", "urban"),
  data_source = c("2017", "2020")
) {

  res <- lapply(countries, contact_matrix, location, setting, data_source)

  res <- lapply(seq_along(res), function(i) {
    out <- reshape(
      as.data.frame(res[[i]]),
      idvar = "age_from",
      ids = row.names(res[[i]]),
      times = colnames(res[[i]]),
      timevar = "age_to",
      varying = list(colnames(res[[i]])),
      direction = "long"
    )
    rownames(out) <- NULL
    colnames(out)[2] <- "contact"
    out$country <- countries[[i]]
    out <- out[, c(4,3,1,2)]
    return(out)
  })

  do.call(rbind.data.frame, res)
}
