senamhi_retrieve_met <- function(year_month, aqs_code){
  url <- paste0("https://www.senamhi.gob.pe/servicios/maps/mapa-estaciones/",
                "_dato_esta_tipo02.php")
  aqs_table <- httr::GET(url,
                         query=list(
                           estaciones = aqs_code,
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

  if (is.null(data)){
    data <- data.frame(
      day = NA, hour = NA, tc = NA, prec = NA, rh = NA, wd = NA, ws = NA
    )
  }

  col_names <- c("day", "hour", "tc", "prec", "rh", "wd", "ws")
  names(data) <- col_names
  return(data)
}

