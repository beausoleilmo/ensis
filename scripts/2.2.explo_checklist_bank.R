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
source("scripts/1.0read_wild_species_dat.R")

# Télécharger des données
# https://www.checklistbank.org/dataset/313811/download
# DwCA
# quebecensis
# Species
# Exclude synonyms
# Bánki, O., Roskov, Y., Döring, M., Ower, G., Hernández Robles, D. R., Plata Corredor, C. A., Stjernegaard Jeppesen, T., Örn, A., Pape, T., Hobern, D., Garnett, S., Little, H., DeWalt, R. E., Miller, J., Orrell, T., Aalbu, R., Abbott, J., Abreu, C., Acero P, A., et al. (2026). Catalogue of Life (2026-01-16 XR). Catalogue of Life Foundation, Amsterdam, Netherlands. https://doi.org/10.48580/dgw64
# datasetKey: 313811
# synonyms: false
# bareNames: false
# format: dwca
# tabFormat: tsv
# excel: false
# extended: false
# classification: true

# Tableau de 1.25 GB.

# Recherche mots dans document et exporte en fichier texte
# INPUTGREP="/Volumes/g_magni/Catalogue_of_life/b6264824-58e5-421a-9034-214c838bb53f/dataset-313811.tsv"
# PATTT="quebecensis|gaspensis|abitibiensis|gatineauensis|^bicensis|chicoutimiensis|chimoensis|gaspeensis|gaspesiensis|lanoraieensis|yamaskanensis|yamaskensis"
# grep -E $PATTT $INPUTGREP > data/sp_list_chb.txt
# En-tête du tableau
# head -n1 $INPUTGREP > data/sp_list_chb_head.txt
# head -n10 $INPUTGREP

# INPUTGREP="/Volumes/g_magni/Catalogue_of_life/49309c32-3285-4c9d-93f3-d01967966bd1/Taxon.tsv"
# grep -E $PATTT $INPUTGREP > data/sp_list_chb.txt
# cat $INPUTGREP | head -n10

# Extraire Espèce du rang taxonomique == espèce (pas nécessaire)
# cat $INPUTGREP | awk -F'\t' '$5 == "species" {print $6}' > data/sp_list_col_CLB.csv

# Liste d'espèces généré par IA
# à partirt des noms
sp_names <- read.csv(
  header = FALSE,
  file = "data/sp_list_chb.txt", sep = "\t"
)
cl_names <- read.csv(
  header = TRUE,
  file = "data/sp_list_chb_head.txt", sep = "\t",
)
names(sp_names) <- names(cl_names)

sp_names |>
  # Retirer les unranked
  filter(V8 != "unranked") |>
  # Sélectionne quelque colonnes
  dplyr::select(V7:V16, V20:V31) |>
  # En ordre
  arrange(V9)

sp_names |>
  # Retirer les unranked
  filter(dwc.taxonRank != "unranked") |>
  # Sélectionne quelque colonnes
  dplyr::select(dwc.taxonRank, dwc.scientificName) |>
  # En ordre
  arrange(dwc.scientificName)
