#' Add and Document (\pkg{roxygen2} Style) Data
#' 
#' Add a \file{.rda} file to the \file{data} directory of a package and document 
#' \pkg{roxygen2} style in the \cr \file{R/____package.R} file.
#' 
#' @param data A data set (\code{\link[base]{environment}},
#' \code{\link[base]{list}}, \code{\link[base]{data.frame}}, 
#' \code{\link[base]{vector}}).
#' @param data.path The path to the data directory (where the data will
#' be placed).  Defaults to \file{data}.
#' @param doc.path The path to the package documentation \file{.R} file. 
#' @return Generates a \file{____.rda} file and accompanying \pkg{roxygen2} style 
#' documentation.
#' @references \url{http://r-pkgs.had.co.nz/data.html#documenting-data}
#' @keywords data
#' @export
#' @family new functions
#' @examples 
#' \dontrun{
#' pax("temp_dir", open = FALSE)
#' dir.create("temp_dir/data")
#' ## Note: If used in RStudio with the root directory set to the 
#' ##       package the user does not need to supply `data.path` or `doc.path`
#' new_data(mtcars, data.path = "temp_dir/data", 
#'     doc.path = "temp_dir/R/temp_dir-package.R")
#' unlink("temp_dir", TRUE, TRUE)
#' }
new_data <- function (data, data.path = "data", 
    doc.path = sprintf("R/%s-package.R", basename(getwd()))) {
    
    nm <- as.character(substitute(data))
    
    if (!file.exists(data.path)){
        message(sprintf("The following location does not exist:\n%s\n", 
            data.path))
        message("Should this directory be created?")
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`new_data` aborted")
        } else {
            suppressWarnings(dir.create(data.path))
        }
    }

    save(data, file = sprintf("%s/%s.rda", data.path, nm), compress = TRUE)
    
    pdoc <- suppressWarnings(readLines(doc.path))
    
    if (any(grepl(paste0("^#' @name ", nm, "\\b"), pdoc))) {
        message(sprintf("`%s` already detected in:\n%s", nm, doc.path))
        message(sprintf("\nDo you want to add an additional instance in %s?", doc.path))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            warning(sprintf("`%s` not added to:\n%s", nm, doc.path), immediate. = TRUE)
        } else {
            roxdat(data, nm, file = doc.path, append = TRUE)
            inst <- grep(paste0("^#' @name ", nm, "\\b"), pdoc)
            warning(sprintf(
                "`%s` already detected in:\n%s\n\nConsider removing previous instance(s) (see line(s): %s).", 
                    nm, doc.path, paste(inst, collapse = ", "), immediate. = TRUE
            ))
        }
    } else {
        roxdat(data, nm, file = doc.path, append = TRUE)   
    }

    if (file.exists(sprintf("%s/%s.rda", data.path, nm))) {
        message(sprintf("Data set `%s.rds` added to:\n%s", nm, data.path))
    }    
    message(sprintf("Data set documentation added to:\n%s\n\nAdjust as necessary.", doc.path))
}

roxdat <- function(dat, name, file = "", append = FALSE) {

    x <- "#'"

    type <- what(dat)

    if (type == "environment") {
        desc <- "#' A dataset containing an environment"
    } else {
        if (type == "data frame") {
            desc <- "#' A dataset containing"
        } else {
            if (type %in% c("character vector", "vector", "list")) {
              desc <- paste("#' A dataset containing a", type)
            }
        }
    }

    if (is.data.frame(dat)) {
        dets <- c("#' \\itemize{", paste("#'   \\item ", 
            colnames(dat), ".", sep = ""), "#' }")
    } else {
        if (is.vector(dat) | is.enviroment(dat) | class(dat) ==  "character") {
            dets <- x
        } else {
            if (!is.data.frame(dat) && is.list(dat)) {
                dets <- c("#' \\describe{", paste("#'   \\item{", 
                    names(dat), "}{}", sep = ""), "#' }")
            }
        }
    }
    if (type == "data frame") {
        elems <- c(nrow(dat), "rows and", ncol(dat), "variables")
    } else {
        if (type %in% c("character vector", "vector")) {
            elems <- c(length(dat), "elements")
        } else {
            if (type == "list") {
                elems <- c(length(dat), "elements")
            } else {
                if (type == "environment") {
                    elems <- NULL
                }
            }
        }
    }
    out <- c("\n#'", x, desc, x, "#' @details", dets, x, "#' @docType data", 
        "#' @keywords datasets", paste("#' @name", name), 
        paste0("#' @usage data(", name, ")"), paste("#' @format A", 
            type, "with", paste(elems, collapse = " ")), 
        "#' @references", "NULL\n")
    cat(paste(out, "\n", collapse = ""), file = file, append = append)
}


is.enviroment <- function(x) class(x) == "environment"

what <- function(x) {
    if (is.data.frame(x)) {
        return("data frame")
    }
    if (is.list(x) & !is.data.frame(x)) {
        return("list")
    }
    if (class(x) == "character") {
        return("character vector")
    }
    if (is.vector(x)) {
        return("vector")
    }
    if (is.environment(x)) {
        return("environment")
    }
}
