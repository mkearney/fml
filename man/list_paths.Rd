% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/list_paths.R
\name{list_paths}
\alias{list_paths}
\title{List paths}
\usage{
list_paths(path = ".", full = TRUE, all = FALSE, recursive = FALSE,
  pattern = NULL, ignore.case = FALSE, invert = FALSE)
}
\arguments{
\item{path}{Directory from which to locate paths (files and directories)–
defaults to current working directory.}

\item{full}{Logical indicating whether to return full paths. Defaults
to TRUE.}

\item{all}{Logical indicating whether to return all (include dot names)
paths. Defaults to FALSE.}

\item{recursive}{Logical indicating whether to recursively list paths.}

\item{pattern}{Regular expression pattern on which to filter (return) matching
results. Defaults to NULL, meaning all paths will be returned.}

\item{ignore.case}{Logical indicating whether to ignore case if
\code{pattern} is supplied–defaults to FALSE.}

\item{invert}{Logical indicating whether to invert (return those that DO NOT
match) pattern matching results–defaults to FALSE.}
}
\value{
A character vector of paths.
}
\description{
Returns names of files and directories located in a given directory. It's
similar to list.files() only with better defaults and behaviors.
}
\examples{

## list paths in working directory
list_paths()

}
\seealso{
Other list_paths: \code{\link{list_dirs}},
  \code{\link{list_files}}
}
\concept{list_paths}
