context("Checking rm_abbreviation")

test_that("rm_abbreviation extracts abbreviation",{

    input <- c("I want $2.33 at 2:30 p.m. to go to A.n.p.",
        "She will send it A.S.A.P. (e.g. as soon as you can) said I.",
        "Hello world.", "In the U. S. A.")

    expected1 <- c("I want $2.33 at 2:30  to go to ",
        "She will send it  ( as soon as you can) said I.",
        "Hello world.",
        "In the "
    )

    expect_true(test_remove(rm_abbreviation, input, expected1))

})

test_that("rm_abbreviation removes abbreviation",{

    input <- c("I want $2.33 at 2:30 p.m. to go to A.n.p.",
        "She will send it A.S.A.P. (e.g. as soon as you can) said I.",
        "Hello world.", "In the U. S. A.")

    expected2 <- list(
        c("p.m.", "A.n.p."),
        c("A.S.A.P.", "e.g."),
        character(0),
        "U. S. A."
    )

    expect_true(test_extract(rm_abbreviation, input, expected2))

})

test_that("rm_abbreviation splits abbreviation",{

    input <- c("I want $2.33 at 2:30 p.m. to go to A.n.p.",
        "She will send it A.S.A.P. (e.g. as soon as you can) said I.",
        "Hello world.", "In the U. S. A.")

    expected3 <- list(
        c("I want $2.33 at 2:30 ", " to go to "),
        c("She will send it ", " (", " as soon as you can) said I."),
        "Hello world.", "In the "
    )


    expect_true(test_split(rm_abbreviation, input, expected3))

})

test_that("rm_abbreviation is a valid regular expression",{

    input <- c("I want $2.33 at 2:30 p.m. to go to A.n.p.",
        "She will send it A.S.A.P. (e.g. as soon as you can) said I.",
        "Hello world.", "In the U. S. A.")

    expect_true(test_valid(rm_abbreviation))

})


