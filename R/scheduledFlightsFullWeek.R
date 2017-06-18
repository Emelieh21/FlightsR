#' Function that retrieves flight schedules from FlightStats for the whole week
#'
#' @param airport character with the IATA code of the airport
#' @param action character, can be either arriving or departing
#' @param calendarweek numeric, the calenderweek number of the week you want to retrieve flights for
#' @param year numeric, currently set default to 2017
#' @return data.frame() with the flights for the whole week
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' schedule <- scheduledFlightsFullWeek("sxf","departing",29)
#'
#' @import RCurl
#' @import progress
#' @import jsonlite
#' @export
#'

scheduledFlightsFullWeek <- function(airport, action, calendarweek, year = 2017){
  collect = data.frame()
  days = c(1:7)
  for (day in days){
    date = gsub("-", "/", as.Date(paste(year, calendarweek, day, sep="-"), "%Y-%U-%u"))
    print(date)
    schedule <- scheduledFlightsFullDay(airport, action, date)
    collect = rbind(collect, schedule)
  }
  return(collect)
}
