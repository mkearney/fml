
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fml

[![Build
status](https://travis-ci.org/mkearney/fml.svg?branch=master)](https://travis-ci.org/mkearney/fml)
[![CRAN
status](https://www.r-pkg.org/badges/version/fml)](https://cran.r-project.org/package=fml)
[![Coverage
Status](https://codecov.io/gh/mkearney/fml/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/fml?branch=master)

<!--#![Downloads](https://cranlogs.r-pkg.org/badges/fml)
#![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/fml)-->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

**F**ile **M**anagement **L**ocator package

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

## Use

Find a file

``` r
## find the rtweet readme
fml::find_file("rtweet", "README.Rmd")
#> [1] "/Users/mwk/R/rtweet/README.Rmd"

## locate file in project
fml::here("R", "fp.R")
#> [1] "/Users/mwk/R/fml/R/fp.R"
```
