test_that("list_countries()", {

  contacts_2017 <- list_countries(2017)

  expect_type(contacts_2017, "character")
  expect_length(contacts_2017, 152)

  contacts_2020 <- list_countries(2020)

  expect_type(contacts_2020, "character")
  expect_length(contacts_2020, 177)

})

test_that("age_df_countries() and contact_df_countries() provide data for all list_countries()`", {

  for (s in c(2017, 2020)) {

    expect_no_condition(
      contacts <- contact_df_countries(list_countries(s), data_source = s)
    )

    expect_no_condition(
      popsizes <- age_df_countries(list_countries(s))
    )

    expect_identical(nrow(contacts), nrow(popsizes) * 16L)

  }

})
