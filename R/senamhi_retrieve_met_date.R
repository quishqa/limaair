senamhi_retrieve_met_date <- function(start_date, end_date, aqs_code){
  start <- as.POSIXct(strptime(start_date, format = "%d/%m/%Y"))
  end <- as.POSIXct(strptime(end_date, format = "%d/%m/%Y"))

  all_dates <- seq(start, end, by = "month")
  all_dates_month <- format(all_dates, "%Y%m")

  met_list <- lapply(all_dates_month, senamhi_retrieve_met, aqs_code)
  met_df <- do.call(rbind, met_list)

  met_df$date <- paste(met_df$day, met_df$hour, sep = "_")
  met_df$date <- as.POSIXct(strptime(met_df$date, format = "%Y/%m/%d_%H:%M"))
  met_df <- met_df[c("date", names(met_df)[3:7])]
  met_df[, 2:6] <- sapply(met_df[, 2:6], as.numeric)

  # TODO: Pad out missing hours with NA

  return(met_df)
}
