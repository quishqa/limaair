test_that("download_senamhi_pol works in jan and feb!",{

  aqs_codes <- c(112194, 112193)
  pol_codes <- c("N_PM25", "N_PM10")
  start_date <- "01/01/2019"
  end_date <- "28/02/2019"

  all_date <- seq(as.POSIXct("2019-01-01 00:00", tz = "UTC"),
                  as.POSIXct("2019-02-28 23:00", tz = "UTC"),
                  by = "hour")
  pm_data <- download_senamhi_pol(aqs_codes, pol_codes, start_date, end_date,
                                  to_df = TRUE)

  expect_equal(2 * length(all_date), nrow(pm_data))
})
