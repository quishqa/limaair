test_that("senamhi_retrieve works when there is no data!", {
  cm_code <- 112194

  # There is no CO data in this date range
  start_date <- "10/08/2022"
  end_date <- "19/08/2022"
  co_code <- "N_CO"

  all_hours <- seq(as.POSIXct("2022-08-10 00:00", tz = "UTC"),
                   as.POSIXct("2022-08-19 23:00", tz = "UTC"),
                   by = "hour")

  cm_co <- senamhi_retrieve(cm_code, co_code, start_date, end_date)
  expect_equal(nrow(cm_co), length(all_hours))
})
