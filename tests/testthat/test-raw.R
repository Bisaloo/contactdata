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
      system.file("extdata", paste0("contact_2017_", l, "_all.rds"), package = "contactdata")
    )
    expect_length(f, 152)
  }

  settings <- c(
    "all",
    "rural",
    "urban"
  )

  for (l in locations) {
    for (s in c("all", "urban")) {
      f <- readRDS(
        system.file("extdata", paste0("contact_2020_", l, "_", s, ".rds"), package = "contactdata")
      )
      expect_length(f, 177)
    }

    # 3 locations are missing because they don't have rural population (e.g.,
    # Singapore, HK)
    s <- "rural"
    f <- readRDS(
      system.file("extdata", paste0("contact_2020_", l, "_", s, ".rds"), package = "contactdata")
    )
    expect_length(f, 174)
  }

})
