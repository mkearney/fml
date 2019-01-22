
#' Create directory
#'
#' Creates a directory
#'
#' @param path Path/name of directory to create
#' @param recursive Logical indicating whether to recursively create new
#'   directory. This defaults to FALSE.
#' @return Silently returns logical indicating success.
#' @export
dir_create <- function(path, recursive = FALSE) {
  dir.create(path, recursive = FALSE)
}

#' Temporary file
#'
#' Create temporary file
#'
#' @param dir Optional name of temporary directory
#' @param ext Optional extension to use
#' @return Name of temporary file
#' @export
file_tmp <- function(dir = NULL, ext = NULL) {
  if (is.null(dir)) {
    dir <- dir_tmp()
  }
  if (is.null(ext)) {
    ext <- ""
  }
  tempfile(tmpdir = dir, fileext = ext)
}

#' Temporary directory
#'
#' Create temporary directory
#'
#' @return Name of temporary directory
#' @export
dir_tmp <- function() {
  x <- tempdir()
  m <- regexpr("//[^/]+$", x)
  regmatches(x, m) <- sub("//", "/", regmatches(x, m))
  x
}

#' Create file
#'
#' Creates a file
#'
#' @param path Path
#' @param recursive Logical indicating whether to recursively create new
#'   file (directories created as necessary). This defaults to FALSE.
#' @return Silently returns logical indicating success.
#' @export
file_create <- function(path, recursive = FALSE) {
  if (recursive && !dir_exists(dir_name(path))) {
    dir_create(dir_name(path), recursive = TRUE)
  }
  file.create(path)
}

#' @inheritParams file_create
#' @rdname file_create
#' @export
file_remove <- function(path) {
  file.remove(path)
}

#' @inheritParams dir_create
#' @param recursive Logical indicating whether to recursively remove files.
#' @rdname dir_create
#' @export
dir_remove <- function(path, recursive = FALSE) {
  unlink(path, recursive = recursive)
}

#' Directory rename
#'
#' Rename directory
#'
#' @param from Name of directory to rename
#' @param to New directory name
#' @return Logical indicating whether success
#' @export
dir_rename <- function(from, to) {
  if (!dir_exists(dir_name(to))) {
    stop("Enclosing 'to' directory does not exist", call. = FALSE)
  }
  l <- file.copy(from, to, overwrite = FALSE, recursive = TRUE)
  if (l) {
    unlink(from, recursive = TRUE)
  }
  invisible(l)
}

#' File rename
#'
#' Rename file
#'
#' @param from File to rename/copy
#' @param to New/copy name
#' @rdname file_create
#' @export
file_rename <- function(from, to) file.rename(from, to)

#' File copy
#'
#' copy file
#'
#' @inheritParams file_rename
#' @rdname file_create
#' @export
file_copy <- function(from, to, overwrite = FALSE, recursive = FALSE) {
  file.copy(from, to, overwrite = overwrite, recursive = recursive)
}


#' File symlink
#'
#' Create symlink to file
#'
#' @inheritParams file_create
#' @export
file_symlink <- function(path) file.symlink(path)
