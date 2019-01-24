context("test-here")

test_that("here works", {
  expect_true(grepl("fml/file.R", here("file.R")))
  expect_true(grepl("fml/R/file.R", here("R/file.R")))
  expect_true(grepl("fml/tests/testthat/test-here.R",
    here("tests", "testthat", "test-here.R")))
  expect_true("test-here.R" %in% file_name(list_files()))
  expect_true("tests" %in% file_name(dir_name(list_dirs(".."))))
  #expect_true("DESCRIPTION" %in% file_name(list_files("..")))
})
