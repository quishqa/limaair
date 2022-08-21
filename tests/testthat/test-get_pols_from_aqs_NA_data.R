test_that("download_senamhi_pol works with data and no-data cases!",{
  cm_code <- 112194

  # There is no CO data in this date range but there is
  # PM25 data
  start_date <- "10/08/2022"
  end_date <- "19/08/2022"
  pol_code <- c("N_CO", "N_PM25")

  all_hours <- seq(as.POSIXct("2022-08-10 00:00", tz = "UTC"),
                   as.POSIXct("2022-08-19 23:00", tz = "UTC"),
                   by = "hour")

  cm_co_pm25 <- get_pols_from_aqs(cm_code, pol_code, start_date, end_date)
  expect_equal(nrow(cm_co_pm25), length(all_hours))
})
