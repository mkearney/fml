#' File exists
#'
#' Logical test of whether file exists
#'
#' @param ... Enter parts to file path.
#' @return Logical value
#' @export
file_exists <- function(...) {
  file.exists(file_path(...))
}


#' Directory exists
#'
#' Logical test of whether directory exists
#'
#' @param ... Enter parts to dir path.
#' @return Logical value
#' @export
dir_exists <- function(...) {
  dir.exists(file_path(...))
}


#' File path
#'
#' Builds a file path
#'
#' @param ... Names to path
#' @return String of path name
#' @export
file_path <- function(...) file.path(...)

#' Directory name
#'
#' Returns directory name from a given path
#'
#' @param path String representing path
#' @return Name of containing
#' @export
dir_name <- function(path) dirname(path)

#' File name
#'
#' Returns file name from a given path
#'
#' @param path String representing path
#' @return Name of file
#' @export
file_name <- function(path) basename(path)
