#' SENAMHI AQS station latitude and longitude
#'
#' SENAMHI air quality stations (AQS) latitudes and longitudes.
#' Use this to check the AQS \code{aqs_codes} argument in
#' \code{download_senamhi_pol()}.
#' #'
#' @format A data frame with 8 observations and 4 variables:
#' \describe{
#' \item{aqs}{SENAMHI AQS name.}
#' \item{code}{SENAMHI AQS code.}
#' \item{lat}{SENAMHI AQS latitude.}
#' \item{lon}{SENAMHI AQS longitude.}
#' }
#' @examples
#' senamhi_aqs
"senamhi_aqs"

#' SENAMHI pollutant
#'
#' SENAMHI air quality stations pollutants.
#' Use this to check the \code{pol_codes} argument in
#' \code{download_senamhi_pol()}.
#' #'
#' @format A data frame with 6 observations and 3 variables:
#' \describe{
#' \item{code}{SENAMHI pollutant code.}
#' \item{name}{SENAMHI pollutant name.}
#' \item{units}{Pollutant unit.}
#' }
#' @examples
#' senamhi_params
"senamhi_params"
