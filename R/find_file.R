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
    return(readRDS(d))
  }

  ## home directory
  hm <- .home()

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
  d <- unique(c(hm, h1, h2, h3, h4))

  ## save as .rds
  saveRDS(d, fp("~", ".fml_dirs"))

  ## set path to .rds file as Renviron var
  set_renv(FML_DIR_PAT = fp("~", ".fml_dirs"))

  ## return dirs
  d
}

fpf <- function(d) {
  function(path) {
    if (file_exists(fp(d, path))) return(fp(d, path)) else NULL
  }
}



#' .Renviron file
#'
#' Gets path to .Renviron file
#'
#' @return Returns path to .Renviron file
#' @details Checks local directory first and then checks home directory
#' @export
.Renviron <- function() {
  if (file_exists(".Renviron")) {
    ".Renviron"
  } else {
    path_expand(fp(.home(), ".Renviron"))
  }
}

#' Home directory
#'
#' Gets user's home directory
#'
#' @return Returns system/user's default home directory
#' @details Looks for "HOME" environment variable and/or normalizes the tilde
#'   path
#' @export
.home <- function() {
  if (!identical(Sys.getenv("HOME"), "")) {
    fp(Sys.getenv("HOME"))
  } else {
    path_expand("~")
  }
}


is_named <- function(x) !is.null(names(x))

are_named <- function(x) is_named(x) && !"" %in% names(x)

has_name_ <- function(x, name) isTRUE(name %in% names(x))

define_args <- function(args, ...) {
  dots <- list(...)
  nms <- names(dots)
  for (i in nms) {
    if (!has_name_(args, i)) {
      args[[i]] <- dots[[i]]
    }
  }
  args
}

append_lines <- function(x, ...) {
  args <- define_args(
    c(x, list(...)),
    append = TRUE,
    fill = TRUE
  )
  do.call("cat", args)
}

is_incomplete <- function(x) {
  con <- file(x)
  x <- tryCatch(readLines(con), warning = function(w) return(TRUE))
  close(con)
  ifelse(isTRUE(x), TRUE, FALSE)
}

clean_renv <- function(var) {
  x <- readlines(.Renviron())
  x <- grep(sprintf("^%s=", var), x, invert = TRUE, value = TRUE)
  writeLines(x, .Renviron())
}

check_renv <- function(var = NULL) {
  if (!file.exists(.Renviron())) return(invisible())
  if (is_incomplete(.Renviron())) {
    append_lines("", file = .Renviron())
  }
  if (!is.null(var)) {
    clean_renv(var)
  }
  invisible()
}

set_renv <- function(...) {
  dots <- list(...)
  stopifnot(are_named(dots))
  vars <- names(dots)
  x <- paste0(names(dots), "=", dots)
  x <- paste(x, collapse = "\n")
  for (var in vars) {
    check_renv(var)
  }
  append_lines(x, file = .Renviron())
  readRenviron(.Renviron())
}


readlines <- function(x, ...) {
  dots <- list(...)
  if (!"encoding" %in% names(dots)) {
    dots$encoding <- "UTF-8"
  }
  if (!"skipNul" %in% names(dots)) {
    dots$skipNul <- TRUE
  }
  if (!"warn" %in% names(dots)) {
    dots$warn <- FALSE
  }
  if (is_url(x)) {
    con <- url(x, encoding = dots$encoding)
  }
  else {
    con <- file(x, encoding = dots$encoding)
  }
  on.exit(close(con), add = TRUE)
  dots$con <- con
  do.call(base::readLines, dots, quote = FALSE)
}


is_url <- function(x) {
  is.character(x) && length(x) == 1 && grepl("^http", x)
}
