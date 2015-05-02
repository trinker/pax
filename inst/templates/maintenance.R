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
rmarkdown::render("README.Rmd", "all"); unlink("README.html", recursive = TRUE, force = FALSE)


