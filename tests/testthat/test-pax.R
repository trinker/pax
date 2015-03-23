context("Checking pax")

test_that("pax created a directory with standard files",{
    tmp <- tempdir()  
    paxtest1 <- file.path(tmp, "pax_testing")
    unlink(paxtest1, TRUE, TRUE)
    suppressMessages(pax(paxtest1, open=FALSE, readme = FALSE))
    expect_true(file.exists(paxtest1))
    expected <- c(".gitignore", ".Rbuildignore", ".travis.yml", "DESCRIPTION", 
        "inst", "NEWS", "R",  
        "tests")
    fls <- list.files(paxtest1, all.files = TRUE)
    expect_true(all(sapply(expected, function(x) x %in% fls)))
})

test_that("pax created a directory with standard files set to FALSE",{
    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing2")
    unlink(paxtest2, TRUE, TRUE)
    suppressMessages(pax(paxtest2, news = FALSE, readme = FALSE, rstudio = FALSE, 
        gitignore = FALSE, testthat = FALSE, travis = FALSE, coverage = FALSE,
        samples = FALSE, open=FALSE))
    expect_true(file.exists(paxtest2))
    expected <- c(".Rbuildignore", "DESCRIPTION", "inst", "R")
    fls <- list.files(paxtest2, all.files = TRUE)
    expect_true(all(sapply(expected, function(x) x %in% fls)))
})


