test_that("contact_df_age missing", {

  expect_warning(
    age_df_countries("test"),
    "not included"
  )

  countries <- c("Austria", "Belgium")
  age_df <- age_df_countries(countries)

  expect_s3_class(age_df, "data.frame")
  expect_identical(dim(age_df), c(20L * length(countries), 3L))
  expect_named(age_df, c("country", "age", "population"))
  expect_setequal(age_df$country, countries)

})
