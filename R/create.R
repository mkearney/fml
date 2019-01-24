
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
  dir.create(path, recursive = recursive)
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
    dir_create(dir_name(path), recursive = recursive)
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
#' @rdname dir_create
#' @export
dir_remove <- function(path) {
  unlink(path, recursive = TRUE)
}

#' Directory rename
#'
#' Rename directory
#'
#' @param from Name of directory to rename/copy
#' @param to New directory
#' @return Logical indicating whether success
#' @rdname dir_create
#' @export
dir_rename <- function(from, to) {
  l <- dir_copy(from, to)
  if (l) {
    unlink(from, recursive = TRUE)
  }
  invisible(l)
}

#' Directory copy
#'
#' Copy directory
#'
#' @inheritParams dir_rename
#' @rdname dir_create
#' @export
dir_copy <- function(from, to) {
  stopifnot(
    is.character(from) && is.character(to),
    length(from) == 1L && length(to) == 1L
  )
  if (!dir_exists(dir_name(to))) {
    stop("Enclosing 'to' directory does not exist", call. = FALSE)
  }
  o <- file.copy(from, to, overwrite = FALSE,
    recursive = !dir_exists(dir_name(to)))
  if (!o) return(o)
  ## empty dir copies as file, so rm file and create new empty dir
  if (!dir_exists(to) && file_exists(to)) {
    file_remove(to)
    dir_create(to)
  }
  o
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
#' @param overwrite Logical indicating whether to overwrite
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
