
#' Where is here
#'
#' Build a path from an R project root
#'
#' @param ... Parts comprising a single path
#' @return Returns the supplied file name appended onto the root directory
#' @details Looks for a .Rproj or .here file and then appends the supplied file
#' @export
here <- function(...) {
  UseMethod("here")
}

#' @export
here.default <- function(...) {
  fp(get_root(), ...)
}


get_root <- function() {
  path <- path_expand(".")
  while (!is_rproj(path) && !is_here(path)) {
    ## if can't find proj/here, then return working directory
    if (path %in% c("/", path_expand("~"))) {
      return(path_expand("."))
    }
    path <- dir_name(path)
  }
  path
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
