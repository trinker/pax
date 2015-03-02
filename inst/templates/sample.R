#' Words [SAMPLE] 
#' 
#' Find words.
#' 
#' @section Regex: TRUE
#' @export
#' @examples
#' regmatches("I like candy.", gregexpr(MY_REGEX, "I like candy.", perl = TRUE))
#' 
#' gsub(MY_REGEX, "", "I like candy")
#' 
#' strsplit("I like candy", MY_REGEX)   
myRegex <- "\\w+"


