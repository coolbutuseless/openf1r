

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Construct an OpenF1 URL
#' 
#' @param type type of data. character. one of: "car_data", "drivers", 
#'        "intervals", "laps", "location", "meetings", "pit", "position", 
#'        "race_control", "sessions", "stints", "team_radio", "weather"
#' @param opts named list of options
#' @return URL as a string
#' @examples
#' f1_url('sessions')
#' @noRd
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_url <- function(type, opts = list()) {
  stopifnot(type %in% c(
    "car_data", "drivers", "intervals", "laps", "location", "meetings", 
    "pit", "position", "race_control", "sessions", "stints", "team_radio", 
    "weather")
  )
  
  # Force values to be returned as CSV from the API
  opts$csv <- 'true'
  
  extra <- opts$extra
  opts$extra <- NULL
  opts_str <- paste0(names(opts), "=", opts, collapse = "&")
  
  if (!is.null(extra) && nchar(extra) > 0) {
    opts_str <- paste(opts_str, extra, sep = "&")
  }
  
  opts_str <- gsub("\\s+", "%20", opts_str)
  
  sprintf("https://api.openf1.org/v1/%s?%s", type, opts_str)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Fetch data from OpenF1 API as CSV
#' @param url complete url for OpenAPI
#' @return data.frame
#' @importFrom utils read.csv
#' @noRd
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_fetch <- function(url) {
  
  if (!is.null(cache[[url]])) {
    return(cache[[url]])
  }
  
  # message(url)
  df <- read.csv(url(url), stringsAsFactors = FALSE)
  
  
  if (!is.data.frame(df)) {
    stop("f1_fetch(): Expected data.frame from url. Got: ", deparse1(df))
  }
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Parse date objects
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  nms <- grep("^date", names(df), value = TRUE)
  for (nm in nms) {
    df[[nm]] <- as.POSIXct(
      strptime(df[[nm]], "%Y-%m-%d %H:%M:%OS", tz = "UTC")
    )
  }
  
  
  cache[[url]] <- df
  df
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Clear cached downloads
#' 
#' All data fetched from the OpenF1 API is cached, and subsequent calls with 
#' the same parameters just returns the cached value.  Use this function 
#' to clear this cache so that the next download fetches data from the API
#' 
#' @return None.
#' @examples
#' clear_cache()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
clear_cache <- function() {
  for (nm in names(cache)) {
    cache[[nm]] <- NULL
  }
  
  invisible()  
}



