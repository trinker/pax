#' \pkg{pax} Options Template for \file{.Rprofile}
#' 
#' Generates a script template of blank \pkg{pax} options that can be added to 
#' the \file{.Rprofile}.
#' 
#' @param copy2clip logical.  If \code{TRUE} attempts to copy the output to the 
#' clipboard.
#' @return Returns a script template of blank \pkg{pax} options that can be 
#' added to the \file{.Rprofile} for greater customization (optionally copies 
#' to the clipboard).
#' @keywords options
#' @export
#' @examples
#' pax_options()
pax_options <- function(copy2clip = interactive()) {

    if (copy2clip) {
        writeToClipboard(opts)
    }
    message(opts)
    return(invisible(opts))
}

opts <- paste(c(
    "options(name = c(first=\"\",  last=\"\"))",
    "options(email = \"\")",  
    "options(license = \"\")",
    "options(github.user = \"\")",  
    "options(samples = )",
    "options(tweak = \"\")"
), collapse = "\n")
