context("test-here")

test_that("here works", {
  expect_true(grepl("file.R", here("file.R")))
  expect_true(grepl("R/file.R", here("R/file.R")))
  expect_true(grepl("testthat/test-here.R",
    here("testthat", "test-here.R")))
  expect_true("test-here.R" %in% file_name(list_files()))
  expect_equal("test", file_name(dir_name(fp("test", "okay"))))
  #expect_true("DESCRIPTION" %in% file_name(list_files("..")))

  expect_true(!file_exists("test.txt"))
  file_create("test.txt")
  expect_true(file_exists("test.txt"))
  file_remove("test.txt")
  expect_true(!file_exists("test.txt"))

  expect_true(!dir_exists("tttt"))
  dir_create("tttt")
  expect_true(dir_exists("tttt"))
  dir_remove("tttt")
  expect_true(!dir_exists("tttt"))

})




test_that("files works", {

  expect_true(!file_exists("test.txt"))
  file_create("test.txt")
  expect_true(file_exists("test.txt"))
  file_remove("test.txt")
  expect_true(!file_exists("test.txt"))

  file_create("tttt")
  file_rename("tttt", "uuuu")
  expect_true(file_exists("uuuu"))
  expect_true(!file_exists("tttt"))
  file_remove("uuuu")
})




test_that("dirs works", {

  expect_true(!dir_exists("tttt"))
  dir_create("tttt")
  expect_true(dir_exists("tttt"))
  dir_remove("tttt")
  expect_true(!dir_exists("tttt"))

  dir_create("tttt")
  dir_rename("tttt", "uuuu")
  dir_copy("tttt", "uuuu")
  expect_true(dir_exists("uuuu"))
  expect_true(!dir_exists("tttt"))
  dir_remove("uuuu")

})



test_that("find_file works", {

  file_create(".Renviron")
  expect_true(
    file_exists(".Renviron")
  )
  Sys.setenv(FML_DIR_PAT = "")

  expect_true(
    dir_create("tttt")
  )
  expect_true(
    file_create("tttt/ttttt/test.txt", recursive = TRUE)
  )
  expect_true(
    grepl("tttt/ttttt/test.txt", find_file("ttttt/test.txt"))
  )
  expect_true(
    grepl("tttt/ttttt/test.txt", find_file("test.txt"))
  )
  expect_true(
    grepl("tttt/ttttt/test.txt", find_file("tttt/ttttt/test.txt"))
  )
  dir_remove("tttt")
  expect_true(
    !dir_exists("tttt")
  )

  expect_true(
    !identical("", Sys.getenv("FML_DIR_PAT"))
  )

  file_remove(
    Sys.getenv("FML_DIR_PAT")
  )

  expect_true(
    !file_exists(Sys.getenv("FML_DIR_PAT"))
  )

  file_remove(".Renviron")

  expect_true(
    !file_exists(".Renviron")
  )
})
