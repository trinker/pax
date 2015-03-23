context("Checking new_r_test")

test_that("new_r_test creates a .R file when passed a function",{

    tmp <- tempdir()  
    paxtest1 <- file.path(tmp, "pax_testing")
    unlink(paxtest1, TRUE, TRUE)    
    dir.create(paxtest1)
    suppressMessages(new_r_test(paste, paxtest1, test.path = paxtest1))
    fls <- file.path(paxtest1, "paste.R")
    expect_true(file.exists(fls))
    fls2 <- file.path(paxtest1, "test-paste.R")
    expect_true(file.exists(fls2))    
    lns <- readLines(fls)
    expect_true(length(grep("^function", lns)) > 0)
})

test_that("new_r_test creates a .R file when passed a character and rename the .R file",{

    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing")
    unlink(paxtest2, TRUE, TRUE)    
    dir.create(paxtest2)
    suppressMessages(new_r_test("myfun", paxtest2, "afun.R", paxtest2, "test-afun.R"))
    fls <- file.path(paxtest2, "afun.R")
    expect_true(file.exists(fls))
    fls2 <- file.path(paxtest2, "test-afun.R")
    expect_true(file.exists(fls2))    
    lns <- readLines(fls)
    expect_true(tail(lns, 1) == "")
})