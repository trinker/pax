#' Package File Path Location
#' 
#' A wrapper for \code{file.path} that allows the user to (1) set a 
#' package directory location and (2) supply a package name and a file 
#' path is constructed.  This is the inverse of \code{\link[base]{basename}} +
#' \code{\link[base]{dirname}}.
#' 
#' @param base The base name (package name).
#' @param dir The location to place \code{base}.  This can be 
#' set in the user's \code{options} in the \file{.Rprofile}; for example:  \cr 
#' \code{options(dir = file.path(Sys.getenv("USERPROFILE"), "GitHub"))}.  
#' @return Returns a concatenated file path using \code{dir} and \code{base}.
#' @export
#' @seealso \code{\link[base]{file.path}},
#' \code{\link[base]{basename}},
#' \code{\link[base]{dirname}}
#' @examples
#' \dontrun{
#' options(dir = file.path(Sys.getenv("USERPROFILE"), "Desktop"))
#' pax(ploc("DELETE_ME"))
#' }
ploc <- function(base, dir = getOption("dir")){

    file.path(dir, base)

}
