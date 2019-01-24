#' Search file
#'
#' Searches for matching file names in common spots and returns full path
#'
#' @param ...Name to match (can include containing directory to narrow search)
#' @return Path if found. NULL if not.
#' @export
search_file <- function(...) {
  UseMethod("search_file")
}

#' @export
search_file.default <- function(...) {
  ## capture file
  file <- fp(...)

  ## get dir list
  dirs <- good_dirs()

  ## initialize output object
  path <- list()

  ## look for file
  for (i in dirs) {
    path[[length(path) + 1L]] <- spf(i)(file)
  }

  ## return (NULL if not found)
  unlist(path, use.names = FALSE)
}




spf <- function(d) {
  function(re) {
    owd <- getwd()
    on.exit(setwd(owd), add = TRUE)
    setwd(d)
    if (any_match_files(re)) return(match_files(re)) else NULL
  }
}


any_match_files <- function(x) length(match_files(x)) > 0
