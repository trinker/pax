#' Add an \pkg{rmarkdown} Template
#' 
#' Generate an \pkg{rmarkdown} template and add \pkg{knitr} to 
#' \code{VignetteBuilder} and \code{Suggests} if not already included.
#' 
#' @param title The title of the \pkg{rmarkdown} vignette document.  Defaults 
#' to \emph{Introduction to x} where \emph{x} is the name of the package.
#' @param file.name The name of the vignette file.  Defaults to lower case, 
#' underscore (for space) .Rmd file that utilizes the \code{title} argument.
#' @param vign.path The path to the vignettes directory (where the vignette will
#' be placed).
#' @param add.builder logical.  If \code{TRUE} the \code{builder} argument will
#' be added as the \code{VignetteBuilder} in the \file{DESCRIPTION} file.  
#' Additionally, if \code{builder = "knitr"} this will be added to 
#' \code{Suggests: } if not already a dependency.
#' @param desc.path The path to the \file{DESCRIPTION} file.  Defaults to
#' \code{desc.path = "DESCRIPTION"}.
#' @param builder The name of the \code{VignetteBuilder} in the 
#' \file{DESCRIPTION} file.  Defaults to \code{builder = "knitr"}.
#' @return Generates a \file{____.Rmd} vignette file template.
#' @keywords vignette
#' @export
#' @examples 
#' \dontrun{
#' pax("temp_dir", open = FALSE)
#' dir.create("temp_dir/vignettes")
#' ## Note: If used in RStudio with the root directory set to the 
#' ##       package the user does not need to supply `vign,path` or `desc.path`
#' new_vignette("intro", vign.path = "temp_dir/vignettes", 
#'     desc.path = "temp_dir/DESCRIPTION")
#' unlink("temp_dir", TRUE, TRUE)
#' }
new_vignette <-
function (title = paste("Introduction to", basename(getwd())), 
    file.name = paste0(gsub("\\s+", "_", tolower(title)), ".Rmd"), 
    vign.path = "vignettes", add.builder = TRUE, desc.path = "DESCRIPTION", 
    builder = "knitr") {
    if (!file.exists(vign.path)) {
        message(sprintf("The following location does not exists:\n%s\n", 
            vign.path))
        message("Should this directory be created?")
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`new_vignette` aborted")
        }
        else {
            suppressWarnings(dir.create(vign.path))
        }
    }
    if (add.builder) {
        if (!file.exists(desc.path)) {
            warning(sprintf("Path to %s file not found...\nVignetteBuilder not added.", 
                desc.path))
        }
        else {
            desc <- read.dcf(desc.path)
            if (!any(colnames(desc) %in% "VignetteBuilder")) {
                add <- sprintf("\nVignetteBuilder: %s", builder)
                message(sprintf("Adding `VignetteBuilder: %s` to DESCRIPTION", 
                  builder))
                desc <- suppressWarnings(readLines((desc.path)))
                len <- length(desc)
                desc[len] <- paste(desc[len], add)
                cat(paste(desc, collapse = "\n"), file = desc.path)
            }
            else {
                if (desc[, "VignetteBuilder"] != builder) {
                  warning(sprintf("Conflict between specified `builder` (%s) and existing VignetteBuilder (%s)", 
                    builder, desc[, "VignetteBuilder"]))
                }
            }
        }
    }
    if (add.builder && builder == "knitr") {
        if (!file.exists(desc.path)) {
            warning(sprintf("Path to %s file not found...\nknitr not added to Suggests.", 
                desc.path))
        }
        else {
            desc <- read.dcf(desc.path)
            if (!any(colnames(desc) %in% "Suggests")) {
                addknitr <- "\nSuggests: knitr"
                message("Adding `Suggests: knitr` to DESCRIPTION")
                desc <- suppressWarnings(readLines((desc.path)))
                len <- length(desc)
                desc[len] <- paste(desc[len], addknitr)
                cat(paste(desc, collapse = "\n"), file = desc.path)
            }
            else {
                desc <- read.dcf(desc.path)
                sugg <-  paste(desc[, colnames(desc) %in% c("Imports", 
                    "Suggests", "Depends")], collapse=",")
                if (!grepl("knitr\\b", sugg)) {
                  message("Adding `Suggests: knitr` to DESCRIPTION")
                  desc[, "Suggests"] <- paste0(desc[, "Suggests"], ",\nknitr")
                  cat(paste(gsub("\n", "\n    ", paste(colnames(desc), 
                    desc, sep = ": ")), collapse = "\n"), file = desc.path)
                }
            }
        }
    }
    cat(paste(sprintf(vign, title, title), collapse = "\n"), 
        file = file.path(vign.path, file.name))
    if (file.exists(file.path(vign.path, file.name))) {
        message(sprintf("Vignette created:\n%s", file.path(vign.path, 
            file.name)))
    }
} 

vign <- c("---", "title: \"%s\"", "date: \"`r Sys.Date()`\"", 
    "output: rmarkdown::html_vignette", 
    "vignette: >", "  %%\\VignetteIndexEntry{%s}", 
    "  %%\\VignetteEngine{knitr::rmarkdown}", 
    "  \\usepackage[utf8]{inputenc}", "---", "", 
    "```{r, echo = FALSE, message = FALSE}", 
    "knitr::opts_chunk$set(tidy = FALSE)", 
    "#pacman::p_load()", 
    "```", "", "--CONTENT HERE--\n"
)
