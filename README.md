
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fml <img src="man/figures/logo.png" width="160px" align="right" />

[![Build
status](https://travis-ci.org/mkearney/fml.svg?branch=master)](https://travis-ci.org/mkearney/fml)
[![CRAN
status](https://www.r-pkg.org/badges/version/fml)](https://cran.r-project.org/package=fml)
[![Coverage
Status](https://codecov.io/gh/mkearney/fml/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/fml?branch=master)

![Downloads](https://cranlogs.r-pkg.org/badges/fml)
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/fml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

**F**ile **M**anagement and **L**ocation tools

## Installation

Install the development version from Github with:

``` r
## install remotes pkg if not already
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## install from github
remotes::install_github("mkearney/fml")
```

## Find or search for files

  - **`find_file()`**: find a file (exact matches)

<!-- end list -->

``` r
## find the rtweet readme
find_file("rtweet", "README.Rmd")
#> [1] "/Users/mwk/R/rtweet/README.Rmd"
```

  - **`search_file()`**: search for files using [wildcard
    expansion](http://pubs.opengroup.org/onlinepubs/9699919799/functions/glob.html)
      - **`*`**: match zero or more characters
      - **`?`**: match a single character
      - **`[`**: begin a character class or range

<!-- end list -->

``` r
## starts with capital letter and doesn't end with md/html
search_file("[A-Z]*[!md|html]")
#> [1] "/Users/mwk/R/fml/DESCRIPTION" "/Users/mwk/R/fml/LICENSE"    
#> [3] "/Users/mwk/R/fml/NAMESPACE"   "/Users/mwk/R/fml/docs/CNAME"

## all .yml files not in docs/
search_file("[!docs]*.yml")
#> [1] "/Users/mwk/R/fml/_pkgdown.yml"     "/Users/mwk/R/fml/docs/pkgdown.yml"

## .yml files that start with a dot
search_file(".*.yml")
#> [1] "/Users/mwk/R/fml/.travis.yml"
```

## Files in projects

  - **`here()`**: smart file paths within project

<!-- end list -->

``` r
## locate file in project
here("R", "fp.R")
#> [1] "/Users/mwk/R/fml/R/fp.R"
```

## List files/directories

  - **`list_files()`**: list **files**

<!-- end list -->

``` r
## list files in directory
list_files(full = FALSE)
#> [1] "_pkgdown.yml" "codecov.yml"  "DESCRIPTION"  "fml.Rproj"   
#> [5] "LICENSE"      "LICENSE.md"   "NAMESPACE"    "README.md"   
#> [9] "README.Rmd"
```

  - **`list_dirs()`**: list **directories**

<!-- end list -->

``` r
## list dirs in directory
list_dirs(full = FALSE)
#> [1] "docs"    "man"     "pkgdown" "R"       "tests"
```

  - **`list_paths()`**: list all **paths**

<!-- end list -->

``` r
## list files AND paths in directory
list_paths(full = FALSE)
#>  [1] "_pkgdown.yml" "codecov.yml"  "DESCRIPTION"  "docs"        
#>  [5] "fml.Rproj"    "LICENSE"      "LICENSE.md"   "man"         
#>  [9] "NAMESPACE"    "pkgdown"      "R"            "README.md"   
#> [13] "README.Rmd"   "tests"
```

## Misc

  - **`fp()`**: construct file path

<!-- end list -->

``` r
## build this/that
fp("this", "that")
#> [1] "this/that"

## pipe style
"this" %FP% "that"
#> [1] "this/that"
```

  - **`pe()`**: path expansion–converts to canonical form

<!-- end list -->

``` r
## build this/that
pe(fp(".", "this", "that"))
#> [1] "./this/that"

## pipe style
pe("~" %FP% "this" %FP% "that")
#> [1] "/Users/mwk/this/that"
```
