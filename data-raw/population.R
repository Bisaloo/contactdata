library(dplyr)

fix_names <- function(name) {

  # Convert to common names in English
  name <- stringi::stri_trans_general(name, "Latin-ASCII")
  new_name <- countrycode::countryname(name)

  return(new_name)
}

all_regions <- unique(c(
  contactdata::list_countries(2017),
  contactdata::list_countries(2020)
))

# From https://www2.census.gov/programs-surveys/international-programs/about/idb/idbzip.zip
population_byage <- vroom::vroom("data-raw/idb5yr.all") %>%
  filter(`#YR` == "2020") %>%
  rename(region = NAME) %>%
  select(region, matches("^POP\\d+\\_\\d+$")) %>%
  mutate(region = fix_names(region), .after = 1) %>%
  filter(region %in% all_regions) %>%
  rename_with(~ gsub("^POP", "", .x), matches("^POP\\d+\\_\\d+$")) %>%
  # Palestine is separated in 'West Bank' and 'Gaza Strip' in pop dataset so
  # we need to sum
  group_by(region) %>%
  summarise(across(everything(), sum)) %>%
  rowwise() %>%
  mutate("75+" = sum(`75_79`, `80_84`, `85_89`, `90_94`, `95_99`), .keep = "unused") %>%
  tidyr::pivot_longer(-region, names_to = "age", values_to = "population") %>%
  as.data.frame()

saveRDS(population_byage, "inst/extdata/population_byage.rds")
