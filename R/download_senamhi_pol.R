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
#' @param to_df Returns a data.frame
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
                                 to_df = FALSE){
  aqs_data <- lapply(aqs_codes, get_pols_from_aqs,
                     pol_codes = pol_codes,
                     start_date = start_date,
                     end_date = end_date)
  if (to_df){
    aqs_data <- do.call(rbind, aqs_data)
  }

  if (length(aqs_data) == 1){
    aqs_data <- aqs_data[[1]]
  }

  return(aqs_data)
}
