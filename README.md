# FlightsR

A wrapper for the [FlightStats](https://developer.flightstats.com/) API in R.

To install, run:

```R
if (!require(devtools)) {
  install.packages('devtools')
}
devtools::install_github('Emelieh21/FlightsR')
```

To set your API Key and AppId:

```R
library(FlightsR)

setAPIKey()
setAppId()
```

Simple commands to test if it works:

```R
# retrieving airline info
airlines <- listAirlines()
searchAirline("FR") # looks up the airline by airline IATA code

# retrieving schedule info
one_hour <- scheduledFlights("txl","arriving","2017/07/17","09") # gets the flights for one hour
schedule <- scheduledFlightsFullDay("mad","departing","2017/07/17") # gets flights for the full day

# retrieving airport info
airports <- listAirports(activeOnly = FALSE) # gets all airports (default set to only active airports)
nl <- searchAirport(by="countryCode", value="NL")

```
