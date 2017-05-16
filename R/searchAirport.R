#' Function searches a specific airport(s) by IATA code, ICAO code or country code
#'
#' @param by character, should be set to iata, icao or countryCode
#' @param value character, an iata, icao or country code
#' @return data.frame() with the airport(s)
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' airports <- searchAirport(by="countryCode","NL")
#'
#' @import RCurl
#' @import jsonlite
#' @export
#'
searchAirport <-
function(by, value){
  ID = Sys.getenv("flightstats_app_id")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  KEY = Sys.getenv("flightstats_api_key")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  link = paste0("https://api.flightstats.com/flex/airports/rest/v1/json/",by,"/",toupper(value),"?appId=",ID,"&appKey=",KEY)
  dat <- getURL(link)
  dat_list <- fromJSON(dat)
  result <- dat_list$airports
  if (length(result)==0){
    warning("Please make sure that \'by\' is set to \'iata\', \'icao\' or \'countryCode\'.")
  }
  return(result)
}
