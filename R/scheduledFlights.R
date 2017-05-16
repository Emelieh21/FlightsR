#' Function that retrieves flight schedules from FlightStats
#'
#' @param airport character with the IATA code of the airport
#' @param action character, can be either arriving or departing
#' @param date character, a date in the format YYYY/MM/DD
#' @param hour character, hour in the format h or hh
#' @param silent boolean, to define if the number of flights found should be printed
#' @return data.frame() with the flights for the hour specified
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' schedule <- scheduledFlights(airport="sxf",action = "arriving", date="2017/07/01", hour="10")
#'
#' @import RCurl
#' @import jsonlite
#' @export
#'
scheduledFlights <- function(airport, action, date, hour, silent = FALSE){
  ID = Sys.getenv("flightstats_app_id")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  KEY = Sys.getenv("flightstats_api_key")
  if (ID == ""){
    stop("Please set your FlightStats AppID and API Key with the setAPIKey() and setAppId() function. You can obtain these from https://developer.flightstats.com.")
  }
  if (nchar(hour) > 2){
    stop("Hour format not correct, please provide the hour in 1 or 2 digits - full hours only (no minutes)")
  }
  if (as.numeric(hour) > 24){
    stop("Hour not correct, only 24 hours in the day. Please provide the hour in 1 or 2 digits - full hours only (no minutes)")
  }
  if (nchar(hour) < 2){
    hour = paste0("0",hour)
  }
  presentable_time = paste0(hour,":00")
  airport = toupper(airport)
  action = action
  date = date
  check <- paste0(substr(date,5,5),substr(date,8,8))
  if (check != "//"){
    stop("Date format not correct, please provide YYYY/MM/DD",call. = TRUE, domain = NULL)
  }
  if (action == "departing"){
    from_to = "from"
  }
  if (action == "arriving"){
    from_to = "to"
  }
  link = paste0("https://api.flightstats.com/flex/schedules/rest/v1/json/",from_to,"/",airport,"/",action,"/",date,"/",hour,"?appId=",ID,"&appKey=",KEY)
  dat <- getURL(link)
  dat_list <- fromJSON(dat)
  schedule <- as.data.frame(dat_list$scheduledFlights)
  if (nrow(schedule) < 1){
    if (silent == FALSE){
      print(paste0("No flights found for ",dat_list$appendix$airports$name[1], " in ",dat_list$appendix$airports$countryName[1]," on ", date," at ",presentable_time))
    }
  } else {
    if (silent == FALSE){
      print(paste0(nrow(schedule)," flights found ",action, " ",from_to, " ",dat_list$appendix$airports$name[dat_list$appendix$airports$iata==toupper(airport)], " in ",dat_list$appendix$airports$countryName[dat_list$appendix$airports$iata==toupper(airport)]," on ", date," at ",presentable_time))
    }
    airlines <- dat_list$appendix$airlines
    airports <- dat_list$appendix$airports
    merge_airports <- airports[,c("fs","name", "countryCode")]
    names(merge_airports)<- c("fs","DepartureAirportName","DeparturecountryCode")
    schedule <- merge(schedule, merge_airports, by.x="departureAirportFsCode", by.y="fs", all.x=TRUE)
    names(merge_airports)<- c("fs","ArrivalAirportName","ArrivalcountryCode")
    schedule <- merge(schedule, merge_airports, by.x="arrivalAirportFsCode", by.y="fs", all.x=TRUE)
    merge_airlines <- airlines[,c("fs", "name")]
    names(merge_airlines) <- c("AirlineFs", "CarrierName")
    schedule <- merge(schedule, merge_airlines, by.x="carrierFsCode", by.y="AirlineFs", all.x=TRUE)
  }
  return(schedule)
}
