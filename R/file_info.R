#' File information
#'
#' Returns a data frame of file information
#'
#' @param ... Path names
#' @return A data frame with path, size, isdir, permission, and timestamp
#'   variables
#' @family file_info
#' @export
file_info <- function(...) {
  UseMethod("file_info")
}

#' @export
file_info.default <- function(...) {
  x <- file.info(...)
  x$path <- row.names(x)
  row.names(x) <- NULL
  if (is.data.frame(x)) {
    class(x) <- c("tbl_data", "tbl_df", "tbl", "data.frame")
  }
  structure(
    x[c("path", "size", "isdir", "mode", "mtime")],
    class = c("tbl_data", "tbl_df", "tbl", "data.frame")
  )
}


#' Directory name
#'
#' Returns directory name from a given path
#'
#' @param path String representing path
#' @return Name of containing
#' @family file_info
#' @export
dir_name <- function(path) dirname(path)

#' File name
#'
#' Returns file name from a given path
#'
#' @param path Path
#' @return Name of file
#' @family file_info
#' @export
file_name <- function(path) basename(path)
