#' File path
#'
#' Builds a file path
#'
#' @param ... Names to path
#' @return String of path name
#' @export
fp <- function(...) {
  file.path(...)
}

#' @rdname fp
#' @export
#' @inheritParams fp
`%FP%` <- fp

#' @rdname fp
#' @export
#' @inheritParams fp
path_path <- fp

#' @rdname fp
#' @export
#' @inheritParams fp
file_path <- fp

#' Expand path
#'
#' Expands path to canonical form for the platform
#'
#' @param path Character vector of paths to normalize
#' @return Full/expanded canonical paths
#' @export
path_expand <- function(path = ".") {
  if (identical(path, "")) path <- "."
  normalizePath(path, mustWork = FALSE)
}

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
#' @param path Path
#' @return Name of file
#' @export
file_name <- function(path) basename(path)

#' Package file
#'
#' Construct path to an R package file
#'
#' @param path Path
#' @param package Name of package in which file exists.
#' @return Full path to package
#' @export
package_file <- function(path, package = "base") {
  system.file(path, package = package)
}

