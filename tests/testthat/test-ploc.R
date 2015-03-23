context("Checking ploc")

test_that("ploc sets to a preset location when `options(dit =` is set",{

    locs <- file.path(Sys.getenv("USERPROFILE"), "Desktop")
    options(dir = locs)
    expect_equal(ploc("DELETE_ME"), file.path(locs, "DELETE_ME"))

})

