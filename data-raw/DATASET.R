owd <- setwd(tempdir())

fix_names <- function(name) {

  # Convert to common names in English
  new_name <- countrycode::countryname(name)

  return(new_name)
}

download.file(
  url = "https://doi.org/10.1371/journal.pcbi.1005697.s002",
  destfile = "all_datasets.zip"
)

files <- unzip("all_datasets.zip", unzip = "internal")

library(fs)

files <- file_move(files, gsub("locations_", "", files))
files <- file_move(files, getwd())

library(readxl)

locations <- c(
  "work",
  "school",
  "home",
  "all",
  "other"
)

for (l in locations) {

  res <- list()

  file1 <- paste0("MUestimates_", l, "_1.xlsx")
  file2 <- paste0("MUestimates_", l, "_2.xlsx")

  countries1 <- excel_sheets(file1)
  countries2 <- excel_sheets(file2)

  for (c in countries1) {
    df <- as.matrix(read_xlsx(
      file1,
      col_names = FALSE,
      sheet = c,
      skip = 1
    ))
    rownames(df) <- colnames(df) <- sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
    c <- fix_names(c)
    res[[c]] <- df
  }
  for (c in countries2) {
    df <- as.matrix(read_xlsx(
      file2,
      col_names = FALSE,
      sheet = c
    ))
    rownames(df) <- colnames(df) <- sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
    c <- fix_names(c)
    res[[c]] <- df
  }

  saveRDS(res, paste0(owd, "/inst/extdata/contact_", l, ".rds"))

}

setwd(owd)

library(dplyr)

tfile <- tempfile(fileext = ".xlsx")

source_file <- download.file(
  "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/1_Population/WPP2019_POP_F07_1_POPULATION_BY_AGE_BOTH_SEXES.xlsx",
  tfile)

population_byage <- read_xlsx(tfile, skip = 16) %>%
  filter(Type == "Country/Area") %>%
  filter(`Reference date (as of 1 July)` == "2020") %>%
  rename(Country = `Region, subregion, country or area *`) %>%
  select(Country, matches("^\\d+\\-\\d+$")) %>%
  mutate(across(matches("^\\d+\\-\\d+$"), as.numeric)) %>%
  mutate(across(matches("^\\d+\\-\\d+$"), ~ .x * 1000)) %>%
  as.data.frame() %>%
  add_row(Country = "Liechtenstein",
          "0-4" = 2071, "5-9" = 2071, "10-14" = 2071, "15-19" = 2665,
          "20-24" = 2665, "25-29" = 2665, "30-34" = 2665, "35-39" = 2665,
          "40-44" = 2665, "45-49" = 2665, "50-54" = 2665, "55-59" = 2665,
          "60-64" = 2665, "65-69" = 826, "70-74" = 826, "75-79" = 826,
          "80-84" = 826, "85-89" = 826, "90-94" = 826, "95-99" = 826) %>%
  mutate(Country = fix_names(Country)) %>%
  filter(Country %in% contactdata::list_countries()) %>%
  rowwise() %>%
  mutate("80+" = sum(`80-84`, `85-89`, `90-94`, `95-99`), .keep = "unused")


saveRDS(population_byage, "inst/extdata/population_byage.rds")
