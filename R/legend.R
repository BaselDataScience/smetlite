# list of permissible tiem and measurement variables
legend <- list(
  P="Air pressure, in Pa",
  TA="Temperature Air, in Kelvin",
  TSS="Temperature Snow Surface, in Kelvin",
  TSG="Temperature Surface Ground, in Kelvin",
  RH="Relative Humidity, between 0 and 1",
  VW_MAX="Maximum wind velocity, in m/s",
  VW="Velocity Wind, in m/s DW Direction Wind, in degrees, clockwise and north being zero degrees",
  ISWR="Incoming Short Wave Radiation, in W/m2",
  OSWR="Reflected Short Wave Radiation, in W/m2",
  ILWR="Incoming Long Wave Radiation, in W/m2",
  OLWR="Outgoing Long Wave Radiation, in W/m2",
  PINT="Precipitation Intensity, in mm/h, as an average over the timestep",
  PSUM="Precipitation accumulation, in mm, summed over the last timestep",
  HS="Height Snow, in m",
  timestamp="ISO 8601 Combined date and time formatted",
  julian="as the decimal number of days and fractions of a day since January 1, 4713 BC Greenwich noon, Julian proleptic calendar3. If both timestamps and julian are present, they must be within less than 1 second of each other."
)
