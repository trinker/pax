context("Checking pax_options")

test_that("pax_options outputs a string of \n separated options",{

    expected <- paste(c(
        "options(name = c(first=\"\",  last=\"\"))",
        "options(email = \"\")",  
        "options(license = \"\")",
        "options(github.user = \"\")",  
        "options(samples = )",
        "options(tweak = \"\")",
        "options(dir = \"\") ## See `?ploc` for details"
    ), collapse = "\n")
    
    expect_equal(suppressMessages(pax_options()), expected)

})

