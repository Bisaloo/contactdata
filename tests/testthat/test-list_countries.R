test_that("list_countries()", {

  contacts <- list_countries()

  expect_type(contacts, "character")
  expect_length(contacts, 152)

})

test_that("age_df_countries() and contact_df_countries() provide data for all list_countries()`", {

  expect_silent(
    contacts <- contact_df_countries(list_countries())
  )

  expect_silent(
    popsizes <- age_df_countries(list_countries())
  )

  expect_identical(nrow(contacts), nrow(popsizes))

})
