#' Function that lists airports retrieved from FlightStats
#'
#' @param activeOnly boolean to include all or only active airports, can be set to TRUE or FALSE
#' @return data.frame() with the airlines
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' listAirports()
#'
#' @import RCurl
#' @import jsonlite
#' @export
#'
listAirports <-
function(activeOnly=TRUE){
  ID = Sys.getenv("flightstats_app_id")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  KEY = Sys.getenv("flightstats_api_key")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  if(missing(activeOnly)){
    choice = "active"
  }
  if(activeOnly == FALSE) {
    choice = "all"
  }
  else {
    choice = "active"
  }
  link = paste0("https://api.flightstats.com/flex/airports/rest/v1/json/",choice,"?appId=",ID,"&appKey=",KEY)
  dat = getURL(link)
  dat_list <- fromJSON(dat)
  airports <- dat_list$airports
  return(airports)
}
