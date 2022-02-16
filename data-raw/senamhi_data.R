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

senamhi_params <- data.frame(
  code = c("N_PM10", "N_PM25", "N_SO2",
           "N_NO2", "N_O3", "N_CO"),
  name = c("Inhalable particles", "Fine Inhalable particles",
           "Sulfur dioxide", "Nitrogen dioxide", "Ozone",
           "Carbon monoxide"),
  units = rep("ug/m3", 6)
)

usethis::use_data(senamhi_aqs, senamhi_params, overwrite = TRUE)
