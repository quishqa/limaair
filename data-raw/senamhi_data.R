## code to prepare `senamhi_data` dataset goes here
senamhi_aqs <- data.frame(
  aqs = c("Campo de marte", "San Martin de Porres", "San Borja",
          "Villa Maria del Triunfo", "Santa Anita", "San Juan de Lurigancho",
          "Carabayllo", "Ceres"),
  code = c(112194, 112265, 112193,
           112233, 112208, 112267,
           111286, 112275),
  lat = c(-12.07054, -12.00889, -12.0859,
          -12.16639, -12.04302, -11.98164,
          -11.90219, -12.02869),
  lon = c(-77.04322, -77.08447, -77.00769,
          -76.92000, -76.97144, -76.99925,
          -77.03364, -76.92706)
)

senamhi_aws <- data.frame(
  aqs = c("Antonio Raimondi", "Nana", "Von Humboldt",
          "Campo de marte"),
  code = c("472A218A", 111290, "472AC278", 112181),
  lat = c(-(11 + (46 + 33.80 / 60) / 60),
          -(11 + (59 + 14.94 / 60) / 60),
          -(12 + (4. + 55.95 / 60) / 60),
          -12.07054),
  lon = c(-(77 + (46 + 33.80 / 60) / 60),
          -(76 + (50 + 30.94 / 60) / 60),
          -(76 + (56 + 21.98 / 60) / 60),
          -77.04322)
)
# Campo de Marte meteorological station has a different code
senamhi_aws <- rbind(senamhi_aws, senamhi_aqs[-1,])

senamhi_params <- data.frame(
  code = c("N_PM10", "N_PM25", "N_SO2",
           "N_NO2", "N_O3", "N_CO"),
  name = c("Inhalable particles", "Fine Inhalable particles",
           "Sulfur dioxide", "Nitrogen dioxide", "Ozone",
           "Carbon monoxide"),
  units = rep("ug/m3", 6)
)

usethis::use_data(senamhi_aqs, senamhi_aws,
                  senamhi_params, overwrite = TRUE)
