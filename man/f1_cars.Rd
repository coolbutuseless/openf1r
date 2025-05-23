% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f1-api.R
\name{f1_cars}
\alias{f1_cars}
\title{Some data about each car, at a sample rate of about 3.7 Hz.}
\usage{
f1_cars(
  ...,
  session_key = "latest",
  driver_number,
  brake,
  drs,
  n_gear,
  rpm,
  speed,
  throttle,
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

\item{driver_number}{The unique number assigned to an F1 driver}

\item{brake}{Whether the brake pedal is pressed (100) or not (0).}

\item{drs}{The Drag Reduction System (DRS) status. Possible codes and meanings:
0,1 = DRS off.  2,3,9 = Unknown. 8 = Detected, eligible once in 
activation zone. 10,12,14 = DRS on.}

\item{n_gear}{Current gear selection, ranging from 1 to 8. 0 indicates 
neutral or no gear engaged.}

\item{rpm}{Revolutions per minute of the engine.}

\item{speed}{Velocity of the car in km/h.}

\item{throttle}{Percentage of maximum engine power being used.}

\item{date}{The UTC date and time, in ISO 8601 format.}

\item{meeting_key}{The unique identifier for the meeting. Use 'latest' to
identify the latest or current meeting.}
}
\value{
data.frame
}
\description{
Some data about each car, at a sample rate of about 3.7 Hz.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
f1_cars(driver_number = 44)
\dontshow{\}) # examplesIf}
}
