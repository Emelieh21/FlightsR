#' Function that retrieves flight schedules from FlightStats for the whole day
#'
#' @param airport character with the IATA code of the airport
#' @param action character, can be either arriving or departing
#' @param date character, a date in the format YYYY/MM/DD
#' @param silent boolean, to define if the number of flights found should be printed
#' @return data.frame() with the flights for the whole day
#'
#' @author Emelie Hofland, \email{emelie_hofland@hotmail.com}
#'
#' @examples
#' schedule <- scheduledFlightsFullDay("sxf","departing","2017/07/01")
#'
#' @import RCurl
#' @import progress
#' @import jsonlite
#' @export
#'
scheduledFlightsFullDay <-
function(airport, action, date){
  hours <- c(0:23)
  result = data.frame()
  pb <- progress_bar$new(
    format = " Running [:bar] :percent eta: :eta",
    total = length(hours), clear = FALSE, width= 60)
  for (hour in hours){
    dat <- scheduledFlights(airport, action, date, hour, silent = TRUE)
    x <- names(dat)
    drop <- c("arrivalTerminal","wetleaseOperatorFsCode","departureTerminal","isWetlease","serviceType","serviceClasses","trafficRestrictions","codeshares","referenceCode","operator")
    x <- x[!(x %in% drop)]
    dat <- dat[,x]
    result <- rbind(result,dat)
    pb$tick()
  }
  return(result)
}

