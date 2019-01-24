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
  file <- fp(...)

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

rdir <- function() {
  if (!identical("", Sys.getenv("FML_R_DIR"))) {
    return(Sys.getenv("FML_R_DIR"))
  }
  r <- tfse:::r_dir()
  tfse::set_renv(FML_R_DIR = r)
  r
}

auth_paths <- function(...) {
  paths <- fp(...)
  names(read_access(paths)[TRUE])
}

good_dirs <- function() {
  ## (1) current working directory
  wd <- getwd()

  ## (2) plus one
  w1 <- auth_paths(list_dirs())

  ## (3) plus two
  w2 <- unlist(lapply(w1, list_dirs))

  ## (3) minus one
  w0 <- auth_paths(normalizePath(".."))

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
  h1 <- grep("\\bLibrary\\b", auth_paths(list_dirs(hm)),
    value = TRUE, invert = TRUE)

  ## home directory + 2
  h2 <- auth_paths(unlist(lapply(h1, list_dirs)))

  ## home directory + 3
  h3 <- auth_paths(unlist(lapply(h2, list_dirs)))

  ## home directory + 4
  h4 <- auth_paths(unlist(lapply(h3, list_dirs)))

  ## combine and filter dups
  d <- unique(c(rd, hm, h1, h2, h3, h4))

  ## save as .rds
  tfse::save_RDS(d, fp("~", ".fml_dirs"))

  ## set path to .rds file as Renviron var
  tfse::set_renv(FML_DIR_PAT = fp("~", ".fml_dirs"))

  ## return dirs
  d
}

fpf <- function(d) {
  function(path) {
    if (file_exists(fp(d, path))) return(fp(d, path)) else NULL
  }
}
