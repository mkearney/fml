
#' Where is here
#'
#' Build a path from an R project root
#'
#' @param ... Parts comprising a single path
#' @return Returns the supplied file name appended onto the root directory
#' @details Looks for a .Rproj or .here file and then appends the supplied file
#' @export
here <- function(...) {
  path <- path_expand(".")
  while (!is_rproj(path) && !is_here(path)) {
    path <- dirname(path)
    if (path %in% c("/", path_expand("~"))) {
      stop("Cannot find project root", call. = FALSE)
    }
  }
  fp(path, ...)
}

is_rproj <- function(path = ".") {
  if (identical(path, "")) path <- "."
  rproj <- list.files(path, pattern = "\\.Rproj$", all.files = TRUE)
  length(rproj) > 0
}
is_here <- function(path = ".") {
  if (identical(path, "")) path <- "."
  here <- list.files(path, pattern = "^\\.here$", all.files = TRUE)
  length(here) > 0
}
