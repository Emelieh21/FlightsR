# FlightsR

A wrapper for the [FlightStats](https://developer.flightstats.com/) API in R.

To install, run:

``` 
if (!require(devtools)) {
  install.packages('devtools')
}
devtools::install_github('Emelieh21/FlightsR')
```

To set your Key and AppId:

```
library(FlightsR)

setAPIKey()
setAppId()
```

Simple command to test if it works:

```
searchAirline("FR")
```
