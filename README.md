pax
=======



[![Build Status](https://travis-ci.org/trinker/pax.png?branch=master)](https://travis-ci.org/trinker/pax)
[![Coverage Status](https://coveralls.io/repos/trinker/pax/badge.png?branch=master)](https://coveralls.io/r/trinker/pax?branch=master)
[![DOI](https://zenodo.org/badge/5398/trinker/pax.svg)](http://dx.doi.org/10.5281/zenodo.15891)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a></p>

## A Gold Version R Package Template


<img src="inst/pax_logo/r_pax.png" width="20%", alt="">  

[**pax**](http://trinker.github.io/pax_dev) is a package template system that is NOT designed to be light weight.  It is the delux, pax version of a package template.  **pax** is not flexible, rather it maintains and enforces a narrow package management philosophy.  It expects the user will utilize:

1.  [GitHub](https://github.com) for repository sharing
2.  [RStudio](http://www.rstudio.com/) for GUI 
3.  [**testthat**](http://cran.r-project.org/web/packages/testthat/index.html) for unit testing
4.  [Coveralls](https://coveralls.io/) + [**covr**](https://github.com/jimhester/covr) for code coverage rating
5.  [**devtools**](http://cran.r-project.org/web/packages/devtools/index.html)/[**roxygen2**](http://cran.r-project.org/web/packages/roxygen2/index.html) for documentation 
6.  [**knitr**](http://yihui.name/knitr/) for README managment

**pax** allows the user to specify argument (locally or via options in .Rprofile)...***UNDER CONSTRUCTION***  


## Installation

To download the development version of pax:

Download the [zip ball](https://github.com/trinker/pax/zipball/master) or [tar ball](https://github.com/trinker/pax/tarball/master), decompress and run `R CMD INSTALL` on it, or use the **pacman** package to install the development version:

```r
if (!require("pacman")) install.packages("pacman")
pacman::p_load_gh("trinker/pax")
```

## Help

- [Web Page](http://trinker.github.com/pax/)     
- [HTML Vignette: Introduction to pax](http://trinker.github.io/pax/vignettes/introduction.html)       
- [Package PDF Help Manual](https://dl.dropboxusercontent.com/u/61803503/pax.pdf)   

## Contact

You are welcome to:
* submit suggestions and bug-reports at: <https://github.com/trinker/pax/issues>
* send a pull request on: <https://github.com/trinker/pax/>
* compose a friendly e-mail to: <tyler.rinker@gmail.com>



