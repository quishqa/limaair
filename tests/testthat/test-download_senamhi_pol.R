test_that("download_senamhi_pol works!", {

  cm_sb_codes <- c(112194, 112193)
  pm_codes <- c("N_PM25", "N_PM10")
  start_date <- "01/01/2022"
  end_date <- "31/01/2022"

  cm_sb_pm <- download_senamhi_pol(cm_sb_codes, pm_codes, start_date, end_date,
                                   to_df = TRUE)

  # Testing two different aqs
  expect_equal(length(unique(cm_sb_pm$aqs)), length(cm_sb_codes))

  # Testing data.frame dims
  expect_equal(ncol(cm_sb_pm), 4)
  expect_equal(nrow(cm_sb_pm), 1488)

  # Testing classes
  expect_equal(class(cm_sb_pm), "data.frame")
  expect_equal(class(cm_sb_pm$aqs), "character")
  expect_equal(class(cm_sb_pm$pm10), "numeric")
  expect_equal(class(cm_sb_pm$pm25), "numeric")
  expect_equal(TRUE, "POSIXct" %in% class(cm_sb_pm$date))

})
