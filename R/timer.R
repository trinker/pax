#' Crude Timing
#'
#' Crude timings based on \code{\link[base]{Sys.time}}.  \pkg{microbenchmark}
#' provides a more accurate result.
#'
#' @param pos Where to do the assignment. By default, assigns into the global
#' environment.
#' @param envir The \code{\link[base]{environment}} to use.
#' @return \code{tic} makes a reference to the current time in the global
#' environment.  \code{toc} compares elapsed time and returns the difference.
#' @keywords timer
#' @note The \pkg{data.table} package formerly had these functions.
#' @seealso \code{\link[base]{assign}},
#' \code{\link[base]{get}}
#' @export
#' @rdname timer
#' @examples
#' tic();toc()
#'
#' tic()
#' Sys.sleep(3)
#' toc()
tic <- function(pos = 1, envir = as.environment(pos)) {
    gc()
    Sys.time()
    assign(".tic", Sys.time(), pos = pos, envir = envir)
}

#' @rdname timer
#' @export
toc <- function(pos = 1, envir = as.environment(pos)) {
    difftime(Sys.time(), get(".tic", pos = pos, envir = envir))
}
