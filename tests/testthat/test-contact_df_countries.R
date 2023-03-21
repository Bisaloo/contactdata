test_that("contact_df_countries()", {

  test_countries <- c("Austria", "Belgium")

  res <- contact_df_countries(test_countries)

  expect_s3_class(res, "data.frame")
  expect_identical(dim(res), c(16L * 16L * length(test_countries), 4L))
  expect_named(res, c("country", "age_from", "age_to", "contact"))
  expect_type(res$country, "character")
  expect_type(res$age_from, "character")
  expect_type(res$age_from, "character")
  expect_type(res$contact, "double")

  expect_setequal(
    res$age_from,
    sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
  )
  expect_setequal(
    res$age_to,
    sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
  )

  expect_setequal(
    res$country,
    test_countries
  )

  expect_snapshot(res)

})
