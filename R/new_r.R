#' Generate \pkg{roxygen2} Style R Files 
#' 
#' Quickly produce a \href{http://r-pkgs.had.co.nz/man.html}{\pkg{roxygen2} style} 
#' \file{.R} template  file from a \code{\link[base]{function}} (output file will 
#' include the function) or a character string.
#' 
#' @param fun A \code{\link[base]{function}} or character string naming the 
#' function.
#' @param path Path to directory to generate the function test in.  Default is 
#' to use \code{"R"} for ease of use within RStudio.
#' @param file.name By default the file is named the same as \code{fun} + ".R".
#' This can be changed by supplying a file name to \code{file.name}.
#' @return Generates a \file{____.R} file.
#' @export
#' @references \url{http://r-pkgs.had.co.nz/man.html}
#' @examples 
#' dir.create("temp_dir")
#' new_r(paste, "temp_dir")
#' new_r("myfun", "temp_dir")
#' unlink("temp_dir", TRUE, TRUE)
new_r <-
function (fun, path = "R", file.name = NULL) {
    nm <- as.character(substitute(fun))
    supp <- NULL
    if (!is.function(fun) && is.character(fun)) {
        rox <- roxfun(NULL)
    } else {
        if (!is.function(fun)) 
            stop("`fun` must be a function or character name")
        rox <- roxfun(fun)
        supp <- capture.output(dput(fun))
        loc <- grep("^\\{$", supp)[1]
        if (!is.na(loc)) {
            supp[loc - 1] <- paste0(supp[loc - 1], "{")
            supp <- supp[-loc]
        }
        if (grepl("^<environment: namespace:", tail(supp, 1))) {
            supp <- head(supp, -1)
        }
        supp <- paste(c(paste0("\n", nm, " <-"), supp), collapse = "\n")
    }
    if (is.null(file.name)) {
        file.name <- paste0(nm, ".R")
    }

    out <- file.path(path, file.name)
    
    ## ensure file doesn't exist
    if (file.exists(out)) {
        message(sprintf("%s already exists:\nDo you want to overwrite?\n", out))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`new_r` aborted")
        } else {
            unlink(out, TRUE, TRUE)
        }
    }
    
    ## create the file
    cat(rox, supp, "\n\n", file = out)
    
    ## inform the user of the outcome
    if (file.exists(out)) {
        message(sprintf("R file created:\n %s", out))
    } else {
        message(sprintf("The following R file was not found:\n %s", out))
    }
} 

