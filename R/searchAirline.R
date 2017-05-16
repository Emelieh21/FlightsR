#' Function searches a specific airline by IATA code
#'
#' @param value character, an airline IATA code
#' @return data.frame() with the airline
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' searchAirline("FR")
#'
#' @import RCurl
#' @import jsonlite
#' @export
#'
searchAirline <-
function(value){
  ID = Sys.getenv("flightstats_app_id")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  KEY = Sys.getenv("flightstats_api_key")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  link = paste0("https://api.flightstats.com/flex/airlines/rest/v1/json/iata/",toupper(value),"?appId=",ID,"&appKey=",KEY)
  dat <- getURL(link)
  dat_list <- fromJSON(dat)
  result <- dat_list$airlines
  if (length(result)==0){
    warning("Please make sure that you provide a valid airline IATA code.")
  }
  return(result)
}
