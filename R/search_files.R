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
  path <- unlist(path, use.names = FALSE)

  if (length(path) == 0) return(NULL)
  path
}




spf <- function(d) {
  function(re) {
    owd <- getwd()
    on.exit(setwd(owd), add = TRUE)
    o <- tryCatch(
      setwd(d),
      error = function(e) FALSE
    )
    if (identical(o, FALSE)) return(NULL)
    match_files(re)
  }
}


any_match_files <- function(x) length(match_files(x)) > 0
