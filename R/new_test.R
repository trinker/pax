#' Generate \pkg{testthat} Style Test .R Files 
#' 
#' Quickly produce a \href{http://r-pkgs.had.co.nz/tests.html}{\pkg{testthat} style} 
#' test \file{.R} template file from a \code{\link[base]{function}} (output file
#' will include the function) or a character string.
#' 
#' @param fun A \code{\link[base]{function}} or character string naming the 
#' function.
#' @param path Path to directory to generate the function test in.  Default is 
#' to use \code{"tests/testthat"} for ease of use within RStudio.
#' @param file.name By default the file is named the same as: \cr 
#' "text-" + \code{fun} + ".R". \cr
#' This can be changed by supplying a file name to \code{file.name}.
#' @return Generates a \file{test-____.R} file.
#' @export
#' @family new functions
#' @references \url{http://r-pkgs.had.co.nz/tests.html}
#' @examples 
#' dir.create("temp_dir")
#' new_test(paste, "temp_dir")
#' new_test("myfun", "temp_dir")
#' unlink("temp_dir", TRUE, TRUE)
new_test <-
function (fun, path = "tests/testthat", file.name = NULL) {
    
    if (is.function(fun)) {
        nm <- as.character(substitute(fun))
    } else {
        if (!is.character(fun)) stop("`fun` must be a function or character string")
        nm <- fun
    }
    if (is.null(file.name)) {
        file.name <- paste0("test-", nm, ".R")
    }

    out <- file.path(path, file.name)
    
    ## ensure file doesn't exist
    if (file.exists(out)) {
        message(sprintf("%s already exists:\nDo you want to overwrite?\n", out))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`new_test` aborted")
        } else {
            unlink(out, TRUE, TRUE)
        }
    }
    
    ## create the file
    cat(
        sprintf(
            "context(\"Checking %s\")\n\ntest_that(\"%s ...\",{\n\n\n})\n\n", 
            nm, nm
        ), 
        file = out
    )
    
    ## inform the user of the outcome
    if (file.exists(out)) {
        message(sprintf("test file created:\n %s", out))
    } else {
        message(sprintf("The following R file was not found:\n %s", out))
    }
} 
