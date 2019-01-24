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

  tmp <- file_tmp()
  file_create(tmp)
  expect_true(
    file_exists(tmp)
  )
  file_copy(tmp, "asdfasdf")
  expect_true(
    file_exists("asdfasdf")
  )
  expect_true(
    file_symlink(tmp, "ssss")
  )
  expect_true(
    symlink_exists("ssss")
  )
  expect_true(
    file_exists("asdfasdf")
  )
  file_remove(tmp)
  file_remove("ssss")
  file_remove("asdfasdf")
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

  tmp <- dir_tmp()
  expect_true(
    dir_exists(tmp)
  )
  dir_remove(tmp)
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


test_that("file_info works", {
  d <- file_info(list_paths())
  expect_true(
    is.data.frame(d)
  )
  expect_named(
    d
  )
  expect_true(
    all(c("path", "size", "isdir", "mtime") %in% names(d))
  )
})


test_that("search_file works", {
  expect_true(
    length(search_file("DESCRIPTION")) == 0
  )
  tmp <- dir_tmp()
  dir_create(fp(tmp, "this/that/the/other"), recursive = TRUE)
  on.exit(dir_remove(tmp), add = TRUE)
  file_create(fp(tmp, "this", "DESCRIPTION"))
  expect_true(
    length(search_file("DESCRIPTION", dir = tmp)) == 1
  )
  file_create(fp(tmp, "this/that", "DESCRIPTION"))
  expect_true(
    length(search_file("DESCRIPTION", dir = tmp)) == 2
  )
  file_create(fp(tmp, "this/that/the", "DESCRIPTION"))
  expect_true(
    length(search_file("DESCRIPTION", dir = tmp)) == 3
  )
  file_create(fp(tmp, "this/that/the/other", "DESCRIPTION"))
  expect_true(
    length(search_file("DESCRIPTION", dir = tmp)) == 4
  )
})
