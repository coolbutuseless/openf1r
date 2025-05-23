% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f1-api.R
\name{f1_weather}
\alias{f1_weather}
\title{The weather over the track, updated every minute.}
\usage{
f1_weather(
  ...,
  session_key = "latest",
  rainfall,
  air_temperature,
  track_temperature,
  wind_direction,
  wind_speed,
  humidity,
  pressure,
  date,
  meeting_key
)
}
\arguments{
\item{...}{Verbatim options added to API call. Use this to add filtering 
options e.g. \code{f1_sessions("date_start >= 2025-04-01")}.  For filtering
\itemize{
  \item{most named arguments can be filtered}
  \item{use \code{<=}, \code{>=}, \code{<}, \code{>} for specifying ranges}
  \item{for date filtering, use date format "YYYY-MM-DD", and
        "YYYY-MM-DDTHH:MM:SS"}
}}

\item{session_key}{The unique identifier for the session. For 
\code{f1_sessions()} the default is \code{NULL} to return all sessions.
For all other functions \code{session_key} defaults to 'latest' so as to
only fetch the data for the latest/current session. Valid values are:
'latest', \code{NULL} or an integer session key}

\item{rainfall}{Whether there is rainfall.}

\item{air_temperature}{Air temperature (Celsius).}

\item{track_temperature}{Track temperature (Celsius).}

\item{wind_direction}{Wind direction angle in degrees, from 0 to 359.}

\item{wind_speed}{Wind speed (m/s).}

\item{humidity}{Relative humidity (percent).}

\item{pressure}{Air pressure (mbar).}

\item{date}{The UTC date and time, in ISO 8601 format.}

\item{meeting_key}{The unique identifier for the meeting. Use 'latest' to
identify the latest or current meeting.}
}
\value{
data.frame
}
\description{
The weather over the track, updated every minute.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
f1_weather()
\dontshow{\}) # examplesIf}
}
