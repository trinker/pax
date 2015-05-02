#========
# BUILD
#========
source("inst/build.R")

#==========================
# Run unit tests
#==========================
devtools::test()

#==========================
# knit README.md
#==========================
rmarkdown::render("README.Rmd", "all"); reports::delete("README.html"); md_toc()

#==========================
# UPDATE NEWS
#==========================
update_news()

#==========================
# UPDATE NEWS
#==========================
update_version("0.1.0")

#========================
#staticdocs dev version
#========================
#packages
# library(devtools); install_github("staticdocs", "hadley")
# install_github("acc.roxygen2", "trinker");install.packages("rstudioapi")
library(highlight);  library(staticdocs); 

#STEP 1: create static doc  
#right now examples are FALSE in the future this will be true
#in the future qdap2 will be the go to source
R_USER <-  switch(Sys.info()[["user"]],
    Tyler = "C:/Users/Tyler",
    trinker = "C:/Users/trinker",
    message("Computer name not found")
)
build_site(pkg=file.path(R_USER, "GitHub", basename(getwd())), launch = FALSE)

#STEP 2: reshape index
path <- "inst/web"
path2 <- file.path(path, "/index.html")
rdme <- file.path(R_USER, "GitHub", basename(getwd()), "inst/extra_statdoc/readme.R")
library(acc.roxygen2); library(qdap);
extras <- NULL #qcv("test_remove", "test_split")
## drops <- qcv()
expand_statdoc(path2, to.icon = extras, readme = rdme)

x <- readLines(path2)
x[grepl("<h2>Authors</h2>", x)] <- paste(c("<h2>Author</h2>" 
    #rep("<h2>Contributor</h2>", 1)
    ),
    c("Tyler W. Rinker"))

cat(paste(x, collapse="\n"), file=path2)


#STEP 3: move to trinker.guthub
library(reports)
file <- file.path(R_USER, "/GitHub/trinker.github.com")
#file.copy("vignettes/sample.html", "inst/web/vignettes")
incoming <- file.path(file, paste0(basename(getwd()), "_dev"))
delete(incoming)
file.copy(path, file, TRUE, TRUE)
file.rename(file.path(file, "web"), incoming)
## delete(path)
#==========================
#staticdocs current version
#==========================
#packages
# library(devtools); install_github("staticdocs", "hadley")
# install_github("acc.roxygen2", "trinker"); install.packages("rstudioapi")
library(highlight);library(staticdocs); 

#STEP 1: create static doc  
#right now examples are FALSE in the future this will be true
#in the future qdap2 will be the go to source
library(highlight);  library(staticdocs); 

#STEP 1: create static doc  
#right now examples are FALSE in the future this will be true
#in the future qdap2 will be the go to source
R_USER <-  switch(Sys.info()[["user"]],
    Tyler = "C:/Users/Tyler",
    trinker = "C:/Users/trinker",
    message("Computer name not found")
)
build_site(pkg=file.path(R_USER, "GitHub", basename(getwd())), launch = FALSE)

#STEP 2: reshape index
path <- "inst/web"
path2 <- file.path(path, "/index.html")
rdme <- file.path(R_USER, "GitHub", basename(getwd()), "inst/extra_statdoc/readme.R")
library(acc.roxygen2); library(qdap);
extras <- qcv("test_remove", "test_split")
## drops <- qcv()
expand_statdoc(path2, to.icon = extras, readme = rdme)

x <- readLines(path2)
x[grepl("<h2>Authors</h2>", x)] <- paste(c("<h2>Author</h2>" 
    #rep("<h2>Contributor</h2>", 1)
    ),
    c("Tyler W. Rinker"))

cat(paste(x, collapse="\n"), file=path2)


#STEP 3: move to trinker.guthub
library(reports)
file <- file.path(R_USER, "/GitHub/trinker.github.com")
# incoming <- file.path(file, basename(getwd()))
delete(incoming)
file.copy(path, file, TRUE, TRUE)
file.rename(file.path(file, "web"), incoming)
## delete(path)

#==========================
# NEWS new version
#==========================
x <- c("BUG FIXES", "NEW FEATURES", "MINOR FEATURES", "IMPROVEMENTS", "CHANGES")
cat(paste(x, collapse = "\n\n"), file="clipboard")




