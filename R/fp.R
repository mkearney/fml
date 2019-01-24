#' File path
#'
#' Builds a file path
#'
#' @param ... Names to path
#' @return Constructed/pasted together path name
#' @export
file_path <- function(...) {
  UseMethod("file_path")
}

#' @export
file_path.default <- function(...) {
  dots <- list(...)
  dots <- dots[lengths(dots) > 0]
  if (length(dots) == 0) return(character())
  do.call(base::file.path, dots, quote = FALSE, envir = environment())
}

#' @rdname file_path
#' @export
#' @param lhs Left hand side
#' @param rhs Right hand side
`%FP%` <- function(lhs = NULL, rhs = NULL) {
  fp(lhs, rhs)
}

#' @rdname file_path
#' @export
#' @inheritParams file_path
fp <- file_path

#' Expand path
#'
#' Expands path to canonical form for the platform
#'
#' @param path Character vector of paths to normalize
#' @return Full/expanded canonical paths
#' @export
path_expand <- function(path = ".") {
  UseMethod("path_expand")
}

#' @export
path_expand.NULL <- function(path = ".") {
  character()
}

#' @export
path_expand.default <- function(path = ".") {
  if (identical(path, "")) path <- "."
  normalizePath(path, mustWork = FALSE)
}

#' @rdname path_expand
#' @export
#' @inheritParams path_expand
pe <- path_expand

#' @rdname path_expand
#' @export
#' @inheritParams path_expand
get_path <- path_expand

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
