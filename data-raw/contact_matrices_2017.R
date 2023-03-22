owd <- setwd(tempdir())

fix_names <- function(name) {

  # Convert to common names in English
  name <- stringi::stri_trans_general(name, "Latin-ASCII")
  new_name <- countrycode::countryname(name)

  return(new_name)
}

download.file(
  url = "https://doi.org/10.1371/journal.pcbi.1005697.s002",
  destfile = "all_datasets.zip"
)

files <- unzip("all_datasets.zip", unzip = "internal")

library(fs)

files <- file_move(files, gsub("locations_", "", files, fixed = TRUE))
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
      skip = 1,
      .name_repair = "minimal"
    ))
    rownames(df) <- colnames(df) <- sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
    c <- fix_names(c)
    res[[c]] <- df
  }
  for (c in countries2) {
    df <- as.matrix(read_xlsx(
      file2,
      col_names = FALSE,
      sheet = c,
      .name_repair = "minimal"
    ))
    rownames(df) <- colnames(df) <- sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
    c <- fix_names(c)
    res[[c]] <- df
  }

  saveRDS(res, paste0(owd, "/inst/extdata/contact_2017_", l, "_all.rds"))

}

setwd(owd)
