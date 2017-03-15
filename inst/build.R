root <- Sys.getenv("USERPROFILE")
pack <- basename(getwd())

quick <-  TRUE
pdf <- TRUE

unlink(paste0(pack, ".pdf"), recursive = TRUE, force = TRUE)
devtools::document()
devtools::install(quick = quick, build_vignettes = FALSE, dependencies = TRUE)

if(pdf){
    path <- find.package(pack)
    system(paste(shQuote(file.path(R.home("bin"), "R")), "CMD", "Rd2pdf", shQuote(path)))
}

message("Done!")
