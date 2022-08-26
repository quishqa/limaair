download_airport_sounding <- function(date, hour = 12, airport = "SPIM"){
  date <- "15/01/2019" # to del
  hour <- 12 # to del
  airport <- "SPIM" # to del
  day <- substr(date, 1, 2)
  month <- substr(date, 4, 5)
  year <- substr(date, 7, 10)

  url <- "https://weather.uwyo.edu/cgi-bin/sounding"

  httr::set_config(httr::config(ssl_verifypeer = FALSE))

  sounding <- httr::GET(url,
                        query  = list(
                          region = "samer",
                          TYPE = "TEXT:LIST",
                          YEAR = year,
                          MONTH = month,
                          FROM = paste0(day, hour),
                          TO = paste0(day, hour),
                          STNM = airport
                        ))
  httr::reset_config()

  sound_html <- XML::htmlParse(sounding)
  sound_html_table <- XML::getNodeSet(sound_html, "//pre")
  sound_data_html <- sound_html_table[[1]]
  sound_text <- utils::capture.output(sound_data_html)
  sound_data <- sound_text[6:(length(sound_text) - 1)]
  #TODO: transform sound data into a data frame
  return(sound_data)
}
