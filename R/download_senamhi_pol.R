download_senamhi_pol <- function(aqs_codes, pol_codes, start_date, end_date,
                                 to_df = FALSE){
  aqs_data <- lapply(aqs_codes, get_pols_from_aqs,
                     pol_codes = pol_codes,
                     start_date = start_date,
                     end_date = end_date)
  if (to_df){
    aqs_data <- do.call(rbind, aqs_data)
  }

  return(aqs_data)
}
