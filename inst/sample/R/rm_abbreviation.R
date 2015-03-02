#' Abbreviations
#'
#' Find abbreviates that contain capitals or or lower case.  Must have at
#' minimum 1 letter followed by a period folowed by another letter and period.
#' May contain additional letters and spaces.
#'
#' @importFrom regexr construct %:)%
#' @section Regex: TRUE
#' @export
#' @examples
#' input <- c("I want $2.33 at 2:30 p.m. to go to A.n.p.",
#'     "She will send it A.S.A.P. (e.g. as soon as you can) said I.",
#'     "Hello world.", "In the U. S. A.")
#'
#' regmatches(input, gregexpr(rm_abbreviation, input, perl = TRUE))
#' gsub(rm_abbreviation, "", input, perl = TRUE)
#' strsplit(input, rm_abbreviation, perl = TRUE)
rm_abbreviation <- construct(

    let_per_1 = "([A-Za-z][\\.]\\s*){1,}"  %:)%  "Letter folowed by period and optional space (1 or more times)",
    let_per_2 = "([A-Za-z][\\.])"          %:)%  "Ending letter folowed by period"

)


