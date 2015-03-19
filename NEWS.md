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

* `pax::pax`  Missed a package insertion in the README.Rmd file for the 
  Travis-CI link.

&lt;b&gt;NEW FEATURES&lt;/b&gt;

&lt;b&gt;MINOR FEATURES&lt;/b&gt;

IMPROVEMENTS

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