# limaair
 <!-- badges: start -->
  [![R-CMD-check](https://github.com/quishqa/limaair/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/quishqa/limaair/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

This package downloads pollutant data from the [SENAMHI air quality network](https://www.senamhi.gob.pe/?p=calidad-del-aire), meteorological data from [SENAMHI automatic weather staions](https://www.senamhi.gob.pe/servicios/?p=estaciones), and  sounding data from [Jorge Chávez airport](https://en.wikipedia.org/wiki/Jorge_Ch%C3%A1vez_International_Airport) located in Lima, capital of Peru.
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
`limaair` has three functions: 
 - **`download_senamhi_pol()`**.
 - **`download_senamhi_met()`**.
 - **`donwload_airport_sounding()`**

To use `download_senamhi_pol()`, you need the air quality station (AQS) code (`aqs_code`),
the pollutant code (`pol_code`),
and the start and end date of the download (`start_date` and `end_date`).
And, to use `download_senmahi_met()`, you need to know the automatic weather station (AWS) code 
(`aws_code`)

`limaair` has three datasets to check `aqs_code`, `pol_code`, and `aws_code` values:

```R
library(limaair)

# To check SENAMHI AQS code, name, latitude and longitude
senamhi_aqs

# To check SENAMHI AQS pollutant code, name and units
senamhi_params

# To check SENAMHI AWS code, name latitude and longitude
senamhi_aws
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
cm_sb_code <- c(112194, 112193)
pm_code <- c("N_PM25", "N_PM10")
start_date <- "01/01/2022"
end_date <- "07/01/2022"

cm_pm25 <- download_senamhi_pol(aqs_codes = cm_sb_code,
                                pol_codes = pm_code,
                                start_date = start_date,
                                end_date = end_date,
                                to_df = TRUE) # Look here!
```

### Downloading meteorological data  from automatic weather stations

Following the same philosophy as `download_senamhi_pol` function, you can use `download_senamhi_met`
to download data for Temperature (°C), Precipitation (mm/hour), Relative Humidity (%), Wind speed (m/s) and direction (°). You only need to know the `aws_code`, which for some cases is the same as the `aqs_code` (**except for Campo de Marte**). In this example, We download meteorological data 
for Campo de Marte AWS
```R
cm_code <- 112181 # senamhi_aws
start_date <- "01/01/2019"
end_date <- "28/02/2019"

cm_met <- download_senamhi_met(112181, "01/01/2019", "28/02/2019")
```
Like `download_senamhi_pol`, you can download data for multiple AWS.

### Downloading sounding data from Jorge Chavez airport

The `download_airport_sounding` function download sounding data from [Wyoming University sounding 
repository](https://weather.uwyo.edu/upperair/sounding.html). Default values are set for [Jorge 
Chavez International Airport](https://en.wikipedia.org/wiki/Jorge_Ch%C3%A1vez_International_Airport), so you can also use this function to download
sounding data  for other airports ;)
```R
# Downloading sounding for 15/01/2019 at 12z
jc_sounding <- download_airport_sounding("15/01/2019")
```

### Exporting to csv
If you prefer to process the data in another software,
you can export the downloaded data to a csv.
You just need to add the `to_csv` and `csv_path` arguments in `download_senamhi_pol` function.
If `to_df = TRUE`, then it will write a csv with the following name convention `{aqs_code1}_{aqs_code2}...{aqs_codeN}-{pol_code1}...{pol_codeN}-{start_date}-{end_date}.csv`

If `to_df = FALSE`, then it will create a csv for each station with the followingname convention `{aqs_code1-{pol_code1}...{pol_codeN}-{start_date}-{end_date}.csv`.

If `csv_path = ""` (the default value) then the csv will be saved in the working directory.

```R
cm_sb_code <- c(112194, 112193)
pm_code <- c("N_PM25", "N_PM10")
start_date <- "01/01/2022"
end_date <- "07/01/2022"

cm_pm25 <- download_senamhi_pol(aqs_codes = cm_sb_code,
                                pol_codes = pm_code,
                                start_date = start_date,
                                end_date = end_date,
                                to_df = TRUE,
                                to_csv = TRUE,
                                csv_path = "~/")
```

It will create the `112194_112193-N_PM25_N_PM10-01012022-07012022.csv` in the home directory.

# Caveat Emptor
According to SENAMHI, the data displayed in their site is **not validated data**, so you need to be careful and perform a data quality control methodology. You can do it!

# Acknowledgment
Thanks to SENAMHI for posting on-line their air quality data.
