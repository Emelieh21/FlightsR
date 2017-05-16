#' Function to set the API key from FlightStats (developer.flightstats.com)
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' setAPIKey()
#' @export
#'
setAPIKey <- function(){
  key <- readline(prompt="Please enter your FlightStats API Key and hit enter: ")
  text <- paste0("flightstats_api_key=", key, "\n")
  env <- Sys.getenv("flightstats_api_key")
  if (!file.exists(file.path(normalizePath("~/"), ".Renviron"))){
    file.create(file.path(normalizePath("~/"), ".Renviron"), showWarnings = TRUE)
  }
  if (!identical(env, "")) {
    renv <- readLines(file.path(normalizePath("~/"), ".Renviron"))
    loc <- grep("flightstats_api_key", renv)
    renv[loc] <- text
    Sys.setenv(flightstats_api_key = key)
    writeLines(renv, file.path(normalizePath("~/"), ".Renviron"))
  }
  else {
    Sys.setenv(flightstats_api_key = key)
    cat(text, file = file.path(normalizePath("~/"), ".Renviron"),
        append = TRUE)
  }
}
