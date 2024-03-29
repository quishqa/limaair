#' Internal function - Download meteorological data from one automatic weather
#' station for a range of dates
#'
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param aws_code Automatic weather station (AWS) code.
#'
#' @return data.frame with one month of hourly data of temperature, precipitation,
#' relative humidity, wind speed and direction from one AWS
#' @noRd
#' @keywords internal
senamhi_retrieve_met_date <- function(start_date, end_date, aws_code){
  start <- as.POSIXct(strptime(start_date, format = "%d/%m/%Y"))
  end <- as.POSIXct(strptime(end_date, format = "%d/%m/%Y"))

  all_dates <- seq(start, end, by = "month")
  all_dates_month <- format(all_dates, "%Y%m")

  met_list <- lapply(all_dates_month, senamhi_retrieve_met, aws_code)
  met_df <- do.call(rbind, met_list)

  met_df$date <- paste(met_df$day, met_df$hour, sep = "_")
  met_df$date <- as.POSIXct(strptime(met_df$date, format = "%Y/%m/%d_%H:%M"))
  met_df <- met_df[c("date", names(met_df)[3:7])]
  met_df[, 2:6] <- sapply(met_df[, 2:6], as.numeric)

  all_dates_hour <- data.frame(
    date = seq(met_df$date[1], met_df$date[nrow(met_df)], by = "hour")
  )

  met_df_complete <- merge(all_dates_hour, met_df, all = T)
  met_df_complete$aqs <- aws_code

  return(met_df_complete)
}
