#' List directories
#'
#' Returns names of directories located in a given directory. It's similar to
#' list.dirs() only with better defaults and behaviors.
#'
#' @param path Directory from which to locate dirs–defaults to current working
#'   directory.
#' @param full Logical indicating whether to return full directory names.
#'   Defaults to TRUE.
#' @param all Logical indicating whether to return all (include dot files)
#'   dir names. Defaults to FALSE.
#' @param recursive Logical indicating whether to recursively list files.
#' @param pattern Regular expression pattern on which to filter (return) matching
#'   results. Defaults to NULL, meaning all qualifying dirs will be returned.
#' @param ignore.case Logical indicating whether to ignore case if
#'   \code{pattern} is supplied–defaults to FALSE.
#' @param invert Logical indicating whether to invert (return those that DO NOT
#'   match) regex matching results–defaults to FALSE.
#' @return A character vector of directories
#' @examples
#'
#' ## list files in working directory
#' list_files()
#'
#' @export
list_dirs <- function(path = ".",
                      full = TRUE,
                      all = FALSE,
                      recursive = FALSE,
                      pattern = NULL,
                      ignore.case = FALSE,
                      invert = FALSE) {
  UseMethod("list_dirs")
}

#' @export
list_dirs.default <- function(path = ".",
                              full = TRUE,
                              all = FALSE,
                              recursive = FALSE,
                              pattern = NULL,
                              ignore.case = FALSE,
                              invert = FALSE) {
  dirs <- list.dirs(path, recursive = recursive, full.names = FALSE)
  if (!all) {
    dirs <- grep("^//?\\.[^/.]+$", dirs, invert = TRUE, value = TRUE)
  }
  if (!is.null(pattern)) {
    dirs <- grep(pattern, dirs, invert = invert, value = TRUE,
      ignore.case = ignore.case)
  }
  if (full) {
    dirs <- normalizePath(fp(path, dirs), mustWork = FALSE)
  }
  dirs
}
