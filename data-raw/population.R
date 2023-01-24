library(dplyr)

# From https://www2.census.gov/programs-surveys/international-programs/about/idb/idbzip.zip
population_byage <- vroom::vroom("data-raw/idb5yr.all") %>%
  filter(`#YR` == "2020") %>%
  rename(country = NAME) %>%
  select(country, matches("^POP\\d+\\_\\d+$")) %>%
  mutate(country = fix_names(country)) %>%
  filter(country %in% contactdata::list_countries()) %>%
  rename_with(~ gsub("^POP", "", .x), matches("^POP\\d+\\_\\d+$")) %>%
  rowwise() %>%
  mutate("75+" = sum(`75_79`, `80_84`, `85_89`, `90_94`, `95_99`), .keep = "unused") %>%
  tidyr::pivot_longer(-country, names_to = "age", values_to = "population") %>%
  as.data.frame()

saveRDS(population_byage, "inst/extdata/population_byage.rds")
