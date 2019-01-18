
rdir <- function() {
  if (!identical("", Sys.getenv("FML_R_DIR"))) {
    return(Sys.getenv("FML_R_DIR"))
  }
  r <- tfse:::r_dir()
  tfse::set_renv(FML_R_DIR = r)
  r
}

#' List directories
#'
#' Returns names of directories located in a given directory. It's similar to
#' list.dirs() only with better defaults and behavior.
#'
#' @param path Directory from which to locate dirs, defaults to current working
#'   directory.
#' @param fulle.names Logical indicating whether to return full paths. Defaults
#'   to TRUE.
#' @param all.names Logical indicating whether to return all (include dot files)
#'   dir names. Defaults to FALSE.
#' @return A character vector of directories
#' @export
list_dirs <- function(path = ".", full.names = TRUE, all.names = FALSE) {
  UseMethod("list_dirs")
}

#' @export
list_dirs.default <- function(path = ".", full.names = TRUE, all.names = FALSE) {
  dirs <- list.dirs(path, recursive = FALSE, full.names = full.names)
  if (!all.names) {
    dirs <- grep("\\.[^/]+$", dirs, invert = TRUE, value = TRUE)
  }
  if (full.names) {
    dirs <- normalizePath(dirs)
  }
  dirs
}

good_dirs <- function() {
  ## (1) current working directory
  wd <- getwd()

  ## (2) plus one
  w1 <- list_dirs()

  ## (3) plus two
  w2 <- unlist(lapply(w1, list_dirs))

  ## (3) minus one
  w0 <- normalizePath("..")

  ## (4) - (11)
  fd <- fml_dirs()

  ## return dir list
  unique(c(wd, w1, w2, w0, fd))
}

fml_dirs <- function() {
  ## check for fml environment var
  d <- Sys.getenv("FML_DIR_PAT")

  ## if it exists, read and return the dir vector
  if (!identical("", d)) {
    return(tfse::read_RDS(d))
  }

  ## R dir
  rd <- rdir()

  ## home directory
  hm <- tfse::home()

  ## home directory + 1
  h1 <- grep("\\bLibrary\\b", list_dirs(hm),
    value = TRUE, invert = TRUE)

  ## home directory + 2
  h2 <- unlist(lapply(h1, list_dirs))

  ## home directory + 3
  h3 <- unlist(lapply(h2, list_dirs))

  ## home directory + 4
  h4 <- unlist(lapply(h3, list_dirs))

  ## combine and filter dups
  d <- unique(c(rd, hm, h1, h2, h3, h4))

  ## save as .rds
  tfse::save_RDS(d, file_path("~", ".fml_dirs"))

  ## set path to .rds file as Renviron var
  tfse::set_renv(FML_DIR_PAT = normalizePath(file_path("~", ".fml_dirs")))

  ## return dirs
  d
}


#' File exists
#'
#' Logical test of whether file exists
#'
#' @param ... Enter parts to file path.
#' @return Logical value
#' @export
file_exists <- function(...) {
  file.exists(file_path(...))
}


fpf <- function(d) function(path) {
  if (file_exists(d, path)) return(file_path(d, path)) else NULL
}


#' File path
#'
#' Builds a file path
#'
#' @param ... Names to path
#' @return String of path name
#' @export
file_path <- function(...) file.path(...)

#' Directory name
#'
#' Returns directory name from a given path
#'
#' @param path String representing path
#' @return Name of containing
#' @export
dir_name <- function(path) dirname(path)

#' File name
#'
#' Returns file name from a given path
#'
#' @param path String representing path
#' @return Name of file
#' @export
file_name <- function(path) basename(path)

#' Find file
#'
#' Looks for file in common spots and returns full path
#'
#' @param ... Name of file (can include containing directory to narrow search)
#' @return Path if found. NULL if not.
#' @export
find_file <- function(...) {

  UseMethod("find_file")
}

#' @export
find_file.default <- function(...) {

  ## capture file
  file <- file_path(...)

  ## get dir list
  dirs <- good_dirs()

  ## look for file
  for (i in dirs) {
    path <- fpf(i)(file)
    if (length(path) > 0) break
  }

  ## return (NULL if not found)
  path
}