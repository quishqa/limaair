#' Export to csv
#' If to_df = FALSE it will write one file per element of list.
#'
#' @param aqs_codes A vector with station codes. See senamhi_aqs().
#' @param pol_codes A vector with pollutants codes. See senamhi_params().
#' @param start_date Date to start downloading in dd/mm/yyyy.
#' @param end_date Date to end downloading in dd/mm/yyyy.
#' @param to_df Returns a data.frame. FALSE by default.
#' @param csv_path Location to export csv. If empty csv_path = getwd()
#' @param aqs_data returned element from download_senamhi_pol()
#'
#' @return csv file
#' @noRd
#' @keywords internal
export_to_csv <- function(aqs_codes, pol_codes, start_date, end_date,
                          to_df, csv_path, aqs_data){
  if (csv_path == ""){
    csv_path <- paste0(getwd(), "/")
  }

  if (to_df) {
    file_name <- paste0(
      csv_path,
      paste(aqs_codes, collapse = "_"), "-"
    )
  } else {
    file_name <- paste0(
      csv_path,
      paste(aqs_codes), "-"
    )
  }

  file_name <- paste0(
    file_name,
    paste(pol_codes, collapse = "_"), "-",
    gsub("/", "", start_date), "-",
    gsub("/", "", end_date), ".csv"
  )

  # From:
  # paste0("https://stackoverflow.com/questions/19002378/",
  #         "applying-a-function-to-two-lists")
  if (to_df){
    utils::write.table(aqs_data, file = file_name, sep = ",", row.names = FALSE)
  } else {
    mapply(function(X,Y) {
      sapply(1:length(aqs_data),
             function(i) utils::write.table(aqs_data[i], file_name[i],
                                            sep = ",", row.names = FALSE))
    }, X=aqs_data, Y=file_name)
  }
}
