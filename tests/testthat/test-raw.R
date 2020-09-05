test_that("All files have the correct lengths", {

  locations <- c(
    "work",
    "school",
    "home",
    "all",
    "other"
  )

  for (l in locations) {
    f <- readRDS(
      system.file("extdata", paste0(l, ".rds"), package = "contactdata")
    )
    expect_length(f, 152)
  }

})
