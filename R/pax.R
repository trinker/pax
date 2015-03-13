#' Package Template
#' 
#' This function creates a package template.  It utiizes a framework with 
#' defaults that expects the user to use \pkg{testthat}, 
#' \href{https://travis-ci.org}{Travis-CI} and \pkg{covr} 
#' (\href{https://coveralls.io/}{coveralls}) to maintain the package.  This is 
#' not a lightweight template, but a deluxe pax level template.
#' 
#' @param path location to create new regular expression library package. The 
#' last component of the path will be used as the package name.
#' @param name A named vector that minimally contains the user's first and last 
#' name (e.g., \code{c(first="Tyler", last="Rinker"))}).  This can be set in the 
#' user's \code{options} in the \file{.Rprofile}; for example:      \cr
#' \code{options(name = c(first="Tyler", middle = "W.", last="Rinker"))}.
#' @param email An email address to use for \bold{CRAN} maintainer.  This can be 
#' set in the user's \code{options} in the \file{.Rprofile}; for example:  \cr 
#' \code{options(email = "tyler.rinker@@gmail.com")}.
#' @param license A license to use in the \file{DESCRIPTION} file (e.g., 
#' "GPL-2", "MIT"). This can be set in the user's \code{options} in the 
#' \file{.Rprofile}; for example:    \cr 
#' \code{options(license = "GPL-2")}.
#' @param open logical.  If \code{TRUE} the project will be opened in RStudio.  
#' The default is to test if \code{new_report} is being used in the global 
#' environment, if it is then the project directory will be opened.  
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
#' \pkg{R} see:      \url{https://github.com/craigcitro/r-travis}.
#' @param coverage  logical.  If \code{TRUE} it is assumed 
#' \href{https://github.com/jimhester/covr}{\pkg{covr}} will be used.  This 
#' information will be added to the \file{travis.yml}.  
#' @param github.user The user's \href{https://github.com/}{GitHub} user name.  
#' This can be set in the user's \code{options} in the \file{.Rprofile}; for 
#' example:       \cr
#' \code{options(github.user = "trinker")}.
#' @param samples logical.  If \code{TRUE} a sample \file{.R} regular expression
#' file will be placed in the \file{R} directory.  Additionally, if 
#' \code{testthat = TRUE}, a sample \file{.R} unit test will be placed in the 
#' \file{./tests/testthat} directory.
#' @param tweak Additional user supplied function that can be sourced at the end 
#' of the package creation.  The folowing parameters are passed to your function 
#' automatically: (1) the package's name, (2) \code{qpath} (a function that binds 
#' together path pieces; the starting piece is suppied by the \code{path} argument,
#' (3) \code{name} (vector of 2:      first and last), (4) your \code{email}, (5)
#' \code{path}, code{and (6) github.user}.  This can be argument can be set in 
#' the user's \code{options} in the \file{.Rprofile}; for example:      \cr 
#' \code{options(tweak = "C:/Users/Tyler/Copy/Public Scripts/augpax.R")}. 
#' This argument can be a path to or \href{http://goo.gl/z7aN3P}{url} to a user 
#' specified 'tweaking' function.  The user can also pass the function directy 
#' to \code{tweak}.
#' @param \ldots Other arguments passed to the user supplied \code{tweak} 
#' function.
#' @keywords template
#' @export
#' @examples
#' \dontrun{
#' library_template("DELETE_ME")
#' }
pax <- function(path, name = getOption("name"),  email = getOption("email"), 
    license = getOption("license"), open = is.global(2), news = TRUE, 
    readme = TRUE, rstudio = TRUE, gitignore = TRUE, testthat = TRUE, 
    travis = TRUE, coverage = TRUE, github.user = getOption("github.user"), 
    samples = TRUE, tweak = getOption("tweak"), ...){ 
    
    
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

    if (is.null(license)) license <- "What license is it under?"
    
    ## Create home directory
    message(sprintf("-> Creating:..........  %s root directory", package))
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
    
    message("  -> Adding:............  DESCRIPTION")
    message(sprintf("    -Email used:.......... %s", email))
    message(sprintf("    -Name used:........... %s", paste(head(name, 1), tail(name, 1)))) 
    message(sprintf("    -License used:.......... %s", license))    
    cat(sprintf(paste(DESCRIPTION_temp, collapse="\n"), 
        package, 
        first, last, email, name, email,
        paste(R.Version()[c("major", "minor")], collapse="."),
        ifelse(testthat, "\nSuggests: testthat", 
            ""),
        Sys.Date(),
        license
    ), file=qpath("DESCRIPTION"))    

    ## Generate R folder
    message("  -> Creating:..........  R directory")        
    suppressWarnings(dir.create(qpath("R")))

    ## Add utils.R to R folder
    message("    -> Adding:............  utils.R")    
    cat("", file = qpath("R/utils.R"))
    
    ## Add .R sample in R directory
    if (samples) {
        message("    -> Adding:............  sample.R")         
        file.copy(system.file("templates/sample.R", 
            package = "pax"), qpath("R"))
    }  
    
    ## Generate testthat      
    if (testthat) {
        message("  -> Creating:..........  tests")   
        suppressWarnings(dir.create(qpath("tests")))
        
        message("    -> Creating:..........  testthat")           
        suppressWarnings(dir.create(qpath("tests/testthat")))
        if (samples) {
            message("      -> Adding:............  test-sample.R file") 
            file.copy(system.file("templates/test-sample.R", 
                package = "pax"), qpath("tests/testthat"))
        }
        
        message("    -> Adding:............  testthat.R file") 
        cat(sprintf(testthat_temp, package, package), file=qpath("tests/testthat.R"))
        
    }

    ## Generate travis
    if (travis) {
        if (!coverage){
            travis_temp <- travis_temp[-c(12, 14:15)] 
        }
        message("  -> Adding:............  travis.yml") 
        cat(paste(travis_temp, collapse="\n"), file=qpath("travis.yml"))
    }

    ## Generate rproj
    if (rstudio) {
        template_path <- system.file("templates/template.Rproj", 
            package = "pax")
        gitignore_temp[9] <- sprintf(gitignore_temp[9], package)
        message(sprintf("  -> Adding:............  %s.rproj", package))         
        file.copy(template_path, path)
        file.rename(qpath("template.rproj"), qpath(sprintf("%s.rproj", package)))
    }

    ## Generate gitignore
    if (gitignore) {
        message("  -> Adding:............  .gitignore")      
        cat(paste(gitignore_temp, collapse="\n"), file=qpath(".gitignore"))
    }

    ## Generate buildignore
    message("  -> Adding:............  .Rbuildignore") 
    cat(paste(buildignore_temp , collapse="\n"), file=qpath(".Rbuildignore"))

    ## Generate news
    if (news) {
        news_path <- system.file("templates/NEWS", 
            package = "pax")
        news_temp <- sprintf(readLines(news_path), package)
        message("  -> Adding:............  NEWS")         
        cat(paste(news_temp, collapse="\n"), file=qpath("NEWS"))
    }
    
    ## Add maintenance.R file to inst
    message("  -> Creating:..........  inst")         
    suppressWarnings(dir.create(qpath("inst")))
        
    message("    -> Adding:............  maintenance.R")         
    file.copy(system.file("templates/maintenance.R", 
        package = "pax"), qpath("inst"))
     
    ## Generate readme
    if (readme) {
        message("  -> Adding:............  README.Rmd")       
        readme_path <- system.file("templates/README.Rmd", 
            package = "pax")
        readme_temp <- do.call(sprintf, c(list(paste(readLines(readme_path), collapse="\n")), 
            readme_fill(package, github.user, email)))
        cat(readme_temp, file=qpath("README.Rmd"))
 
        ## knit .Rmd to .md      
        cur <- getwd() 
        on.exit(setwd(cur))
        setwd(path)
        message("    -> Knitting:..........  README.md file")         
        knitr::knit2html(input = "README.Rmd",  output = "README.md")
        setwd(cur)
        unlink(file.path(path, "README.html"), recursive = TRUE, force = FALSE)
    } 

    if (file.exists(path)){
        ret <- TRUE
        message(sprintf("\n%s build completed!\n", package))
    } else {
        ret <- FALSE        
    }
    
    ## Run an additional script that acts on the output directory
    if (!is.null(tweak)) {

        message(sprintf("Attempting to tweak %s...", package))
        if(!is.function(tweak)){
            if (grepl("(http[^ ]*)|(ftp[^ ]*)|(www\\.[^ ]*)", tweak)){
                myfun <- try(source(curl::curl(tweak))[["value"]])
                if (!is.function(myfun)) {
                    myfun <- try(source(tweak)[["value"]])
                }
            } else {
                myfun <- try(source(tweak)[["value"]])
            }
            if (!is.function(myfun)) {
                warning("`tweak` file errored")
            }
        } else {
            myfun <- tweak
        }
        myfun(package = package, name = name, qpath = qpath, path = path, 
            github.user = github.user, ...)
    }
    if (open) {
        open_project(qpath(paste0(package, ".Rproj")), package)
    }
    
    invisible(ret)
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
    "License: %s", 
    "LazyData: TRUE",
    "Roxygen: list(wrap = FALSE)"
)


testthat_temp <- "library(\"testthat\")\nlibrary(\"%s\")\n\ntest_check(\"%s\")" 

travis_temp <- c(
    "language:      c", 
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
    "script:      ./travis-tool.sh run_tests",                
    "after_success:",                                             ## if isTRUE(coveralls)
    "  - Rscript -e 'library(covr);coveralls()'",                 ## if isTRUE(coveralls)
    "notifications:", 
    "  email:", 
    "    on_success:      change", 
    "    on_failure:      change", 
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
    "travis-tool.sh", 
    "inst/web", 
    "contributors.geojson", 
    "inst/build.R", 
    "^.*\\.Rprofile$", 
    "README.Rmd", 
    "README.R",
    "travis.yml"
)
