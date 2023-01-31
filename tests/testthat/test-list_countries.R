test_that("list_countries()", {

  contacts <- list_countries()

  expect_type(contacts, "character")
  expect_length(contacts, 152)

})

test_that("age_df_countries() and contact_df_countries() provide data for all list_countries()`", {

  expect_no_condition(
    contacts <- contact_df_countries(list_countries())
  )

  expect_no_condition(
    popsizes <- age_df_countries(list_countries())
  )

  expect_equal(nrow(contacts) / 16L, nrow(popsizes))

})
