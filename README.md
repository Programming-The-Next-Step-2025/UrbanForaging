# Urban Foraging Map  
*A Shiny App for Exploring Seasonal Wild Foods in Amsterdam*

## Overview

**Urban Foraging Map** is a web-based interactive tool built with **R** and **Shiny** 
that helps users explore and share locations of **seasonal wild edible plants** in **Amsterdam**. 
It focuses on accessible foraging opportunities in urban parks and green spaces 
— starting with plants like **wild garlic** and **elderberries**.

The app allows users to both **view existing foraging locations** and **add their own**, 
optionally uploading photos and notes about what they found.

## Ideas for Features

- **Interactive map** of known foraging locations using Leaflet  
- **Seasonal filter** (Spring, Summer, Autumn) to show what's in season  
- **User-submitted locations**, including plant name, season, optional notes, and **photo upload**  
- **Information panel** showing plant tips, ethical guidelines, and identification help

## Technologies Used

- **R** (main language)
- **Shiny** (for UI and server logic)
- **Leaflet** (interactive maps)
- **dplyr**, **readr**, **shinyWidgets** (data handling and UI elements)
- **fileInput** (to allow optional image uploads)

## Data

The app uses two data sources:
1. **Manually collected locations** from community forums, foraging blogs, and field research
2. **User-submitted entries** through the app interface

Each foraging spot includes:
- Plant name  
- Coordinates (latitude/longitude)  
- Season of harvest (e.g., Spring)  
- Optional: notes about the plant or site  
- Optional: photo uploaded by the user

Data is stored locally in memory or a CSV file depending on deployment settings.

## How to Run

1. Install R and RStudio (if not already installed)
2. Install required packages:

```r
install.packages(c("shiny", "leaflet", "dplyr", "readr", "shinyWidgets"))
