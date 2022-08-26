#' Internal function - Download meteorological data from one automatic weather
#'  station for one month
#'
#' @param year_month Date to download in %Y%m format.
#' @param aws_code Automatic weather station (AWS) code.
#'
#' @return data.frame with one month of hourly data of temperature, precipitation,
#' relative humidity, wind speed and direction from one AWS
#' @noRd
#' @keywords internal
senamhi_retrieve_met <- function(year_month, aws_code){
  url <- paste0("https://www.senamhi.gob.pe/servicios/maps/mapa-estaciones/",
                "_dato_esta_tipo02.php")
  aqs_table <- httr::GET(url,
                         query=list(
                           estaciones = aws_code,
                           CBOFiltro = year_month,
                           t_e = "M",
                           estado = "AUTOMATICA",
                           cod_old = "",
                           cate_esta = "EMA",
                           alt = 247
                         ))
  aqs_table_html <- XML::htmlParse(aqs_table)
  aqs_table_html_table <- XML::getNodeSet(aqs_table_html, "//table")
  data <- XML::readHTMLTable(aqs_table_html_table[[2]])

  date <- as.POSIXct(strptime(paste0(year_month, "01"), format = "%Y%m%d"))
  date_months <- seq(date, length.out = 2, by = "month")
  days <- as.numeric(as.Date(date_months[2]) - as.Date(date_months[1]))
  all_dates <- seq(date, length.out = days * 24, by = "hour")
  day <- format(all_dates, "%Y/%m/%d")
  hour <- format(all_dates, "%H:%M")

  if (is.null(data)){
    message("No data available, padding out with NA")
    data <- data.frame(
      day = day, hour = hour, tc = NA, prec = NA, rh = NA, wd = NA, ws = NA
    )
  }

  col_names <- c("day", "hour", "tc", "prec", "rh", "wd", "ws")
  names(data) <- col_names
  return(data)
}

