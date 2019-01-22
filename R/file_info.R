


#' File information
#'
#' Returns a data frame of file information
#'
#' @param ... Path names
#' @return A data frame with path, size, isdir, permission, and timestamp variables
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
