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
  View()

sp_names |>
  arrange(continent, country, type, latin) |>
  View()


sp_namescontinentsp_names |>
  group_by(continent, country, type) |>
  distinct(latin) |>
  count() |>
  View()


# canadensis --------------------------------------------------------------
wsc_csis <- wsc_l |>
  filter(grepl(
    pattern = "canadensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  ))

# Compte pour tous les groupes
wsc_csis |>
  count(`TAXONOMIC GROUP - GROUPE TAXONOMIQUE`) |>
  arrange(desc(n))


# quebecensis --------------------------------------------------------------
wsc_qcsis <- wsc_l |>
  filter(grepl(
    pattern = "quebecensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  ))

# Nombre d'espèces
nb_sp_qcensis <- wsc_qcsis |>
  count(`TAXONOMIC GROUP - GROUPE TAXONOMIQUE`)

nb_sp_qcensis

sum(nb_sp_qcensis$n)

# Espèces endémiques de Galápagos, d'autre qui feraient rêvés en couleurs (avec )
# Boechera quebecensis --> endémique! https://www.canada.ca/en/environment-climate-change/services/species-risk-public-registry/cosewic-assessments-status-reports/quebec-rockcress-2017.html
# Psilocybe quebecensis --> https://link.springer.com/article/10.1007/BF02050725
# Agriotes quebecensis --> taupin du Québec
# Formicoxenus quebecensis --> endémique! https://en.wikipedia.org/wiki/Formicoxenus_quebecensis
# Myrmica quebecensis --> https://antwiki.org/wiki/Myrmica_quebecensis
# Pas dans Livre de Handfield Anania quebecensis et Euxoa quebecensis pas plante hôte connu.
# Aspicilia bicensis --> 2016!! https://bioone.org/journals/the-bryologist/volume-119/issue-1/0007-2745-119.1.008/Aspicilia-bicensis-Megasporaceae-a-new-sterile-pustulose-lichen-from-eastern/10.1639/0007-2745-119.1.008.short

wsc_l |>
  filter(grepl(
    pattern = "quebecensis|gaspensis|abitibiensis|gatineauensis|bicensis|chicoutimiensis|chimoensis|gaspeensis|gaspesiensis|lanoraieensis|magdalensis|timiskamingensis|yamaskanensis|yamaskensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  )) |>
  View()
