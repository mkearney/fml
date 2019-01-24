#' List files
#'
#' Returns names of files located in a given directory. It's similar to
#' list.files() only with better defaults and behaviors.
#'
#' @param path Directory from which to locate dirs–defaults to current working
#'   directory.
#' @param full Logical indicating whether to return full paths. Defaults
#'   to TRUE.
#' @param all Logical indicating whether to return all (include dot files)
#'   file names. Defaults to FALSE.
#' @param recursive Logical indicating whether to recursively list files.
#' @param pattern Regular expression pattern on which to filter (return) matching
#'   results. Defaults to NULL, meaning all qualifying files will be returned.
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
list_files <- function(path = ".",
                       full = TRUE,
                       all = FALSE,
                       recursive = FALSE,
                       pattern = NULL,
                       ignore.case = FALSE,
                       invert = FALSE) {
  UseMethod("list_files")
}

#' @export
list_files.default <- function(path = ".",
                               full = TRUE,
                               all = FALSE,
                               recursive = FALSE,
                               pattern = NULL,
                               ignore.case = FALSE,
                               invert = FALSE) {
  files <- list.files(
    path, pattern = NULL, all.files = all,
    full.names = FALSE, recursive = recursive,
    include.dirs = FALSE, no.. = FALSE
  )
  dirs <- list_dirs(path, full = FALSE, all = all)
  files <- files[!files %in% dirs]
  if (!is.null(pattern)) {
    files <- grep(pattern, files, ignore.case = ignore.case,
      invert = invert, value = TRUE)
  }
  if (full) {
    path <- path_expand(path)
    files <- normalizePath(fp(path, files), mustWork = FALSE)
  }
  files
}

