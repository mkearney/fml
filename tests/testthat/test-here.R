context("test-here")

test_that("here works", {
  expect_true(grepl("file.R", here("file.R")))
  expect_true(grepl("R/file.R", here("R/file.R")))
  expect_true(grepl("testthat/test-here.R",
    here("testthat", "test-here.R")))
  expect_true("test-here.R" %in% file_name(list_files()))
  expect_equal("test", file_name(dir_name(fp("test", "okay"))))
  #expect_true("DESCRIPTION" %in% file_name(list_files("..")))
})
