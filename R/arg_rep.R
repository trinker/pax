#' Replicate Function Arguments and Separate with an Equal Sign
#'
#' Allows for easy passing through of arguments from a main function to a helper
#' function.
#' 
#' @param args A vector of arguments, a function, or \code{NULL} is copying from
#' the clipboard.
#' @export
#' @examples 
#' \dontrun{
#' arg_rep(lm)
#' 
#' clipr::write_clip(c('formula, data, subset, weights, na.action, method = "qr",',    
#'     'model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE,',
#'     'contrasts = NULL, offset, ...'
#' ))
#' arg_rep()
#' }
arg_rep <- function(args = NULL, ...) {
    
    UseMethod('arg_rep')
}

#' @export
#' @rdname arg_rep
#' @method arg_rep default
arg_rep.default <- function(args = NULL, ...) {
    
    if (is.null(args)) {
        args <- clipr::read_clip()
    }
    
    args <- paste(trimws(gsub('c\\([^)]+\\)', '', args)), collapse = ' ')
    args <- gsub('\\s*=.+$', '', trimws(strsplit(args, ',')[[1]]))
    
    args <- paste(gsub('\\.{3} = \\.{3}', '...', paste(args, args, sep = ' = ')), collapse = ', ')
    
    clipr::write_clip(args)
    
    args
}

#' @export
#' @rdname arg_rep
#' @method arg_rep function
arg_rep.function <- function(args = NULL, ...) {
    
    args <- names(formals(args))
    args <- paste(gsub('\\.{3} = \\.{3}', '...', paste(args, args, sep = ' = ')), collapse = ', ')
    
    clipr::write_clip(args)
    
    args
}
