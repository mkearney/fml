#' File exists
#'
#' Logical test of whether file exists
#'
#' @inheritParams file_create
#' @return Logical value with TRUE indicating it exists
#' @rdname file_create
#' @family exists
#' @export
file_exists <- function(path) {
  file.exists(path)
}

#' Directory exists
#'
#' Logical test of whether directory exists
#'
#' @inheritParams dir_create
#' @return Logical value with TRUE indicating it exists
#' @rdname dir_create
#' @family exists
#' @export
dir_exists <- function(path) {
  dir.exists(path)
}

#' Check for write access
#'
#' @param path Path
#' @return Logical indicating wether write permission exists
#' @family permissions
#' @export
write_access <- function(path) {
  x <- ifelse(file_exists(path), path, dir_name(path))
  i <- file.access(x, 2)
  set_names(i == 0, path)
}

#' Check for read access
#'
#' @param path Path
#' @return Logical indicating wether read permission exists
#' @family permissions
#' @export
read_access <- function(path) {
  x <- ifelse(file_exists(path), path, dir_name(path))
  i <- file.access(x, 4)
  set_names(i == 0, path)
}

#' Symlink exists
#'
#' Check whether a symlink exists
#'
#' @rdname file_create
#' @inheritParams file_create
#' @family exists
#' @export
symlink_exists <- function(path) {
  isTRUE(nzchar(Sys.readlink(path), keepNA = TRUE))
}



set_names <- function (object = nm, nm) {
  names(object) <- nm
  object
}
