context("Checking is.global")

test_that("is.global detects when not the global environment",{

    expect_false(is.global())
})

