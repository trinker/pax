context("Checking SAMPLE")

## This is a sample unit test that can be altered

## The user is encouraged to use unit tests on each regular expression 
## to ensure it continues to behave as expected after changes

## The functions `test_extract`, `test_remove`, and `test_split` are useful
## wrappers for `all.equal` to test that a regular expression is
## extracting, removing, and splitting as expected


MY_REGEX <- "\\w+"  ## Delete this line and replace with a regex from the library

test_that("MY_REGEX extracts words",{
    
    expect_true(test_extract(MY_REGEX, "I like candy.", list(c("I", "like", "candy"))))

})

test_that("MY_REGEX removes words",{
    
    expect_true(test_remove(MY_REGEX, " I like candy ", "    "))

})

test_that("MY_REGEX splits words",{
    
    expect_true(test_split(MY_REGEX, " I like candy ", list(c(" ", " ", " ", " "))))    

})

test_that("MY_REGEX is a valid regular expression",{
    
    expect_true(test_valid(MY_REGEX))    

})


