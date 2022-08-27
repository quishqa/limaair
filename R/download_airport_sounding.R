download_airport_sounding <- function(date, hour = 12, airport = "SPIM",
                                      region = "samer"){

  day <- substr(date, 1, 2)
  month <- substr(date, 4, 5)
  year <- substr(date, 7, 10)

  url <- "https://weather.uwyo.edu/cgi-bin/sounding"

  httr::set_config(httr::config(ssl_verifypeer = FALSE))

  sounding <- httr::GET(url,
                        query  = list(
                          region = region,
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
  sound_data <- sound_text[6:(length(sound_text)-1)]

  pres <- substr(sound_data, 2, 7)
  hght <- substr(sound_data, 8, 14)
  temp <- substr(sound_data, 15, 21)
  dwpt <- substr(sound_data, 22, 28)
  relh <- substr(sound_data, 29, 35)
  mixr <- substr(sound_data, 36, 42)
  drct <- substr(sound_data, 43, 49)
  sknt <- substr(sound_data, 50, 56)
  thta <- substr(sound_data, 57, 63)
  thte <- substr(sound_data, 64, 70)
  thtv <- substr(sound_data, 71, 77)

  sound_df <- data.frame(
    pres = pres,
    hght = hght,
    temp = temp,
    dwpt = dwpt,
    relh = relh,
    mixr = mixr,
    drct = drct,
    sknt = sknt,
    thta = thta,
    thte = thte,
    thtv = thtv
  )

  sound_df[, 1:11] <- sapply(sound_df[,1:11], as.numeric)
  return(sound_df)
}
