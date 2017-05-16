#' Function to set the AppID from FlightStats (developer.flightstats.com)
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' setAppIdKey()
#' @export
#'
setAppId <-
function(){
  key <- readline(prompt="Please enter your FlightStats AppID and hit enter: ")
  text <- paste0("flightstats_app_id=", key, "\n")
  env <- Sys.getenv("flightstats_app_id")
  if (!file.exists(file.path(normalizePath("~/"), ".Renviron"))){
    file.create(file.path(normalizePath("~/"), ".Renviron"), showWarnings = TRUE)
  }
  if (!identical(env, "")) {
    renv <- readLines(file.path(normalizePath("~/"), ".Renviron"))
    loc <- grep("flightstats_app_id", renv)
    renv[loc] <- text
    Sys.setenv(flightstats_app_id = key)
    writeLines(renv, file.path(normalizePath("~/"), ".Renviron"))
  }
  else {
    Sys.setenv(flightstats_app_id = key)
    cat(text, file = file.path(normalizePath("~/"), ".Renviron"),
        append = TRUE)
  }
}
