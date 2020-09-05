test_that("contact_matrix()", {

  res <- contact_matrix("Belgium", location = "school")

  expect_type(res, "double")
  expect_identical(dim(res), c(16L, 16L))
  expect_identical(
    rownames(res),
    sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
  )
  expect_identical(
    colnames(res),
    sprintf("%02i_%02i", seq(0, 75, 5), seq(5, 80, 5))
  )

  expect_error(
    contact_matrix(c("Austria", "Belgium")),
    "single country"
  )

  expect_error(
    contact_matrix("missing"),
    "not included"
  )

})
