wheresRstudio <- 
function() {
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
    action <- paste(wheresRstudio(), Rproj.loc)
    message(sprintf("\nPreparing to open %s!", package))
    try(system(action, wait = FALSE, ignore.stderr = TRUE))
}

