test_that("list_countries()", {

  contacts <- list_countries()

  expect_type(contacts, "character")
  expect_length(contacts, 152)

})
