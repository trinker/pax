NEWS
====

Versioning
----------

Releases will be numbered with the following semantic versioning format:

&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major (and resets the minor 
  and patch)

* New additions without breaking backward compatibility bumps the minor 
  (and resets the patch)

* Bug fixes and misc changes bumps the patch


&lt;b&gt;CHANGES&lt;/b&gt; IN <a href="https://github.com/trinker/pax" target="_blank">pax</a> VERSION 0.0.3
----------------------------------------------------------------

&lt;b&gt;BUG FIXES&lt;/b&gt;

* `pax::pax`  Missed a package name insertion in the README.Rmd file for the 
  Travis-CI link.

* `pax::pax` created a **travis.yml** file, missing the leading dot.  Replaced 
  with **.travis.yml**.

* `pax::pax` had incorrect link to coverage badge as package and GitHub name were
  reversed.

&lt;b&gt;NEW FEATURES&lt;/b&gt;

* `new_r` added to quickly produce a **roxygen2** style .R template file from a 
  `function` (output file will include the function) or a character string.

* `new_test` added to quickly produce a **testthat** style test .R template file 
   from a `function` (output file will include the function) or a character string.

* `new_r_test` added to combine the functionality of `new_r` and `new_test` into 
  one call.


&lt;b&gt;MINOR FEATURES&lt;/b&gt;

* **staticdocs** website is up and running: http://trinker.github.io/pax/  
  Improvements to come.

* `pax::pax`'s `sample` argument is now set to `getOption("samples")`.  The 
  argument can now be set via .Rprofile.

IMPROVEMENTS

* The **README.Rmd** uses *.svg* badges rather than *.png* badges.

&lt;b&gt;CHANGES&lt;/b&gt;


&lt;b&gt;CHANGES&lt;/b&gt; IN <a href="https://github.com/trinker/pax" target="_blank">pax</a> VERSION 0.0.2
----------------------------------------------------------------

`pax` is considered ready for use.


&lt;b&gt;NEW FEATURES&lt;/b&gt;

* `ploc` added to allow the user to (1) set a package directory location in the 
  .Rprofile and (2) supply a package name to create a file path.  Useful with
  `pax` function to supply just a package name and the package is placed in a 
  standard location.


&lt;b&gt;CHANGES&lt;/b&gt; IN <a href="https://github.com/trinker/pax" target="_blank">pax</a> VERSION 0.0.1
----------------------------------------------------------------

* The first CRAN installation of the <a href="https://github.com/trinker/pax" target="_blank">pax</a> package

* Package designed to provide a package templating system that assumes the use 
  of **testthat**, Travis-CI, RStudio, **devtools**, and **covr** (coveralls).