#' Internal function - Download pollutant data from one air quality station
#'
#' @param aqs_code Air quality station code.
#' @param pol_code Pollutant code.
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#'
#' @return data.frame with the selected pollutant and air quality station
#' @noRd
#' @keywords internal

senamhi_retrieve <- function(aqs_code, pol_code, start_date, end_date){
  url <- paste0("https://www.senamhi.gob.pe/",
                "site/sea/www/site/sea/graficas/dato_hora.php")

  aqs_highchart <- httr::GET(url,
                             query = list(
                               estacion = aqs_code,
                               cont = pol_code,
                               f1 = start_date,
                               f2 = end_date
                             ))
  aqs_highchart_html <- XML::htmlParse(aqs_highchart)
  highchart_script <- XML::getNodeSet(aqs_highchart_html, "//script")[[3]]
  highchart_script_text <- utils::capture.output(highchart_script)

  # Getting AQS name
  aqs_text <- highchart_script_text[8]
  aqs_name <- unlist(strsplit(aqs_text, "text: "))[2]
  aqs_name <- gsub("\r", "", aqs_name)
  aqs_name <- unlist(strsplit(aqs_name, ": "))[-1]

  # Getting the dates
  date_text <- highchart_script_text[14]

  date_data <- unlist(strsplit(date_text, "categories: "))[2]
  date_data <- gsub("\\[", "", date_data)
  date_data <- gsub(",]\r", "", date_data)
  date_data <- gsub("'", "", date_data)
  date_data <- unlist(strsplit(date_data, ","))

  # Getting pol values
  if (pol_code == "N_NO2"){
    pol_text <- highchart_script_text[53]
  } else {
    pol_text <- highchart_script_text[44]
  }

  pol_data <- unlist(strsplit(pol_text, "data: "))[2]
  pol_data <- gsub("\\[", "", pol_data)
  pol_data <- gsub(",]\r", "", pol_data)
  pol_data <- unlist(strsplit(pol_data, ","))

  # Building data.frame
  if (length(date_data) != length(pol_data)){
    message("Something went wrong:")
    message(paste0("nrow(date_data): ", length(date_data)))
    message(paste0("nrow(pol_data): ", length(pol_data)))
  } else {
    aqs_df <- data.frame(
      date = as.POSIXct(
        strptime(date_data, format = "%d/%m/%Y%H:%M:"),
        tz = "America/Lima"
      ),
      pol = as.numeric(pol_data)
    )
  }

  # Completing missing dates with NA
  all_dates <- data.frame(
    date = seq(as.POSIXct(strptime(paste0(start_date, "_00:00"),
                                   format="%d/%m/%Y_%H:%M"),
                          tz="America/Lima"),
               as.POSIXct(strptime(paste0(end_date, "_23:00"),
                                   format="%d/%m/%Y_%H:%M"),
                          tz = "America/Lima"),
               by = "hour")
  )

  complete_df <- merge(all_dates, aqs_df, all = TRUE)

  # Adding aqs name
  complete_df$aqs <- aqs_name

  # A better pol column name
  pol_col_name <- tolower(gsub("N_", "", pol_code))
  colnames(complete_df)[2] <- pol_col_name

  return(complete_df)
}
