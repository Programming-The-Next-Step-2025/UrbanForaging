# Urban Foraging Map  
*A Shiny App for Exploring Seasonal Wild Plants in Amsterdam*

## Purpose & Features

**Urban Foraging Map** is a Shiny web app built in R that lets users explore and contribute to a growing map of seasonal edible plants found in Amsterdam.  
It combines community-submitted foraging locations, live biodiversity data from **GBIF**, and a browsable reference catalogue of wild edible plants.

### Main features:
- 📍 **Community map** – Add, browse, and filter foraging spots with optional notes and photos  
- 🌿 **GBIF lookup** – Search and plot scientific observations of plants by month  
- 📖 **Plant catalogue** – Scrollable reference of all included plants, with info and images  

## Installation

```r
remotes::install_github("berrycan/urbanforaging")
```

## How to Run

```r
urbanforaging::run_uf_app()
```

## R Packages Used

- **shiny** – UI and server framework  
- **leaflet** – Interactive map rendering  
- **dplyr**, **readr**, **purrr** – Data processing  
- **shinyWidgets**, **htmltools** – Enhanced UI components  
- **fileInput** – File upload handling for user-submitted images  

## Data Sources

- 🌐 [Wikipedia](https://www.wikipedia.org/) – plant descriptions  
- 🖼️ [Wikimedia](https://commons.wikimedia.org/) – plant images  
- 🌱 [GBIF](https://www.gbif.org/) – real-time species observations  
- 📊 [Kaggle: Edible Wild Plants Dataset](https://www.kaggle.com/datasets/gverzea/edible-wild-plants)
