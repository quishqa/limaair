#' Download pollutant data from SENAMHI air quality stations.
#'
#' This function download many pollutant from pol_codes vector from
#' the air quality stations described in aqs_codes vector. It will
#' return a complete dataset, this means that missing pollutant data
#' from missing hour is pad out with NA.
#'
#' @param aqs_codes A vector with station codes. See senamhi_aqs().
#' @param pol_codes A vector with pollutants codes. See senamhi_params().
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
#' # Download PM10 and PM2.5 from Campo de Marte and San Borja station
#' # from 01/02/2022 to 02/02/2022
#' aqs_codes <- c(112194, 112193)
#' pol_codes <- c("N_PM10", "N_PM25")
#' start_date <- "01/02/2022"
#' end_date <- "02/02/2022"
#'
#' pm_data <- download_senamhi_data(aqs_code, pol_codes, start_date, end_date)
#' }
download_senamhi_pol <- function(aqs_codes, pol_codes, start_date, end_date,
                                 to_df = FALSE, to_csv=FALSE, csv_path = "",
                                 verbose = TRUE){
  # Showing query summary
  if (verbose){
    message("Your query is:")
    message("Pollutant: ", paste(pol_codes, collapse = ", "))
    message("Air quality stations: ", paste(aqs_codes, collapse = ", "))
    message("From ", start_date, " to ", end_date)
  }

  # Downloading data
  aqs_data <- lapply(aqs_codes, get_pols_from_aqs,
                     pol_codes = pol_codes,
                     start_date = start_date,
                     end_date = end_date)
  # As data.frame
  if (to_df){
    aqs_data <- do.call(rbind, aqs_data)
  }

  if (length(aqs_data) == 1){
    aqs_data <- aqs_data[[1]]
  }

  # To csv
  if (to_csv){
    export_to_csv(aqs_codes, pol_codes, start_date, end_date,
                  to_df, csv_path, aqs_data)
  }

  return(aqs_data)
}
