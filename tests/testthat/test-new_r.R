context("Checking new_r")

test_that("new_r creates a .R file when passed a function",{

    tmp <- tempdir()  
    paxtest1 <- file.path(tmp, "pax_testing")
    unlink(paxtest1, TRUE, TRUE)    
    dir.create(paxtest1)
    suppressMessages(new_r(paste, paxtest1))
    fls <- file.path(paxtest1, "paste.R")
    expect_true(file.exists(fls))
    lns <- readLines(fls)
    expect_true(length(grep("^function", lns)) > 0)
})

test_that("new_r creates a .R file when passed a character and rename the .R file",{

    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing")
    unlink(paxtest2, TRUE, TRUE)    
    dir.create(paxtest2)
    suppressMessages(new_r("myfun", paxtest2, "afun.R"))
    fls <- file.path(paxtest2, "afun.R")
    expect_true(file.exists(fls))
    lns <- readLines(fls)
    expect_true(tail(lns, 1) == "")
})
