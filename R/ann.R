#' Add Leading Symbol Annotations
#' 
#' \code{ann} - Add leading symbol annotation (e.g., comment characters).
#' 
#' @param object An object to add commenting to.  If \code{"clipboard"} copies 
#' from the clipboard.
#' @param symbol The symbol(s) to use as the leading characters.
#' @param space How many spaces to put between the symbol and the object lines.
#' @param copy2clip logical,  If \code{TRUE} the output is copied to the clipboard.
#' @param \ldots ignored.
#' @rdname ann
#' @export
#' @examples
#' \dontrun{
#' ann(mtcars)
#' roxann(mtcars)
#' ann(mtcars, symbol = "%%")  # LaTeX
#' 
#' library(clipr)
#' clipr::write_clip(capture.output(new_r))
#' ann()
#' }
ann <- function(object = "clipboard", symbol = "##", space = 1, copy2clip = TRUE, ...) {

    if (length(object) == 1 && is.character(object) && object == "clipboard") {
        y <- as.list(clipr::read_clip())
    } else {
        y <- as.list(utils::capture.output(object))
    }

    spacer <- function(x) paste(symbol, paste(rep(" ", space), collapse = ""), x, sep = "")
    z <- sapply(y, spacer)
    zz <- as.matrix(as.data.frame(z))
    dimnames(zz) <- list(c(rep("", nrow(zz))), c(""))
    if (copy2clip) clipr::write_clip(noquote(zz))
    return(noquote(zz))
}


#' Add Leading Symbol Annotations
#' 
#' \code{roxann} - Add leading roxygen symbol annotation (i.e., \code{#' }).
#' 
#' @rdname ann
#' @export
roxann <- function(object = "clipboard", symbol = "#'", space = 1, copy2clip = TRUE, ...) {
    ann(object = object, space = space, symbol = symbol, copy2clip = copy2clip)
}
