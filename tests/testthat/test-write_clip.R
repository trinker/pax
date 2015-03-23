context("Checking write_clip")

test_that("write_clip attempts to write to the clipboard",{

    if (Sys.info()["sysname"] %in% c("Darwin", "Windows")){
        m <- try(write_clip("c"))        
        expect_false(inherits(m , "try-error"))
    }
})


