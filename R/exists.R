#' File exists
#'
#' Logical test of whether file exists
#'
#' @param path Path
#' @return Logical value with TRUE indicating it exists
#' @export
file_exists <- function(path) {
  file.exists(path)
}

#' Directory exists
#'
#' Logical test of whether directory exists
#'
#' @param path Path
#' @return Logical value with TRUE indicating it exists
#' @export
dir_exists <- function(path) {
  dir.exists(path)
}

#' Check for write access
#'
#' @param path Path
#' @return Logical indicating wether write permission exists
#' @export
write_access <- function(path) {
  x <- ifelse(file_exists(path), path, dir_name(path))
  i <- file.access(x, 2)
  setNames(i == 0, path)
}

#' Check for read access
#'
#' @param path Path
#' @return Logical indicating wether read permission exists
#' @export
read_access <- function(path) {
  x <- ifelse(file_exists(path), path, dir_name(path))
  i <- file.access(x, 4)
  setNames(i == 0, path)
}

#' Symlink exists
#'
#' Check whether a symlink exists
#'
#' @rdname file_create
#' @export
symlink_exists <- function(path) {
  isTRUE(nzchar(Sys.readlink(path), keepNA = TRUE))
}
