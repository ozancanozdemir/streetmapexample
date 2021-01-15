library(tidyverse)
library(osmdata)

# Conseguir coordenadas para ggplot
getbb("Ankara,Turkey")
min       max
x -3.700362 -3.496324
y 37.136703 37.225017

x 32.69401 33.01401
y 39.76075 40.08075

# Extraer lugares del mapa
streets <- getbb("Ankara,Turkey") %>%
  opq() %>%
  add_osm_feature(key = "highway", value = c("motorway", "primary", "secondary", "tertiary")) %>%
  osmdata_sf()

small_streets <- getbb("Ankara,Turkey") %>%
  opq() %>%
  add_osm_feature(key = "highway", value = c("residential", "living_street", "unclassified", "service", "footway")) %>%
  osmdata_sf()

river <- getbb("Ankara,Turkey") %>%
  opq() %>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

ggplot() +
  # Calles
  geom_sf(data = streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .4, alpha = .8) +
  # Pequeñas calles
  geom_sf(data = small_streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .2, alpha = .8) +
  # Ríos
  geom_sf(data = river$osm_lines, inherit.aes = FALSE, color = "#7fc0ff", size = .8, alpha = .5) +
  # Límites del mapa en coordenadas
  coord_sf(xlim = c(32.5, 33.1), ylim = c(39.76, 40.1), expand = FALSE) +
  theme_void() + 
  # Añadir color de fondo
  theme(plot.background = element_rect(fill = "#282828"))


ggsave("ankara.png", width = 6, height = 6)
