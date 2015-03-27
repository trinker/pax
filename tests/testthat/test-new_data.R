context("Checking new_data")

test_that("new_data adds a data file and documents in the correct location",{

    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing2")
    unlink(paxtest2, TRUE, TRUE)
    suppressMessages(pax(paxtest2, open=FALSE, readme = FALSE))    
    if (file.exists(paxtest2)){
        dir.create(file.path(paxtest2, "data"))
        SP <- function(x) file.path(paxtest2, x)
        SPV <- function(x) file.path(paxtest2, "data", x)
        suppressMessages(new_data(mtcars, data.path = SP("data"), 
            doc.path = SP("R/pax_testing2-package.R")))
        expect_true(file.exists(SPV("mtcars.rda")))

        expect_true(any(grepl("^\\#' @usage data\\(mtcars\\)", 
            readLines(SP("R/pax_testing2-package.R")))))
    }    

})

test_that("new_data helper `what` for data typing",{

    expect_equal(what(mtcars), "data frame")
    expect_equal(what(list(1, 2, 4)), "list")
    expect_equal(what("the dog"), "character vector")
    expect_equal(what(c(1, 2, 4)), "vector")
    expect_equal(what(environment()), "environment")

})

