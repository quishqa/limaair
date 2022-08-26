#' Download meteorological data from SENAMHI automatic weather stations.
#'
#' This function download the data from automatic weather station (AWS)
#' described in aws_codes vector. It will return a complete dataset,
#' this means that missing pollutant data from missing hour is pad out with NA.
#'
#' @param aws_codes A vector with station codes. See senamhi_aws().
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param to_df Returns a data.frame. FALSE by default.
#' @param to_csv Export data to csv file. FALSE by default.
#' @param csv_path Location to export csv.
#' @param verbose Print query summary. TRUE by default.
#'
#' @return list where each element is an air quality station data
#' @export
#'
#' @examples
#' \dontrun{
#' # Download meteorological data from Campo de Marte and San Borja station
#' # from 01/02/2022 to 02/02/2022
#' aws_codes <- c(112181, 112193)
#' start_date <- "01/02/2022"
#' end_date <- "02/02/2022"
#'
#' cm_sb_data <- download_senamhi_met(aws_code, start_date, end_date)
#' }
download_senamhi_met <- function(aws_codes, start_date, end_date, to_df = FALSE,
                                 to_csv = FALSE, verbose = TRUE, csv_path = ""){

  # Showing query summary
  if (verbose){
    message("Your query is:")
    message("Automatic weather stations: ", paste(aws_codes, collapse = ", "))
    message("From ", start_date, " to ", end_date)
  }

  met_data <- lapply(aws_codes, senamhi_retrieve_met_date,
                     start_date = start_date, end_date = end_date)

  if (to_df) {
    met_data <- do.call(rbind, met_data)
  }

  if (length(met_data) == 1){
    met_data <- met_data[[1]]
  }


  if (to_csv){
    col_names <- names(met_data[[1]])[2:6]
    export_to_csv(aws_codes, col_names, start_date, end_date,
                  to_df, csv_path, met_data)
  }
  return(met_data)
}
