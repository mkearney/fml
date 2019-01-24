
#' Match files
#'
#' List files matching search operator-assisting patterns
#'
#' @param pat File pattern on which to match where * means 0 or more, ? means
#'   once, and \[ indicates the start of a string.
#' @return Matching files
#' @export
match_files <- function(pat) {
  fp(path_expand("."), Sys.glob(pat))
}
