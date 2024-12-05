test_that("list_countries()", {

  contacts_2017 <- list_countries(data_source = 2017)

  expect_type(contacts_2017, "character")
  expect_length(contacts_2017, 152)
  expect_snapshot(contacts_2017)

  contacts_2020 <- list_countries(data_source = 2020)

  expect_type(contacts_2020, "character")
  expect_length(contacts_2020, 177)
  expect_snapshot(contacts_2020)

})

test_that("age_df_countries() and contact_df_countries() provide data for all list_countries()`", {

  for (s in c(2017, 2020)) {

    contacts <- expect_no_condition(
      contact_df_countries(list_countries(data_source = s), data_source = s)
    )

    popsizes <- expect_no_condition(
      age_df_countries(list_countries(data_source = s))
    )

    expect_identical(nrow(contacts), nrow(popsizes) * 16L)

  }

})
