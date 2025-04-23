

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Some data about each car, at a sample rate of about 3.7 Hz.
#' 
#' @inheritParams f1_sessions
#' @param brake Whether the brake pedal is pressed (100) or not (0).
#' @param date The UTC date and time, in ISO 8601 format.
#' @param driver_number The unique number assigned to an F1 driver
#' @param drs The Drag Reduction System (DRS) status. Possible codes and meanings:
#'        0,1 = DRS off.  2,3,9 = Unknown. 8 = Detected, eligible once in 
#'        activation zone. 10,12,14 = DRS on.
#' @param n_gear Current gear selection, ranging from 1 to 8. 0 indicates 
#'        neutral or no gear engaged.
#' @param rpm Revolutions per minute of the engine.
#' @param speed Velocity of the car in km/h.
#' @param throttle Percentage of maximum engine power being used.
#' @return data.frame
#' @examplesIf interactive()
#' f1_cars(driver_number = 44)
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_cars <- function(..., 
                    session_key = 'latest', 
                    driver_number,
                    brake, 
                    drs, 
                    n_gear,
                    rpm, 
                    speed, 
                    throttle,
                    date, 
                    meeting_key) {
  args <- find_args(...)
  url <- f1_url('car_data', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about drivers for each session.
#' 
#' @inheritParams f1_sessions
#' @return data.frame
#' @examplesIf interactive()
#' f1_drivers()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_drivers <- function(..., 
                       session_key = 'latest', 
                       meeting_key) {
  args <- find_args(...)
  url <- f1_url('drivers', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Fetches real-time interval data between drivers and their gap to the race leader.
#' Available during races only, with updates approximately every 4 seconds.
#' 
#' @inheritParams f1_sessions
#' @param date The UTC date and time, in ISO 8601 format.
#' @param driver_number The unique number assigned to an F1 driver
#' @param gap_to_leader The time gap to the race leader in seconds, +1 LAP if 
#'        lapped, or null for the race leader.
#' @param interval The time gap to the car ahead in seconds, +1 LAP if 
#'        lapped, or null for the race leader.
#' @return data.frame
#' @examplesIf interactive()
#' f1_intervals()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_intervals <- function(..., 
                         session_key = 'latest',
                         driver_number, 
                         gap_to_leader, 
                         interval,
                         date, 
                         meeting_key) {
  args <- find_args(...)
  url <- f1_url('intervals', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides detailed information about individual laps.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param duration_sector_1,duration_sector_2,duration_sector_3 The time taken, 
#'        in seconds to complete the given sector of the lap
#' @param i1_speed,i2_speed The speed of the car, in km/h, at the first and
#'        second intermediate point on the track.
#' @param is_pit_out_lap A boolean value indicating whether the lap is an 
#'        "out lap" from the pit (true if it is, false otherwise).
#' @param lap_duration The total time taken, in seconds, to complete the entire lap.
#' @param lap_number The sequential number of the lap within the session
#'        (starts at 1).
#' @param segments_sector_1,segments_sector_2,segments_sector_3 A list of 
#'        values representing the "mini-sectors" within the first sector
#' @param st_speed The speed of the car, in km/h, at the speed trap, which 
#'        is a specific point on the track where the highest speeds are 
#'        usually recorded.
#' @return data.frame
#' @examplesIf interactive()
#' f1_laps(driver_number = 44, lap_number = 1)
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_laps <- function(..., 
                    session_key = 'latest',
                    driver_number,
                    duration_sector_1, duration_sector_2, duration_sector_3, 
                    i1_speed, i2_speed,
                    is_pit_out_lap, 
                    lap_duration, lap_number,
                    segments_sector_1, segments_sector_2, segments_sector_3,
                    st_speed,
                    date_start,
                    meeting_key) {
  args <- find_args(...)
  url <- f1_url('laps', args)
  
  f1_fetch(url)
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Information about the codes for mini-segments
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
segments_sector <- data.frame(
  value = c(0, 2048, 2049, 2050, 2051, 2052, 2064, 2068),
  color = c(
    "not available",
    "yellow sector",
    "green sector",
    "unknown",
    "purple sector",
    "unknown",
    "pitlane",
    "unknown"
  ),
  stringsAsFactors = FALSE
)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' The approximate location of the cars on the circuit, at a sample rate of 
#' about 3.7 Hz.
#' 
#' Useful for gauging their progress along the track, but lacks details about 
#' lateral placement — i.e. whether the car is on the left or right side of the 
#' track. The origin point (0, 0, 0) appears to be arbitrary and not tied to any 
#' specific location on the track.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param x,y,z 3D Cartesian coordinate system representing the current 
#'        approximate location of the car on the track.
#' @return data.frame
#' @examplesIf interactive()
#' f1_locations(driver_number = 44)
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_locations <- function(..., 
                         session_key = 'latest', 
                         driver_number, 
                         x, y, z, 
                         date, 
                         meeting_key) {
  args <- find_args(...)
  url <- f1_url('location', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about meetings i.e. a Grand Prix or testing weekend.
#' Usually includes multiple sessions (practice, qualifying, race, ...).
#' 
#' @inheritParams f1_sessions
#' @param meeting_name The name of the meeting.
#' @param meeting_official_name The official name of the meeting.
#' @return data.frame
#' @examplesIf interactive()
#' f1_meetings()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_meetings <- function(..., 
                        circuit_key, 
                        circuit_short_name, 
                        country_code, 
                        country_key, 
                        country_name, 
                        date_start, 
                        gmt_offset,
                        location, 
                        meeting_key, 
                        meeting_name, 
                        meeting_official_name, 
                        year) {
  args <- find_args(...)
  url <- f1_url('meetings', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about cars going through the pit lane.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @inheritParams f1_laps
#' @param pit_duration The time spent in the pit, from entering to leaving 
#'        the pit lane, in seconds.
#' @return data.frame
#' @examplesIf interactive()
#' f1_pits()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_pits <- function(..., 
                    session_key = 'latest',
                    pit_duration,
                    driver_number, 
                    lap_number, 
                    date,
                    meeting_key) {
  args <- find_args(...)
  url <- f1_url('pit', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides driver positions throughout a session, including initial placement 
#' and subsequent changes.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param position Position of the driver (starts at 1).
#' @return data.frame
#' @examplesIf interactive()
#' f1_positions()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_positions <- function(..., 
                         session_key = 'latest',
                         driver_number, 
                         position, 
                         date, 
                         meeting_key 
) {
  args <- find_args(...)
  url <- f1_url('position', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about race control (racing incidents, flags, 
#' safety car, ...).
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @inheritParams f1_laps
#' @param category The category of the event 
#'        ('CarEvent', 'Drs', 'Flag', 'SafetyCar', ...).
#' @param flag Type of flag displayed 
#'        ('GREEN', 'YELLOW', 'DOUBLE YELLOW', 'CHEQUERED', 'RED", 'CLEAR', 
#"         'BLACK AND WHITE', ...).
#' @param message Description of the event or action.
#' @param scope The scope of the event ('Track', 'Driver', 'Sector', ...).
#' @param sector Segment ("mini-sector") of the track where the event occurred? 
#'        (starts at 1).
#' @return data.frame
#' @examplesIf interactive()
#' f1_race_control()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_race_control <- function(..., 
                            session_key = 'latest',
                            category, 
                            driver_number, 
                            flag, 
                            lap_number, 
                            message, 
                            scope, 
                            sector,
                            date,
                            meeting_key) {
  args <- find_args(...)
  url <- f1_url('race_control', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about sessions - i.e. a distinct period of track 
#' activity during a Grand Prix  (practice, qualifying, sprint, race, ...).
#' 
#' @param ... Verbatim options added to API call. Use this to add filtering 
#'        options e.g. \code{f1_sessions("date_start >= 2025-04-01")}.  For filtering
#'        \itemize{
#'          \item{most named arguments can be filtered}
#'          \item{use \code{<=}, \code{>=}, \code{<}, \code{>} for specifying ranges}
#'          \item{for date filtering, use date format "YYYY-MM-DD", and
#'                "YYYY-MM-DDTHH:MM:SS"}
#'        }
#' @param circuit_key The unique identifier for the circuit where the event 
#'        takes place.
#' @param circuit_short_name The short or common name of the circuit where the 
#'        event takes place.
#' @param country_code A code that uniquely identifies the country. e.g. "AUS", "USA"
#' @param country_key The unique identifier for the country where the event 
#'        takes place.
#' @param country_name The full name of the country where the event takes place.
#' @param date_end The UTC ending date and time, in ISO 8601 format.
#' @param date_start The UTC starting date and time, in ISO 8601 format.
#' @param gmt_offset The difference in hours and minutes between local time at 
#'        the location of the event and Greenwich Mean Time (GMT).
#' @param location The city or geographical location where the event takes place.
#' @param meeting_key The unique identifier for the meeting. Use 'latest' to
#'        identify the latest or current meeting.
#' @param session_key The unique identifier for the session. For 
#'        \code{f1_sessions()} the default is \code{NULL} to return all sessions.
#'        For all other functions \code{session_key} defaults to 'latest' so as to
#'        only fetch the data for the latest/current session. Valid values are:
#'        'latest', \code{NULL} or an integer session key
#' @param session_name The name of the session 'Practice 1', 'Qualifying', 
#'        'Race' etc
#' @param session_type The type of the session 'Practice', 'Qualifying', 
#'        'Race' etc.
#' @param year The year the event takes place.
#' 
#' @return data.frame
#' @examplesIf interactive()
#' # Find all sessions in the OpenF1 database
#' f1_sessions()[1:5] |>
#'   head()
#' 
#' # Show all sessions in the last 50 days
#' # This will user filtering by passing in an unnamed character string 
#' limit <- Sys.Date() - 50
#' limit <- sprintf("date_start > %s", limit)
#' limit
#' f1_sessions(limit, session_type = 'Race')[,1:5]
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_sessions <- function(..., 
                        session_key = NULL, 
                        circuit_key, 
                        circuit_short_name, 
                        country_code,
                        country_key,
                        country_name, 
                        date_start, date_end, 
                        gmt_offset, 
                        location, 
                        meeting_key, 
                        session_name, 
                        session_type, 
                        year) {
  
  args <- find_args(...)
  url <- f1_url('sessions', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides information about individual stints i.e. a period of continuous 
#' driving by a driver during a session.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param compound The specific compound of tyre used during the stint 
#'        (SOFT, MEDIUM, HARD, ...).
#' @param lap_start,lap_end Number of the first/last completed lap in this stint.
#' @param stint_number The sequential number of the stint within the session 
#'        (starts at 1).
#' @param tyre_age_at_start The age of the tyres at the start of the stint, 
#'        in laps completed.
#' @return data.frame
#' @examplesIf interactive()
#' f1_stints(driver_number = 44)
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_stints <- function(..., 
                      session_key = 'latest',
                      driver_number,
                      compound, 
                      lap_end, lap_start, 
                      stint_number, 
                      tyre_age_at_start,
                      meeting_key) {
  args <- find_args(...)
  url <- f1_url('stints', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Provides a collection of radio exchanges between Formula 1 drivers and their 
#' respective teams during sessions.
#' 
#' Please note that only a limited selection of communications are included, 
#' not the complete record of radio interactions.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param recording_url URL of the radio recording.
#' @return data.frame
#' @examplesIf interactive()
#' f1_radios(driver_number = 44)
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_radios <- function(..., 
                      session_key = 'latest',
                      driver_number,
                      recording_url,
                      date, 
                      meeting_key) {
  args <- find_args(...)
  url <- f1_url('team_radio', args)
  
  f1_fetch(url)
}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' The weather over the track, updated every minute.
#' 
#' @inheritParams f1_sessions
#' @inheritParams f1_intervals
#' @param air_temperature Air temperature (Celsius).
#' @param humidity Relative humidity (percent).
#' @param pressure Air pressure (mbar).
#' @param rainfall Whether there is rainfall.
#' @param track_temperature Track temperature (Celsius).
#' @param wind_direction Wind direction angle in degrees, from 0 to 359.
#' @param wind_speed Wind speed (m/s).
#' @return data.frame
#' @examplesIf interactive()
#' f1_weather()
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
f1_weather <- function(..., 
                       session_key = 'latest',
                       rainfall, 
                       air_temperature,
                       track_temperature,
                       wind_direction, 
                       wind_speed, 
                       humidity,
                       pressure, 
                       date,
                       meeting_key) {
  args <- find_args(...)
  url <- f1_url('weather', args)
  
  f1_fetch(url)
}


