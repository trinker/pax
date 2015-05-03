pax
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/pax.svg?branch=master)](https://travis-ci.org/trinker/pax)
[![Coverage
Status](https://coveralls.io/repos/trinker/pax/badge.svg?branch=master)](https://coveralls.io/r/trinker/pax?branch=master)
[![DOI](https://zenodo.org/badge/5398/trinker/pax.svg)](http://dx.doi.org/10.5281/zenodo.15891)
<a href="https://img.shields.io/badge/Version-0.1.0-orange.svg"><img src="https://img.shields.io/badge/Version-0.1.0-orange.svg" alt="Version"/></a>
</p>
A Gold Version R Package Template
=================================

<img src="inst/pax_logo/r_pax.png" width="20%", alt="">

Description
===========

[**pax**](http://trinker.github.io/pax_dev) is a package template system
that is NOT designed to be light weight. It is the deluxe, gold version
of a package template. **pax** enforces a fairly narrow package
management philosophy. It expects the user will utilize:

1.  [GitHub](https://github.com) for repository sharing
2.  [RStudio](http://www.rstudio.com/) for GUI
3.  [**testthat**](http://cran.r-project.org/web/packages/testthat/index.html)
    for unit testing
4.  [Coveralls](https://coveralls.io/) +
    [**covr**](https://github.com/jimhester/covr) for code coverage
    rating
5.  [**devtools**](http://cran.r-project.org/web/packages/devtools/index.html)/[**roxygen2**](http://cran.r-project.org/web/packages/roxygen2/index.html)
    for documentation
6.  [**knitr**](http://yihui.name/knitr/) for README management

**pax** has one main function that does one job. `pax` (package and
function named **pax**) creates a package template. It allows the user
to specify construction arguments (locally or [via options in
*.Rprofile*](http://www.statmethods.net/interface/customizing.html)).
Arguments that can be set in the *.Rprofile* include:

<table>
<thead>
<tr class="header">
<th align="left">Argument</th>
<th align="left">Description</th>
<th align="left">Example</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>name</code></td>
<td align="left">The user's name (first &amp; last)</td>
<td align="left"><code>options(name = c(first=&quot;Tyler&quot;,  last=&quot;Rinker&quot;))</code></td>
</tr>
<tr class="even">
<td align="left"><code>email</code></td>
<td align="left">The user's email address</td>
<td align="left"><code>options(email = &quot;tyler.rinker@gmail.com&quot;)</code></td>
</tr>
<tr class="odd">
<td align="left"><code>license</code></td>
<td align="left">The package license</td>
<td align="left"><code>options(license = &quot;GPL-2&quot;)</code></td>
</tr>
<tr class="even">
<td align="left"><code>github.user</code></td>
<td align="left">The user's <a href="https://github.com">GitHub</a> name</td>
<td align="left"><code>options(github.user = &quot;trinker&quot;)</code></td>
</tr>
<tr class="odd">
<td align="left"><code>samples</code></td>
<td align="left">Logical; if <code>TRUE</code>, sample <em>.R</em> &amp; *test-___.R* added | <code>options(samples = FALSE)</code>| | <code>tweak</code> | A function or path/<a href="http://goo.gl/oL7UXO">url</a> to a user specified 'tweaking' function* | <code>options(tweak = &quot;http://goo.gl/oL7UXO&quot;)</code>|</td>
</tr>
</tbody>
</table>

\****Note***: *See `?pax` for more information about the `tweak`
argument; [CLICK
HERE](https://raw.githubusercontent.com/trinker/pax_tweak/master/pax_tweak.R)
for an example.*

These arguments can be quickly added by using the `pax_options`
function. This generates the following blank script that can be added to
the user's *.Rprofile*:

    options(name = c(first = "",  last = ""))
    options(email = "")
    options(license = "")
    options(github.user = "")
    options(samples = )
    options(tweak = "")
    options(dir = "") ## See `?ploc` for details

Template
========

The standard **pax** template looks like:

    |   .gitignore
    |   .Rbuildignore
    |   DESCRIPTION
    |   foo.rproj
    |   NEWS
    |   README.md
    |   README.Rmd
    |   travis.yml
    |   
    +---inst
    |       maintenance.R
    |       
    +---R
    |       foo-package.R
    |       sample.R
    |       utils.R
    |       
    \---tests
        |   testthat.R
        |   
        \---testthat
                test-sample.R


Table of Contents
============

-   [A Gold Version R Package Template](#a-gold-version-r-package-template)
-   [Description](#description)
-   [Template](#template)
-   [Installation](#installation)
-   [Additional Features](#additional-features)
-   [Help](#help)
-   [Additional Package Development Resources](#additional-package-development-resources)
-   [Contact](#contact)

Installation
============


To download the development version of pax:

Download the [zip ball](https://github.com/trinker/pax/zipball/master)
or [tar ball](https://github.com/trinker/pax/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/pax")

Additional Features
===================

<table>
<thead>
<tr class="header">
<th align="left">Function</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left"><code>new_r</code></td>
<td align="left">Makes <strong>roxygen2</strong> style <em>.R</em> template file from a <code>function</code> or character string</td>
</tr>
<tr class="even">
<td align="left"><code>new_test</code></td>
<td align="left">Makes <strong>testthat</strong> style unit test template file from a <code>function</code> or character string</td>
</tr>
<tr class="odd">
<td align="left"><code>new_r_test</code></td>
<td align="left">Makes <strong>roxygen2</strong> style <em>.R</em> and <strong>testthat</strong> style unit test files from a <code>function</code> or character string</td>
</tr>
<tr class="even">
<td align="left"><code>new_data</code></td>
<td align="left">Adds data &amp; appends <strong>roxygen2</strong> style template to package description <em>.R</em> file</td>
</tr>
<tr class="odd">
<td align="left"><code>new_vignette</code></td>
<td align="left">Makes <strong>rmarkdown</strong> style <em>.Rmd</em> vignette template file</td>
</tr>
</tbody>
</table>

In addition to the `pax` templating function, **pax** also has a few
additional tools to generate *.R* and *test-\_\_\_\_.R* scripts that add
a **roxygen2** style *.R* file to the *R* directory as well as adding a
**testthat** style unit test file to *tests/testthat* directory. These
actions can be done separately but it is recommended that they be
combined into one function call: `new_r_test`. This sets a [test-driven
development](http://en.wikipedia.org/wiki/Test-driven_development)
expectation that as a function is created a unit test is used in the
development process.

The `new_data` enables the user to add a data set to the *data*
directory and append the **roxygen2** style *.R* markup template to the
package's description file (*R/\_\_\_\_-package.R*). The `new_vignette`
function provides a means of quickly adding an
[**rmarkdown**](http://rmarkdown.rstudio.com/package_vignette_format.html)
with the appropriate `title` field and `\VignetteIndexEntry` set.

Help
====

-   [Web Page](http://trinker.github.com/pax/)  
-   [HTML Vignette: Introduction to
    pax](http://trinker.github.io/pax/vignettes/introduction.html)  
-   [Package PDF Help
    Manual](https://dl.dropboxusercontent.com/u/61803503/pax.pdf)

Additional Package Development Resources
========================================

-   [Writing R
    Extensions](http://cran.r-project.org/doc/manuals/r-release/R-exts.html)
-   [RStudio Package Development Cheat
    Sheet](http://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf)  
-   [R packages by Hadley Wickham](http://r-pkgs.had.co.nz/)

Contact
=======

You are welcome to: 
* submit suggestions and bug-reports at: <https://github.com/trinker/pax/issues> 
* send a pull request on: <https://github.com/trinker/pax/> 
* compose a friendly e-mail to: <tyler.rinker@gmail.com>

NA
<tyler.rinker@gmail.com>