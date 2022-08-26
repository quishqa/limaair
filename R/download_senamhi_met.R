download_senamhi_met <- function(aqs_codes, start_date, end_date,
                                 to_df = FALSE, to_csv = FALSE, verbose = TRUE){
  met_data <- lapply(aqs_codes, senamhi_retrieve_met_date,
                     start_date = start_date, end_date = end_date)

  if (to_df) {
    met_data <- do.call(rbind, met_data)
  }

  if (length(met_data) == 1){
    met_data <- met_data[[1]]
  }


  if (to_csv){
    col_names <- names(met_data[[1]])[2:6]
    export_to_csv(aqs_codes, col_names, start_date, end_date,
                  to_df, csv_path, met_data)
  }
  return(met_data)
}
