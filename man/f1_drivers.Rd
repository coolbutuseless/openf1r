% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f1-api.R
\name{f1_drivers}
\alias{f1_drivers}
\title{Provides information about drivers for each session.}
\usage{
f1_drivers(..., session_key = "latest", meeting_key)
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

\item{meeting_key}{The unique identifier for the meeting. Use 'latest' to
identify the latest or current meeting.}
}
\value{
data.frame
}
\description{
Provides information about drivers for each session.
}
\examples{
\dontshow{if (interactive()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
f1_drivers()
\dontshow{\}) # examplesIf}
}
