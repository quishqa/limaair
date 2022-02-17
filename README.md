# limaair

This package downloads pollutant data from the [SENAMHI air quality network](https://www.senamhi.gob.pe/?p=calidad-del-aire) located in Lima, capital of Peru.
The returned `data.frame` is a complete dataset.
This means that missing data by missing hours is padded out by `NA`.

## Installation

To install `limaair` you need first to install `devtools`.
You can do it by:

```R
install.package("devtools")
```

Then install `limaair` by:
```R
devtools::install_github("quishqa/limaair")
```

## How to use
`limaair` (until now) has one function: **`download_senamhi_pol()`**.

To use it, you need the air quality station (AQS) code (`aqs_code`),
the pollutant code (`pol_code`),
and the start and end date of the download (`start_date` and `end_date`).

`limaair` has two datasets to check `aqs_code` and `pol_code` values:

```R
library(limaair)

# To check SENAMHI AQS code, name, lat and lon
senamhi_aqs

# To check SENAMHI AQS pollutant code, name and units
senamhi_params
```

## Examples
### Downloading one pollutant from one station
In this example we'll download fine particle concentrations (PM2.5) from Campo de Marte station, from January 1st to January 7th of 2022.
Here  how you do it.

```R
library(limaair)

senamhi_aqs # To check Campo de Marte
senamhi_params # To check PM25 code

cm_code <- 112194
pm25_code <- "N_PM25"
start_date <- "01/01/2022"
end_date <- "07/01/2022"

cm_pm25 <- download_senamhi_pol(aqs_codes = cm_code,
                                pol_codes = pm25_code,
                                start_date = start_date,
                                end_date = end_date)

```

### Download many pollutants from many stations
Maybe you need to compare data from different stations for different pollutant. You can do it with the same `download_senamhi_pol` function. `aqs_codes` and `pol_codes` can be a vector with the AQS and pollutant codes!.
In this example we'll download PM25 and PM10 from Campo de Marte and San Borja stations.

```R
library(limaair)

senamhi_aqs # To check Campo de Marte and San Borja station codes
senamhi_params # To check PM25 and PM10 codes

cm_sb_code <- c(112194, 112193)
pm_code <- c("N_PM25", "N_PM10")
start_date <- "01/01/2022"
end_date <- "07/01/2022"

cm_pm25 <- download_senamhi_pol(aqs_codes = cm_sb_code,
                                pol_codes = pm_code,
                                start_date = start_date,
                                end_date = end_date)

```
Voilà! In this case `download_senamhi_pol`returns a **`list`** with two data frames (one for each station). Each data frame has a column for each pollutant. If you prefer one **`data.frame`**  returned instead of a list (i.e. both data frames combined by row), you can just use **`to_df = TRUE`** argument:

```R
cm_pm25 <- download_senamhi_pol(aqs_codes = cm_sb_code,
                                pol_codes = pm_code,
                                start_date = start_date,
                                end_date = end_date,
                                to_df = TRUE) # Look here!
```

# Caveat Emptor
According to SENAMHI, the data displayed in their site is **not validated data**, so you need to be careful and perform a data quality control methodology. You can do it!

# Acknowledgment
Thanks to SENAMHI for posting on-line their air quality data.
