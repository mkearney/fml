


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
  x[c("path", "size", "isdir", "mode", "mtime")]
}


add_perms <- function(x) {
  perms <- list(
    #    execute  read   write
    '1' =  c(TRUE,  FALSE, FALSE),
    '2' =  c(FALSE, FALSE, TRUE),
    '3' =  c(TRUE,  FALSE, TRUE),
    '4' =  c(FALSE, TRUE,  FALSE),
    '5' =  c(TRUE,  TRUE,  FALSE),
    '6' =  c(FALSE, TRUE,  TRUE),
    '7' =  c(TRUE,  TRUE,  TRUE)
  )
  m <- regexpr("\\d(?=\\d{2}$)", x$mode, perl = TRUE)
  user <- regmatches(x$mode, m)
  perms <- perms[match(user, names(perms))]
  perms <- matrix(unlist(perms), ncol = 3, byrow = TRUE)
  colnames(perms) <- c("execute", "read", "write")
  cbind(x, perms)
}
