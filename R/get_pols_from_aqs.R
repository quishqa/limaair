#' Internal function - Download many pollutant from one air quality station
#'
#' @param aqs_code Air quality station code.
#' @param pol_codes A vector with pollutant codes.
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#'
#' @return data.frame with polluntants from pol_codes
#' @noRd
#'
#' @keywords internal
get_pols_from_aqs <- function(aqs_code, pol_codes, start_date, end_date){
  aqs_data <- lapply(pol_codes, senamhi_retrieve,
                     aqs_code = aqs_code,
                     start_date = start_date,
                     end_date = end_date)

  aqs_data_df <- Reduce(merge, aqs_data)
  return(aqs_data_df)
}
