get_pols_from_aqs <- function(aqs_code, pol_codes, start_date, end_date){
  aqs_data <- lapply(pol_codes, senamhi_retrieve,
                     aqs_code = aqs_code,
                     start_date = start_date,
                     end_date = end_date)

  aqs_data_df <- Reduce(merge, aqs_data)
  return(aqs_data_df)
}
