# Set-up Code for the Urban Foraging Map - Shiny App


# Load required libraries
library(shiny)         # builds interactive web apps in R
library(shinyWidgets)  # provides  UI components like sliders, switches, etc.
library(leaflet)       # creates maps for visualizing foraging locations
library(dplyr)         # helps clean data for readable code
library(readr)         # helps with reading and writing CSVs
library(purrr)         # helps with looping over things and working with lists in a clean way
library(rprojroot)     # finds project root paths for easy file access
library(htmltools)     # builds custom HTML elements for better UI rendering


# ── Static file paths ───────────────────────────────────────────────────────
# This sets up where the app should look for extra files things like plant photos, etc.
# These files don’t change during the app’s use

# Set the path to the 'www' folder
www_path <- system.file("www", package = "urbanforaging")
if (www_path == "") www_path <- file.path("inst", "www") # fallback if not found
dir.create(www_path, recursive = TRUE, showWarnings = FALSE) # to make sure the folder exists
addResourcePath("www", www_path) # tell Shiny where to find these resources

# Set the path to the plant image folder
pics_dir <- system.file("plantpics/images", package = "urbanforaging")
if (pics_dir == "") pics_dir <- file.path(rprojroot::find_root("DESCRIPTION"), # fallback path
                                          "inst/plantpics/images")

addResourcePath("plantpics", pics_dir) # Register the image folder so Shiny can use it properly

# ── Load edible_plants.csv ────────────────────────────────────────────────────
# Here we load the main data file with info about edible plants.
# We also clean it up so it’s ready to use in the app.

# Find the path to the CSV file, using a backup path if needed
csv <- system.file("extdata/edible_plants.csv", package = "urbanforaging")
if (csv == "") csv <- file.path("inst/extdata/edible_plants.csv")

# Read the CSV file and adjust encoding so characters look right
plants_raw <- read_csv(csv, locale = locale(encoding = "Latin1"),
                       show_col_types = FALSE) %>%
  mutate(across(where(is.character), \(x) iconv(x, from = "Latin1", to = "UTF-8", sub = "")))


plants_df <- plants_raw %>%
  mutate(
    img   = ifelse(grepl("^https?://", img), img,
                   gsub(" ", "%20", file.path("/plantpics", basename(img)), fixed = TRUE)), # make image paths web-friendly
    label = ifelse(is.na(label) | label == "", "(unknown)", label), # fallback if no label
    sci   = ifelse(is.na(sci),  "", sci), # fill blanks with empty strings
    info  = ifelse(is.na(info), "", info),
    infourl  = ifelse(is.na(infourl), "", infourl)
  )

# ── Generate selection options from plant data ─────────────────────────────
# These are used in the UI to let users select plants by either their common or scientific name.
# Tab 1 shows plant labels (common names), Tab 2 uses scientific names for GBIF lookups.

# Options for Tab 1 — users select by common name (label)
select_options <- pmap(plants_df, function(label, sci, img, ...) {
  list(value = label, label = label, sci = sci, img = img)
})

# Options for Tab 2 — users select by scientific name (sci)
select_options_gbif <- pmap(plants_df, function(label, sci, img, ...) {
  list(value = sci, label = label, sci = sci, img = img)
})

# ── Foraging spots CSV ─────────────────────────────────────────────────────
# This handles loading and saving the user-generated list of foraging spots.

# Try to find the CSV file where foraging spots are stored
spots_csv <- system.file("app/foraging_spots.csv", package = "urbanforaging")
if (spots_csv == "") spots_csv <- file.path(rprojroot::find_root("DESCRIPTION"),
                                            "inst/extdata/foraging_spots.csv")

# If no file exists yet, create an empty one so the app can still run
if (!file.exists(spots_csv)) {
  dir.create(dirname(spots_csv), recursive = TRUE, showWarnings = FALSE)
  write_csv(tibble(plant=character(), lat=numeric(), lon=numeric(),
                   month=character(), notes=character(), photo=character()),
            spots_csv)
}

# Load the spots into a reactive value so the app can respond to changes
spots_rv  <- reactiveVal(read_csv(spots_csv, show_col_types = FALSE))



# ── JS map centre fetcher ───────────────────────────────────────────────────
# Adds a JS handler that grabs the current center of the Leaflet map
# and sends it to the Shiny app as 'map_center'.

js <- "Shiny.addCustomMessageHandler('getCentre',function(msg){var m=$('#map').data('leaflet-map');if(m){var c=m.getCenter();Shiny.setInputValue('map_center',{lat:c.lat,lng:c.lng});}});"
