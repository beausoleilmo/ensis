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
  )

sp_names |>
  arrange(continent, country, type, latin)

sp_names |>
  group_by(continent, country, type) |>
  distinct(latin) |>
  count()

# canadensis --------------------------------------------------------------
wsc_csis <- wsc_l |>
  filter(grepl(
    pattern = "canadensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  ))

# Compte des groupes taxonomiques avec canadensis
wsc_csis |>
  count(`TAXONOMIC GROUP - GROUPE TAXONOMIQUE`) |>
  arrange(desc(n))


# quebecensis --------------------------------------------------------------
wsc_qcsis <- wsc_l |>
  filter(grepl(
    pattern = "quebecensis",
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  ))

# Compte des groupes taxonomiques avec canadensis
nb_sp_qcensis <- wsc_qcsis |>
  count(`TAXONOMIC GROUP - GROUPE TAXONOMIQUE`) |>
  arrange(desc(n))

nb_sp_qcensis

sum(nb_sp_qcensis$n)

# Extraction des noms à valider selon le filtre spatial
pattern_ensis <- "quebecensis|gaspensis|abitibiensis|gatineauensis|bicensis|chicoutimiensis|chimoensis|gaspeensis|gaspesiensis|lanoraieensis|yamaskanensis|yamaskensis"
sp_qc <- wsc_l |>
  filter(grepl(
    pattern = pattern_ensis,
    x = wsc_l$`SCIENTIFIC NAME - NOM SCIENTIFIQUE`
  ))

sp_qc |>
  count(`TAXONOMIC GROUP - GROUPE TAXONOMIQUE`) |>
  arrange(desc(n))

sp_search <- sp_qc |>
  count(`SCIENTIFIC NAME - NOM SCIENTIFIQUE`) |>
  pull(`SCIENTIFIC NAME - NOM SCIENTIFIQUE`)

for (sp_search_i in seq_along(sp_search)) {
  message(sprintf("%d", sp_search_i))
  browseURL(sprintf("https://www.google.com/search?q=%s", sp_search[sp_search_i]))
  Sys.sleep(10)
}

# Espèces endémiques de Galápagos, d'autre qui feraient rêvés en couleurs (avec )
# Acantholyda chicoutimiensis
# Agriotes quebecensis --> taupin du Québec ! -> voir à quoi il ressemble https://www.inaturalist.org/taxa/212851-Agriotes-quebecensis
# Amelanchier gaspensis
# Aleiodes quebecensis - Quebec Mummy Wasp
# Ampedus quebecensis
# Anania quebecensis
# Aspicilia bicensis --> 2016!! https://bioone.org/journals/the-bryologist/volume-119/issue-1/0007-2745-119.1.008/Aspicilia-bicensis-Megasporaceae-a-new-sterile-pustulose-lichen-from-eastern/10.1639/0007-2745-119.1.008.short
# Boechera quebecensis --> endémique! https://www.canada.ca/en/environment-climate-change/services/species-risk-public-registry/cosewic-assessments-status-reports/quebec-rockcress-2017.html
# Botanophila abitibiensis
# Callophrys lanoraieensis
# Cixius quebecensis
# Claremontia quebecensis
# Euxoa chimoensis
# Euxoa quebecensis # Pas dans Livre de Handfield Anania quebecensis et Euxoa quebecensis pas plante hôte connu.
# Eylais abitibiensis
# Formicoxenus quebecensis --> endémique! https://en.wikipedia.org/wiki/Formicoxenus_quebecensis
# Gyponana quebecensis
# Leiodes quebecensis
# Leptusa gatineauensis
# Melanoplus gaspesiensis
# Micranthes gaspensis
# Myrmecocephalus gatineauensis
# Myrmica quebecensis --> https://antwiki.org/wiki/Myrmica_quebecensis
# Neogalerucella quebecensis
# Neurocordulia yamaskanensis
# Oncopsis quebecensis
# Onycholyda quebecensis
# Pallicephala quebecensis
# Psilocybe quebecensis --> https://link.springer.com/article/10.1007/BF02050725
# Rhithrogena gaspeensis
# Siphlonurus quebecensis
# Stenus quebecensis
# Tachinus quebecensis
# Tapinotorquis yamaskensis
# Triglochin gaspensis
# Wandesia gaspensis
# Xestobium gaspensis



# Scaphytopius magdalensis Provancher, 1889 --> pas au qc? voir Provancher, L. (1889a) Deuxième sous-ordre les Homoptères. Petite Faune Entomologique du Canada, précédée d'un Traité elémentaire d'Entomologie., 3, 207–292.
# En fait c'est Magdalena (Colombia) https://hoppers.speciesfile.org/otus/31056/overview

# magdalensis, timiskamingensis
