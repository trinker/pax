#' Package Template
#' 
#' This function creates a package template.  It utiizes a framework with 
#' defaults that expects the user to use \pkg{testthat}, 
#' \href{https://travis-ci.org}{Travis-CI} and \pkg{covr} 
#' (\href{https://coveralls.io/}{coveralls}) to maintain the package.  This is 
#' not a lightweight template, but a deluxe gold level template.
#' 
#' @param path location to create new regular expression library package. The 
#' last component of the path will be used as the package name.
#' @param name A named vector that minimally contains the user's first and last 
#' name (e.g., \code{c(first="Tyler", last="Rinker"))}).  This can be set in the 
#' user's \code{options} in the \file{.Rprofile}; for example: \cr
#' \code{options(name = c(first="Tyler", middle = "W.", last="Rinker"))}.
#' @param email An email address to use for \bold{CRAN} maintainer.  This can be 
#' set in the user's \code{options} in the \file{.Rprofile}; for example: \cr 
#' \code{options(email = "tyler.rinker@@gmail.com")}.
#' @param news logical.  If \code{TRUE} a \file{NEWS} file is generated.
#' @param readme logical.  If \code{TRUE} a \file{README.md} file is generated.
#' @param rstudio logical.  If \code{TRUE} it is assumed 
#' \href{http://www.rstudio.com/}{RStudio} will be used and a \file{xxx.proj} 
#' file is generated.
#' @param gitignore logical.  If \code{TRUE} a \file{.gitignore} file is generated.
#' @param testthat logical.  If \code{TRUE} it is assumed 
#' \href{http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf}{\pkg{testthat}} 
#' will be used and a \file{test} subfolder with appropriate \pkg{testthat} 
#' subdirectories and files will be created.
#' @param travis logical.  If \code{TRUE} it is assumed 
#' \href{https://travis-ci.org}{Travis-CI} will be used and a \file{travis.yml} 
#' file is generated.  For more on managing a \file{travis.yml} with 
#' \pkg{R} see: \url{https://github.com/craigcitro/r-travis}.
#' @param coverage  logical.  If \code{TRUE} it is assumed 
#' \href{https://github.com/jimhester/covr}{\pkg{covr}} will be used.  This 
#' information will be added to the \file{travis.yml}.  
#' @param github.user The user's \href{https://github.com/}{GitHub} user name.  
#' This can be set in the user's \code{options} in the \file{.Rprofile}; for 
#' example:  \cr
#' \code{options(github.user = "trinker")}.
#' @param samples logical.  If \code{TRUE} a sample \file{.R} regular expression
#' file will be placed in the \file{R} directory.  Additionally, if 
#' \code{testthat = TRUE}, a sample \file{.R} unit test will be placed in the 
#' \file{./tests/testthat} directory.
#' @keywords template
#' @export
#' @examples
#' \dontrun{
#' library_template("DELETE_ME")
#' }
gold <- function(path, name = getOption("name"), 
    email = getOption("email"), news = TRUE, readme = TRUE, rstudio = TRUE, 
    gitignore = TRUE, testthat = TRUE, travis = TRUE, coverage = TRUE, 
    github.user = getOption("github.user"), samples = TRUE){

warning("Under Development, Unstable")    
    
    
    ## Quick path by supplying file only
    qpath <- pathfix(path)

    ## Set package, name, email variables
    if (is.null(name) | all(!c("last", "first") %in% names(name))) {
        name <- "FIRST LAST"
        first <- "FIRST"
        last <- "LAST"
    } else {
        first <- name["first"]
        last <- name["last"]
        name <- paste(
            name["first"],
            name["last"], collapse=" "
        )
    }
    if (is.null(email)) {
        email <- "you@somewhere.net" 
    }
    package <- basename(path)
    if (is.null(github.user)) github.user <- "GITHUB_USERNAME"

    ## Create home directory
    if (file.exists(path)) {
        message(paste0("\"", path, "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`library_template` aborted")
        } else {
             unlink(path, recursive = TRUE, force = FALSE)
             suppressWarnings(dir.create(path))
        }
    } else {
        suppressWarnings(dir.create(path))
    }

    ## Generate DESCRIPTION FILE
    cat(sprintf(paste(DESCRIPTION_temp, collapse="\n"), 
        package, 
        first, last, email, name, email,
        paste(R.Version()[c("major", "minor")], collapse="."),
        ifelse(testthat, "\nSuggests: testthat", 
            ""),
        Sys.Date()
    ), file=qpath("DESCRIPTION"))    

    ## Generate R folder
    suppressWarnings(dir.create(qpath("R")))

    ## Generate testthat
    if (testthat) {
        suppressWarnings(dir.create(qpath("tests")))
        suppressWarnings(dir.create(qpath("tests/testthat")))
        cat(sprintf(testthat_temp, package, package), file=qpath("tests/testthat.R"))
        if (samples) {
            file.copy(system.file("templates/test-sample.R", 
                package = "goldpack"), qpath("tests/testthat"))
        }
    }

    ## Generate travis
    if (travis) {
        if (!coverage){
            travis_temp <- travis_temp[-c(12, 14:15)] 
        }
        cat(paste(travis_temp, collapse="\n"), file=qpath("travis.yml"))
    }

    ## Generate rproj
    if (rstudio) {
        template_path <- system.file("templates/template.Rproj", 
            package = "goldpack")
        gitignore_temp[9] <- sprintf(gitignore_temp[9], package)
        file.copy(template_path, path)
        file.rename(qpath("template.rproj"), qpath(sprintf("%s.rproj", package)))
    }

    ## Generate gitignore
    if (gitignore) {
        cat(paste(gitignore_temp, collapse="\n"), file=qpath(".gitignore"))
    }

    ## Generate buildignore
    if (gitignore) {
        cat(paste(buildignore_temp , collapse="\n"), file=qpath(".Rbuildignore"))
    }    
    
    ## Generate readme
    if (readme) {
        readme_path <- system.file("templates/README.Rmd", 
            package = "goldpack")
        readme_temp <- do.call(sprintf, c(list(paste(readLines(readme_path), collapse="\n")), 
            readme_fill(package, github.user, email)))
        cat(readme_temp, file=qpath("README.Rmd"))
 
        ## knit .Rmd to .md      
        cur <- getwd() 
        setwd(path)
        knitr::knit2html(input = "README.Rmd",  output = "README.md")
        setwd(cur)
        unlink(file.path(path, "README.html"), recursive = TRUE, force = FALSE)
    } 

    ## Generate news
    if (news) {
        news_path <- system.file("templates/NEWS", 
            package = "goldpack")
        news_temp <- sprintf(readLines(news_path), package)
        cat(paste(news_temp, collapse="\n"), file=qpath("NEWS"))
    }
    
    ## Add maintenance.R file to inst
    suppressWarnings(dir.create(qpath("inst")))
    file.copy(system.file("templates/maintenance.R", 
        package = "goldpack"), qpath("inst"))

    ## Add .R sample in R directory
    if (samples) {
        file.copy(system.file("templates/sample.R", 
            package = "goldpack"), qpath("R"))
    }    

    message(sprintf("%s Created!", package))
    invisible(TRUE)
}




readme_fill <- function(p, g, e){
    c(rep(p, 1), rep(c(p, g), 3), rep(p, 2), rep(c(g, p), 5), e)
}

pathfix <- function(path){
    function(file) file.path(path, file)
}


DESCRIPTION_temp <- c(
    "Package: %s", 
    "Title: What the Package Does (one line)", 
    "Version: 0.0.1", 
    "Authors@R: c(person(\"%s\", \"%s\", email = \"%s\", role = c(\"aut\", \"cre\")))", 
    "Maintainer: %s <%s>", 
    "Description: What the package does (one paragraph)", 
    "Depends: R (>= %s)%s",
    "Date: %s", 
    "License: What license is it under?", 
    "LazyData: TRUE",
    "Roxygen: list(wrap = FALSE)"
)


testthat_temp <- "library(\"testthat\")\nlibrary(\"%s\")\n\ntest_check(\"%s\")" 

travis_temp <- c(
    "language: c", 
    "", 
    "before_install:", 
    "  - curl -OL http://raw.github.com/craigcitro/r-travis/master/scripts/travis-tool.sh", 
    "  - chmod 755 ./travis-tool.sh", 
    "  - ./travis-tool.sh bootstrap", 
    "install:", 
    "  - sh -e /etc/init.d/xvfb start", 
    "  - ./travis-tool.sh aptget_install r-cran-xml ", 
    "  - ./travis-tool.sh install_github hadley/devtools", 
    "  - ./travis-tool.sh install_deps", 
    "  - ./travis-tool.sh github_package jimhester/covr",         ## if isTRUE(coveralls)
    "script: ./travis-tool.sh run_tests",                
    "after_success:",                                             ## if isTRUE(coveralls)
    "  - Rscript -e 'library(covr);coveralls()'",                 ## if isTRUE(coveralls)
    "notifications:", 
    "  email:", 
    "    on_success: change", 
    "    on_failure: change", 
    "env:", "   global:", 
    "     - R_BUILD_ARGS=\"--resave-data=best\" ", 
    "     - R_CHECK_ARGS=\"--as-cran\"", 
    "     - DISPLAY=:99.0", 
    "     - BOOTSTRAP_LATEX=1"
)

gitignore_temp <- c(
    "# History files",
    ".Rhistory",
    "",
    "# Example code in package build process",
    "*-Ex.R",
    "",
    ".Rprofile",
    ".Rproj.user",
    "%s.Rproj",
    "inst/maintenance.R"
)


buildignore_temp <- c(
    "^.*\\.Rproj$", 
    "^\\.Rproj\\.user$", 
    "^\\.gitignore", 
    "NEWS.md", 
    "FAQ.md", 
    "NEWS.html", 
    "FAQ.html", 
    "^\\.travis\\.yml$", 
    "inst/staticdocs", 
    "inst/maintenance.R", 
    "inst/extra_statdoc", 
    "travis-tool.sh", 
    "inst/web", 
    "contributors.geojson", 
    "inst/build.R", 
    "^.*\\.Rprofile$", 
    "README.Rmd", 
    "README.R",
    "travis.yml"
)
