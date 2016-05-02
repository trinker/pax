locate_rstudio <- function() {
    myPaths <- c("rstudio",  "~/.cabal/bin/rstudio", 
        "~/Library/Haskell/bin/rstudio", "C:\\PROGRA~1\\RStudio\\bin\\rstudio.exe",
        "C:\\RStudio\\bin\\rstudio.exe", "/Applications/RStudio.app/Contents/MacOS/RStudio")
    panloc <- Sys.which(myPaths)
    temp <- panloc[panloc != ""]
    if (identical(names(temp), character(0))) {
        ans <- readline("RStudio not installed in one of the typical locations.\n 
            Do you know where RStudio is installed? (y/n) ")
        if (ans == "y") {
                temp <- readline("Enter the (unquoted) path to RStudio: ")
        } else {
            if (ans == "n") {
                stop("RStudio not installed or not found.")
            }
        }
    } 
    short.path <- which.min(unlist(lapply(gregexpr("RStudio", temp), "[[", 1)))
    temp[short.path] 
}

open_project <- function(Rproj.loc, package) {
    action <- paste(locate_rstudio(), Rproj.loc)
    message(sprintf("\nPreparing to open %s!", package))
    try(system(action, wait = FALSE, ignore.stderr = TRUE))
}


roxfun <- function (fun, nm) {

    # check if function is a printing function
    if (grepl("^print\\.", nm)) return(roxprint(fun, nm))

    # check if function is a plotting function
    if (grepl("^plot\\.", nm)) return(roxplot(fun, nm))
    
    ## grab arguments
    pars <- formals(fun)
    if (!is.null(pars)){
        pars <- paste("#' @param", gsub("\\.{3}", "\\\\ldots", names(pars)))
    } 

    ## additional roxygen style markup
    name.desc <- c("#' Title", "#' ", "#' Description", "#' ")
    ending <- c("#' @return", "#' @references", "#' @keywords", 
        "#' @export", "#' @seealso", "#' @examples")

    paste0(c(name.desc, pars, ending), collapse = "\n")

}

roxfun_min <- function (fun, nm) {

    # check if function is a printing function
    if (grepl("^print\\.", nm)) return(roxprint(fun, nm))

    # check if function is a plotting function
    if (grepl("^plot\\.", nm)) return(roxplot(fun, nm))
    
    ## grab arguments
    pars <- formals(fun)
    if (!is.null(pars)){
        pars <- paste("#' @param", gsub("\\.{3}", "\\\\ldots", names(pars)))
    } 

    ## additional roxygen style markup
    name.desc <- c("#' Title", "#' ", "#' Description", "#' ")
    ending <- c("#' @export", "#' @examples")

    paste0(c(name.desc, pars, ending), collapse = "\n")

}

roxprint <- function (fun, nm) {

    ## grab arguments
    pars <- formals(fun)
    if (!is.null(pars)){
        pars <- paste("#' @param", gsub("\\.{3}", "\\\\ldots", names(pars)))
    } 

    ## additional roxygen style markup
    obj <- gsub("^print\\.", "", nm)
    name.desc <- c(sprintf("#' Prints a %s Object", obj), "#' ", 
        sprintf("#' Prints a %s object", obj), "#' ")
    ending <- c(sprintf("#' @method print %s", obj), "#' @export")

    paste0(c(name.desc, pars, ending), collapse = "\n")

}

roxplot <- function (fun, nm) {

    ## grab arguments
    pars <- formals(fun)
    if (!is.null(pars)){
        pars <- paste("#' @param", gsub("\\.{3}", "\\\\ldots", names(pars)))
    } 

    ## additional roxygen style markup
    obj <- gsub("^print\\.", "", nm)
    name.desc <- c(sprintf("#' Plots a %s Object", obj), "#' ", 
        sprintf("#' Plots a %s object", obj), "#' ")
    ending <- c(sprintf("#' @method plot %s", obj), "#' @export")

    paste0(c(name.desc, pars, ending), collapse = "\n")

}

write_clip  <- function(x) {
    ## The code for this helper function comes from the oveRflow package.  
    ## # https://raw.github.com/sebastian-c/oveRflow/master/R/writeClip.R
    ## This is code I submitted but was modified by the package maintainers.
    
    OS <- Sys.info()["sysname"]
    
    if(!(OS %in% c("Darwin", "Windows", "Linux"))) {
        stop("Copying to clipboard not supported on your OS")
    }
    
    if (OS != "Windows") {
        writeClipboard <- NULL
    } 
    
    switch(OS, 
        "Darwin"={j <- pipe("pbcopy", "w")                       
            writeLines(x, con = j)                               
            close(j)   
        },
        "Windows"=writeClipboard(x, format = 1),
        "Linux"={
            if(Sys.which("xclip") == "") {
              warning("Clipboard on Linux requires 'xclip'. Try using:\nsudo apt-get install xclip")
            }
            con <- pipe("xclip -i", "w")
            writeLines(x, con=con)
            close(con)
        }
    )
}
