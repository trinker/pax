context("Checking new_vignette")

test_that("new_vignette creates a vignette directory and makes DESCRIPTION changes",{

    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing2")
    unlink(paxtest2, TRUE, TRUE)
    suppressMessages(pax(paxtest2, open=FALSE, readme = FALSE))    
    if (file.exists(paxtest2)){
        dir.create(file.path(paxtest2, "vignettes"))
        SP <- function(x) file.path(paxtest2, x)
        SPV <- function(x) file.path(paxtest2, "vignettes", x)
        suppressMessages(new_vignette("intro", vign.path = SP("vignettes"), 
            desc.path = SP("DESCRIPTION")))
        expect_true(file.exists(SPV("intro.Rmd")))
        expect_true(grepl("knitr\\b", read.dcf(SP("DESCRIPTION"))[, "Suggests"]))
        expect_equal(unname(read.dcf(SP("DESCRIPTION"))[, "VignetteBuilder"]), "knitr")     
        expect_equal(readLines(SPV("intro.Rmd"))[2], 
            "title: \"intro\"")
    }
})

