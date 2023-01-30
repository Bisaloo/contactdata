owd <- setwd(tempdir())

system("svn export https://github.com/kieshaprem/synthetic-contact-matrices/trunk/output/syntheticmatrices")

library(fs)

dir_create(path("syntheticmatrices", "all"))

dir_ls(
  path(getwd(), "syntheticmatrices"),
  recurse = FALSE,
  glob = "*.rdata"
) |>
  file_move(path("syntheticmatrices", "all"))

fichiers <- dir_ls(
  path(getwd(), "syntheticmatrices"),
  recurse = TRUE,
  glob = "*.rdata"
)

new_names_all <- basename(gsub("(\\w+)/contact_([^_]+)(_\\w+)?\\.rdata$", "contact_2020_\\2_\\1.rds", fichiers))

for (i in seq_along(fichiers)) {

  dataset <- load(fichiers[[i]])

  res <- lapply(eval(parse(text = dataset)), function(df) {

    rownames(df) <- colnames(df) <- sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
    return(df)

  })

  names(res) <- countrycode::countrycode(names(res), origin = "iso3c", destination = "cldr.short.en")

  saveRDS(res, paste0(owd, "/inst/extdata/", new_names_all[[i]]))

}
