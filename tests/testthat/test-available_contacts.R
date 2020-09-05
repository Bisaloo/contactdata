test_that("available_contacts()", {

  contacts <- available_contacts()

  expect_type(contacts, "character")
  expect_length(contacts, 152)

})
