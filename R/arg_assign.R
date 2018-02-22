#' Assign Function Arguments for Easy Function Testing
#'
#' Allows for easy assignment of arguments (especially when there are defaults)
#' for testing/code writing purposes.
#' 
#' @param args A vector of arguments, a function, or \code{NULL} is copying from
#' the clipboard.
#' @param \ldots ignored.
#' @export
#' @examples 
#' \dontrun{
#' arg_assign(lm)
#' 
# clipr::write_clip(c('formula, data, subset, weights, na.action, method = "qr",',
#     'model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE,',
#     'contrasts = NULL, offset, ...'
# ))
# arg_assign()
#' }
arg_assign <- function(args = NULL, ...) {
    
    UseMethod('arg_assign')
}

#' @export
#' @rdname arg_assign
#' @method arg_assign default
arg_assign.default <- function(args = NULL, ...) {
    
    if (is.null(args)) {
        args <- clipr::read_clip()
    }
    
    args <- paste(trimws(gsub('c\\([^)]+\\)', '', args)), collapse = ' ')
    args <- gsub('\\s*=\\s*', ' <- ', trimws(strsplit(args, ',')[[1]]))
    
    args <- args[args != '...']
    
    args <- c(
        sort(grep('<-', args, value = TRUE)),
        paste0(sort(grep('<-', args, value = TRUE, invert = TRUE)), ' <- ')
    )
    

    clipr::write_clip( paste(args, collapse = '\n'))
    
    class(args) <- c('arg_assign', 'character')
    args
}

#' Prints an arg_assign Object
#' 
#' Prints an arg_assign object
#' 
#' @param x An arg_assign object. 
#' @param \ldots ignored.
#' @method print arg_assign
#' @export
print.arg_assign <- function(x, ...){
    cat(x, sep = '\n')    
}

#' @export
#' @rdname arg_assign
#' @method arg_assign function
arg_assign.function <- function(args = NULL, ...) {
    
    args <- formals(args)
    args <- args[names(args) != '...']
    
    args <- unname(unlist(Map(function(a, b){
        
        if (is.null(b)) {
            a
        } else {
            paste(a, b, sep =' <- ')  
        }
        
    }, names(args), args)))
    
    args <- c(
        sort(grep('<-', args, value = TRUE)),
        paste0(sort(grep('<-', args, value = TRUE, invert = TRUE)), ' <- ')
    )
    

    clipr::write_clip( paste(args, collapse = '\n'))
    
    class(args) <- c('arg_assign', 'character')
    args    
}
