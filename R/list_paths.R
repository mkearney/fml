#' List paths
#'
#' Returns names of files and directories located in a given directory. It's
#' similar to list.files() only with better defaults and behaviors.
#'
#' @param path Directory from which to locate paths (files and directories)–
#'   defaults to current working directory.
#' @param full Logical indicating whether to return full paths. Defaults
#'   to TRUE.
#' @param all Logical indicating whether to return all (include dot names)
#'   paths. Defaults to FALSE.
#' @param recursive Logical indicating whether to recursively list paths.
#' @param pattern Regular expression pattern on which to filter (return) matching
#'   results. Defaults to NULL, meaning all paths will be returned.
#' @param ignore.case Logical indicating whether to ignore case if
#'   \code{pattern} is supplied–defaults to FALSE.
#' @param invert Logical indicating whether to invert (return those that DO NOT
#'   match) pattern matching results–defaults to FALSE.
#' @return A character vector of paths.
#' @examples
#'
#' ## list paths in working directory
#' list_paths()
#'
#' @export
list_paths <- function(path = ".",
                       full = TRUE,
                       all = FALSE,
                       recursive = FALSE,
                       pattern = NULL,
                       ignore.case = FALSE,
                       invert = FALSE) {
  UseMethod("list_paths")
}

#' @export
list_paths.default <- function(path = ".",
                               full = TRUE,
                               all = FALSE,
                               recursive = FALSE,
                               pattern = NULL,
                               ignore.case = FALSE,
                               invert = FALSE) {
  files <- list_files(path, full = full, all = all, recursive = recursive,
    pattern = pattern, ignore.case = ignore.case, invert = invert)
  dirs <- list_dirs(path, full = full, all = all, recursive = recursive,
    pattern = pattern, ignore.case = ignore.case, invert = invert)
  sort(c(files, dirs))
}
