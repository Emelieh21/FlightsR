# FlightsR

A wrapper for the [FlightStats](https://developer.flightstats.com/) API in R.

To install, run:

```R
if (!require(devtools)) {
  install.packages('devtools')
}
devtools::install_github('Emelieh21/FlightsR')
```

To set your Key and AppId:

```R
library(FlightsR)

setAPIKey()
setAppId()
```

Simple commands to test if it works:

```R
searchAirline("FR") # looks up the airline by airline IATA code
one_hour <- scheduledFlights("txl","arriving","2017/07/17","09") # gets the flights from Berlin (Tegel) arriving at 9 AM
schedule <- scheduledFlightsFullDay("mad","departing","2017/07/17") # gets the flights departing from Madrid for the full day

airports <- listAirports(activeOnly = FALSE) # gets all airports (default set to only active airports)

```
