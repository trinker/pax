#' Wrapper: \code{new_r} + \code{new_test} 
#' 
#' Quickly produce a \href{http://r-pkgs.had.co.nz/man.html}{\pkg{roxygen2} style}
#' \file{.R} and 
#' \href{http://r-pkgs.had.co.nz/tests.html}{\pkg{testthat} style} test 
#' \file{.R} template files from a \code{\link[base]{function}} (output file 
#' will include the function) or a character string.  Wraps \code{new_r} and
#' \code{new_test} function capabilities into one function call.
#' 
#' @param fun A \code{\link[base]{function}} or character string naming the 
#' function.
#' @param r.path Path to directory to generate the function test in.  Default is 
#' to use \code{"R"} for ease of use within RStudio.
#' @param test.path Path to directory to generate the function test in.  Default is 
#' to use \code{"tests/testthat"} for ease of use within RStudio.
#' @param r.file.name By default the file is named the same as \code{fun} + ".R".
#' This can be changed by supplying a file name to \code{file.name}.
#' @param test.file.name By default the file is named the same as: \cr 
#' "text-" + \code{fun} + ".R". \cr
#' This can be changed by supplying a file name to \code{file.name}.
#' @return Generates \file{____.R} and \file{test-____.R} files.
#' @export
#' @family new functions
#' @references \url{http://r-pkgs.had.co.nz/man.html} \cr
#' \url{http://r-pkgs.had.co.nz/tests.html}
#' @examples 
#' dir.create("temp_dir")
#' new_r_test(paste, r.path = "temp_dir", test.path = "temp_dir")
#' new_r_test("myfun", r.path = "temp_dir", test.path = "temp_dir")
#' unlink("temp_dir", TRUE, TRUE)
new_r_test <-
function (fun, r.path = "R", r.file.name = NULL, test.path = "tests/testthat", 
    test.file.name = NULL) {
    
    nm <- as.character(substitute(fun))
    supp <- NULL
    if (!is.function(fun) && is.character(fun)) {
        rox <- roxfun(NULL, nm)
    } else {
        if (!is.function(fun)) 
            stop("`fun` must be a function or character name")
        rox <- roxfun(fun, nm)
        supp <- utils::capture.output(dput(fun))
        loc <- grep("^\\{$", supp)[1]
        if (!is.na(loc)) {
            supp[loc - 1] <- paste0(supp[loc - 1], "{")
            supp <- supp[-loc]
        }
        if (grepl("^<environment: namespace:", utils::tail(supp, 1))) {
            supp <- utils::head(supp, -1)
        }
        supp <- paste(c(paste0("\n", nm, " <-"), supp), collapse = "\n")
    }
    if (is.null(r.file.name)) {
        r.file.name <- paste0(nm, ".R")
    }

    if (is.null(r.path)) {
        cat(rox, supp, "\n\n", file = "")
        return(invisible())
    } else {
        out <- file.path(r.path, r.file.name)
    }    
    
    if (file.exists(out)) {
        message(sprintf("%s already exists:\nDo you want to overwrite?\n", 
            out))
        ans <- utils::menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`new_r` aborted")
        } else {
            unlink(out, TRUE, TRUE)
        }
    }
    cat(rox, supp, "\n\n", file = out)
    if (file.exists(out)) {
        message(sprintf("R file created:\n %s", out))
    } else {
        message(sprintf("The following R file was not found:\n %s", 
            out))
    }
    new_test(nm, path = test.path, file.name = test.file.name)
} 

