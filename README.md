
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fml

[![Build
status](https://travis-ci.org/mkearney/fml.svg?branch=master)](https://travis-ci.org/mkearney/fml)
[![CRAN
status](https://www.r-pkg.org/badges/version/fml)](https://cran.r-project.org/package=fml)
[![Coverage
Status](https://codecov.io/gh/mkearney/fml/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/fml?branch=master)

![Downloads](https://cranlogs.r-pkg.org/badges/fml)
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/fml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

**F**ile **M**anagement and **L**ocator tools

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

  - **`find_file()`**: find a file

<!-- end list -->

``` r
## find the rtweet readme
fml::find_file("rtweet", "README.Rmd")
#> [1] "/Users/kearneymw/R/rtweet/README.Rmd"
```

  - **`here()`**: smart file paths within project

<!-- end list -->

``` r
## locate file in project
fml::here("R", "fp.R")
#> [1] "/Users/kearneymw/R/fml/R/fp.R"
```

  - **`list_files()`**: list onlyl **files** in a given directory

<!-- end list -->

``` r
## list files in directory
fml::list_files()
#> [1] "/Users/kearneymw/R/fml/_pkgdown.yml"
#> [2] "/Users/kearneymw/R/fml/codecov.yml" 
#> [3] "/Users/kearneymw/R/fml/DESCRIPTION" 
#> [4] "/Users/kearneymw/R/fml/fml.Rproj"   
#> [5] "/Users/kearneymw/R/fml/LICENSE"     
#> [6] "/Users/kearneymw/R/fml/LICENSE.md"  
#> [7] "/Users/kearneymw/R/fml/NAMESPACE"   
#> [8] "/Users/kearneymw/R/fml/README.md"   
#> [9] "/Users/kearneymw/R/fml/README.Rmd"
```

  - **`list_dirs()`**: list only **directories** in a given directory

<!-- end list -->

``` r
## list dirs in directory
fml::list_dirs()
#> [1] "/Users/kearneymw/R/fml/docs"    "/Users/kearneymw/R/fml/man"    
#> [3] "/Users/kearneymw/R/fml/pkgdown" "/Users/kearneymw/R/fml/R"      
#> [5] "/Users/kearneymw/R/fml/tests"
```

  - **`list_paths()`**: list all **paths** in a given directory

<!-- end list -->

``` r
## list paths in directory
fml::list_paths()
#>  [1] "/Users/kearneymw/R/fml/_pkgdown.yml"
#>  [2] "/Users/kearneymw/R/fml/codecov.yml" 
#>  [3] "/Users/kearneymw/R/fml/DESCRIPTION" 
#>  [4] "/Users/kearneymw/R/fml/docs"        
#>  [5] "/Users/kearneymw/R/fml/fml.Rproj"   
#>  [6] "/Users/kearneymw/R/fml/LICENSE"     
#>  [7] "/Users/kearneymw/R/fml/LICENSE.md"  
#>  [8] "/Users/kearneymw/R/fml/man"         
#>  [9] "/Users/kearneymw/R/fml/NAMESPACE"   
#> [10] "/Users/kearneymw/R/fml/pkgdown"     
#> [11] "/Users/kearneymw/R/fml/R"           
#> [12] "/Users/kearneymw/R/fml/README.md"   
#> [13] "/Users/kearneymw/R/fml/README.Rmd"  
#> [14] "/Users/kearneymw/R/fml/tests"
```
