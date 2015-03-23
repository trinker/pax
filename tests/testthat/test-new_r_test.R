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

test_that("new_r_test creates a .R file when passed a single line function",{

    printer <- function(text = "Robots stink") print(text)
    tmp <- tempdir()  
    paxtest4 <- file.path(tmp, "pax_testing")
    unlink(paxtest4, TRUE, TRUE)    
    dir.create(paxtest4)
    suppressMessages(new_r_test(printer, paxtest4, test.path = paxtest4))
    fls <- file.path(paxtest4, "printer.R")
    expect_true(file.exists(fls))
    lns <- readLines(fls)
    expect_true(length(grep("^function", lns)) > 0)
})
