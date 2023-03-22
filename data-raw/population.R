library(dplyr)

fix_names <- function(name) {

  # Convert to common names in English
  name <- stringi::stri_trans_general(name, "Latin-ASCII")
  new_name <- countrycode::countryname(name)

  return(new_name)
}

all_countries <- unique(c(
  contactdata::list_countries(2017),
  contactdata::list_countries(2020)
))

# From https://www2.census.gov/programs-surveys/international-programs/about/idb/idbzip.zip
population_byage <- vroom::vroom(file.path("data-raw", "idb5yr.all")) %>%
  filter(`#YR` == "2020") %>%
  rename(country = NAME) %>%
  select(country, matches("^POP\\d+\\_\\d+$")) %>%
  mutate(country = fix_names(country), .after = 1) %>%
  filter(country %in% all_countries) %>%
  rename_with(~ gsub("^POP", "", .x), matches("^POP\\d+\\_\\d+$")) %>%
  # Palestine is separated in 'West Bank' and 'Gaza Strip' in pop dataset so
  # we need to sum
  group_by(country) %>%
  summarise(across(everything(), sum)) %>%
  rowwise() %>%
  mutate("75+" = sum(`75_79`, `80_84`, `85_89`, `90_94`, `95_99`), .keep = "unused") %>%
  tidyr::pivot_longer(-country, names_to = "age", values_to = "population") %>%
  as.data.frame()

saveRDS(
  population_byage,
  file.path("inst", "extdata", "population_byage.rds")
)
