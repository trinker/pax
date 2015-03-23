context("Checking new_test")

test_that("new_test creates a .R file when passed a function",{

    tmp <- tempdir()  
    paxtest1 <- file.path(tmp, "pax_testing")
    unlink(paxtest1, TRUE, TRUE)    
    dir.create(paxtest1)
    suppressMessages(new_test(paste, paxtest1))
    fls <- file.path(paxtest1, "test-paste.R")
    expect_true(file.exists(fls))

})

test_that("new_test creates a .R file when passed a character",{

    tmp <- tempdir()  
    paxtest2 <- file.path(tmp, "pax_testing")
    unlink(paxtest2, TRUE, TRUE)    
    dir.create(paxtest2)
    suppressMessages(new_test("myfun", paxtest2))
    fls <- file.path(paxtest2, "test-myfun.R")
    expect_true(file.exists(fls))

})


test_that("new_test creates a .R file when renamed",{

    tmp <- tempdir()  
    paxtest3 <- file.path(tmp, "pax_testing")
    unlink(paxtest3, TRUE, TRUE)    
    dir.create(paxtest3)
    suppressMessages(new_test("myfun", paxtest3, "test-myfunny.R"))
    fls <- file.path(paxtest3, "test-myfunny.R")
    expect_true(file.exists(fls))

})