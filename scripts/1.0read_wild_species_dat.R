## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
##
##
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# date création: 2026-02-04
# auteur: Marc-Olivier Beausoleil

## ____________####
## Lisez-moi --------
#   -->

## ____________####
## Prépare l'environnement --------
source("scripts/0.init.R")

## ____________####
## Charge données --------
# https://www.wildspecies.ca/reports
# includes some conservation status ranks
# of the biggest effort in building a unified species list in Canada.
wsc <- "data/Wild Species 2020 Data - Espèces sauvages 2020 Données.xlsx"
wsc_l <- read_xlsx(
  path = wsc,
  sheet = "Ranks - Rangs"
) |>
  mutate(
    # extraction de l'épithète spécifique (2e mot du nom d'espèce)
    sp_epithet = stringr::word(`SCIENTIFIC NAME - NOM SCIENTIFIQUE`,
      start = 2, end = 2
    )
  )

message("Read 'Wild Species 2020' as wsc_l")
