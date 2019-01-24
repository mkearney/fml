#' Search file
#'
#' Searches for matching file names in common spots and returns full path
#'
#' @param pat Name to match (can include containing directory to narrow search)
#' @param dir Optional, directory from which to start/limit search (only
#'   subfolders will be searched)
#' @return Path if found. NULL if not.
#' @family locate
#' @export
search_file <- function(pat, dir = get_path(".")) {
  UseMethod("search_file")
}

#' @export
search_file.NULL <- function(pat, dir = get_path(".")) {
  character()
}

#' @export
search_file.default <- function(pat, dir = get_path(".")) {
  ## get dirs
  if (is.null(dir) || !is.character(dir)) {
    ## get dir list
    dirs <- good_dirs()
  } else {
    dirs <- list_dirs(dir, recursive = TRUE)
  }

  ## initialize output object
  path <- list()

  ## look for file
  for (i in dirs) {
    path[[length(path) + 1L]] <- spf(pat, i)
  }

  ## return (NULL if not found)
  path <- unlist(path, use.names = FALSE)

  if (length(path) == 0) return(character())
  path
}




spf <- function(pat, dir) {
  spf_ <- function(re) {
    owd <- getwd()
    on.exit(setwd(owd), add = TRUE)
    o <- tryCatch(
      setwd(dir),
      error = function(e) FALSE
    )
    if (identical(o, FALSE)) return(NULL)
    match_files(re)
  }
  spf_(pat)
}

match_files <- function(pat) {
  path <- Sys.glob(pat)
  if (length(path) == 0) return(character())
  fp(path_expand("."), path)
}
