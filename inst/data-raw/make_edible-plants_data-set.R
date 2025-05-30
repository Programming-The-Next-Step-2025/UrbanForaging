# ---------------------------------------------------------------------------
# Create edible-plants lookup table and save as CSV
# ---------------------------------------------------------------------------

library(tibble)   # for tribble()
library(readr)    # for write_csv()

plants_df <- tribble(
  ~label,           ~sci,                   ~img,                                                                                          ~infourl,
  "Wild garlic",    "Allium ursinum",       "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Bear_Garlic.JPG/120px-Bear_Garlic.JPG",      "https://en.wikipedia.org/wiki/Allium_ursinum",
  "Elderflower",    "Sambucus nigra",       "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Sambucus_nigra_02.JPG/120px-Sambucus_nigra_02.JPG", "https://en.wikipedia.org/wiki/Sambucus_nigra",
  "Common nettle",  "Urtica dioica",        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Urtica_dioica.jpg/120px-Urtica_dioica.jpg",         "https://en.wikipedia.org/wiki/Urtica_dioica",
  "Dandelion",      "Taraxacum officinale", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Taraxacum_officinale_dandelion.jpg/120px-Taraxacum_officinale_dandelion.jpg", "https://en.wikipedia.org/wiki/Taraxacum_officinale",
  "Blackberry",     "Rubus fruticosus",     "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Rubus_fruiticosus.jpg/120px-Rubus_fruiticosus.jpg", "https://en.wikipedia.org/wiki/Rubus_fruticosus",
  "Wild strawberry","Fragaria vesca",       "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Fragaria_vesca_2.jpg/120px-Fragaria_vesca_2.jpg",   "https://en.wikipedia.org/wiki/Fragaria_vesca",
  "Beech nut",      "Fagus sylvatica",      "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Beechnuts_Fagus_sylvatica.jpg/120px-Beechnuts_Fagus_sylvatica.jpg", "https://en.wikipedia.org/wiki/Fagus_sylvatica",
  "Hazelnut",       "Corylus avellana",     "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Hazelnut_fruits.jpg/120px-Hazelnut_fruits.jpg",     "https://en.wikipedia.org/wiki/Corylus_avellana",
  "Sweet chestnut", "Castanea sativa",      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Castanea_sativa_2005-11-15.jpg/120px-Castanea_sativa_2005-11-15.jpg", "https://en.wikipedia.org/wiki/Castanea_sativa",
  "Morel",          "Morchella esculenta",  "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Morchella_esculenta_1_beentree.jpg/120px-Morchella_esculenta_1_beentree.jpg", "https://en.wikipedia.org/wiki/Morchella_esculenta",
  "Chanterelle",    "Cantharellus cibarius","https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/2011-10-01_Cantharellus_cibarius_crop.jpg/120px-2011-10-01_Cantharellus_cibarius_crop.jpg", "https://en.wikipedia.org/wiki/Cantharellus_cibarius",
  "Raspberry",      "Rubus idaeus",         "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Rubus_idaeus_berries.jpg/120px-Rubus_idaeus_berries.jpg", "https://en.wikipedia.org/wiki/Rubus_idaeus",
  "Sloe",           "Prunus spinosa",       "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Prunus_spinosa_fruits.jpg/120px-Prunus_spinosa_fruits.jpg", "https://en.wikipedia.org/wiki/Prunus_spinosa",
  "Sea buckthorn",  "Hippophae rhamnoides", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Hippophae_rhamnoides_fruits.jpg/120px-Hippophae_rhamnoides_fruits.jpg", "https://en.wikipedia.org/wiki/Hippophae_rhamnoides",
  "Sorrel",         "Rumex acetosa",        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Rumex_acetosa_StemsLeaves.jpg/120px-Rumex_acetosa_StemsLeaves.jpg", "https://en.wikipedia.org/wiki/Rumex_acetosa",
  "Rose hip",       "Rosa canina",          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Rose_hip.jpg/120px-Rose_hip.jpg",                         "https://en.wikipedia.org/wiki/Rosa_canina",
  "Wild apple",     "Malus sylvestris",     "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Malus_sylvestris_fruit.jpg/120px-Malus_sylvestris_fruit.jpg", "https://en.wikipedia.org/wiki/Malus_sylvestris",
  "Wild pear",      "Pyrus pyraster",       "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Pyrus_pyraster_fruits.jpg/120px-Pyrus_pyraster_fruits.jpg", "https://en.wikipedia.org/wiki/Pyrus_pyraster",
  "Borage",         "Borago officinalis",   "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Borago_officinalis_002.JPG/120px-Borago_officinalis_002.JPG",   "https://en.wikipedia.org/wiki/Borago_officinalis",
  "Meadowsweet",    "Filipendula ulmaria",  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Filipendula_ulmaria_-_Köhler–s_Medizinal-Pflanzen-060.jpg/120px-Filipendula_ulmaria_-_Köhler–s_Medizinal-Pflanzen-060.jpg", "https://en.wikipedia.org/wiki/Filipendula_ulmaria"
)

write_csv(plants_df, "edible_plants.csv")
