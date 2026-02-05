## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
##
##
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# date création: 2026-01-29
# auteur: Marc-Olivier Beausoleil

## ____________####
## Lisez-moi --------
#   -->

## ____________####
## Prépare l'environnement --------
source("scripts/0.init.R")


## ____________####
## Charge données --------
source("scripts/1.read_wild_species_dat.R")

# Voir tous les -ensis possible
#
sp_epic <- wsc_l |>
  filter(grepl(
    pattern = "ensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  )) |>
  dplyr::select(
    `TAXONOMIC GROUP - GROUPE TAXONOMIQUE`,
    `SCIENTIFIC NAME - NOM SCIENTIFIQUE`,
    sp_epithet
  ) |>
  count(sp_epithet) |>
  arrange(desc(n))

# from the file list_species_translate.csv with species epithet (-ensis) names in the species column, find the corresponding place or location in the 'latin' column. For example, canadensis would be 'Canada'. In the 'type' column state the spatial resolution c('Country', 'Province', 'State', etc,). Add the 'continent' in a new column from this csv. Provide the complete CSV
# From this csv, add a column in which country is found the information in the 'latin' column. Also, for all the 'latin' that is Unknown, find a place where the species name ('species' column) is referring to. fill the latin, type, continent and country column. please provide only true information

dfout <- data.frame(sp = sp_epic$sp_epithet, latin = "", type = "", continent = "", country = "")
write.csv(dfout, file = "output/list_sp_translate.csv", row.names = FALSE)

# from the file species_list_with_country.csv with species epithet (-ensis) names in
# the 'species' column, update the 'continent', and 'country' columns so that it is congruent with the 'latin' column if needed.
# From this csv, add a column in which administrative division (named admin_reg) within a country (province or state). So if the 'latin' value is 'quebecensis' ou 'lanoraieensis', admin_reg  = "Quebec".
# Provide only true information
# Provide the complete CSV

# from the file species_lst_can.csv use the 'latin', 'type' and 'country' and find an longitude latitude in 4326 for elements that are spatial. Provide the complete CSV

# Liste d'espèces généré par IA
# à partirt des noms
sp_names <- read.csv(
  file = "output/species_list_with_country.csv"
)
sp_names |>
  filter(
    continent == "North America",
    country %in% c("Canada")
  ) |>
  mutate(
    longitude = "",
    latitude = ""
  ) |>
  write.csv(file = "output/species_lst_can.csv", row.names = FALSE)


sp_spa <- read.csv(
  file = "output/species_lst_can_with_coords.csv"
)

adminqc <- st_read("~/Github_proj/evologie/posts/guide_biodiv_qc/2025_05_24_Guide_biodiv_qc/data/partie_1/admin_geo/admin_reg_qc/mrc_s.gpkg")

sp_sf <- st_as_sf(x = sp_spa, coords = c("longitude", "latitude"), crs = 4326) |>
  st_transform(crs = st_crs(adminqc))

sp_sf_filt <- sp_sf |>
  st_filter(adminqc)

sp_sf_filt |>
  pull(sp) |>
  paste0(collapse = "|")

mapview::mapview(adminqc)
mapview::mapview(sp_sf_filt, zcol = "latin")
