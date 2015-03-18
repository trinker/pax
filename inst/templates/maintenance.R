#==========================
# Run unit tests
#==========================
devtools::test()

#==========================
# build
#==========================
devtools::document()

#==========================
# knit README.md
#==========================
knitr::knit2html("README.Rmd", output ="README.md"); unlink("README.html", recursive = TRUE, force = FALSE)

