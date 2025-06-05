# Additional Packages -----------------------------------------------------------
#' @importFrom dplyr filter select
#' @importFrom rgbif occ_search
#' @importFrom leaflet leaflet addTiles addMarkers

# ------------------------------------------------------------------------------
# FUNCTION: get_gbif_occurrences_by_month
# ------------------------------------------------------------------------------

#' @title Get GBIF Occurrences for a Plant Filtered by Month
#'
#' @description
#' Downloads occurrence data for a given plant species from GBIF (Global Biodiversity Information Facility),
#' filtered by observation month(s) and country (Netherlands).
#'
#' @param scientific_name Scientific name of the plant (e.g., "Allium ursinum").
#' @param months A character vector of month names (e.g., c("March", "April")).
#' @param limit Maximum number of GBIF records to retrieve (default is 1000).
#'
#' @details
#' Only occurrences with valid coordinates and observation dates are returned.
#' The function extracts the observation month from the event date, then filters accordingly.
#'
#' @return A data frame of occurrences with columns: scientificName, month, decimalLatitude, decimalLongitude.
#'
#' @examples
#' # Get wild garlic locations for March and April
#' wild_garlic_locations <- get_gbif_occurrences_by_month("Allium ursinum", c("March", "April"))
#'
#' # Visualize on a Leaflet map
#' if (nrow(wild_garlic_locations) > 0) {
#'   leaflet::leaflet(wild_garlic_locations) %>%
#'     leaflet::addTiles() %>%
#'     leaflet::addMarkers(~decimalLongitude, ~decimalLatitude)
#' }
#'
#' @export
get_gbif_occurrences_by_month <- function(scientific_name, months, limit = 1000) {
  results <- rgbif::occ_search(
    scientificName = scientific_name,
    country = "NL",
    limit = limit
  )
  df <- results$data
  
  # Remove incomplete records
  df <- dplyr::filter(df, !is.na(decimalLatitude), !is.na(decimalLongitude), !is.na(eventDate))
  
  # Parse month
  df$eventDate <- as.Date(df$eventDate)
  df$month <- format(df$eventDate, "%B")
  
  # Filter by month
  df_filtered <- dplyr::filter(df, month %in% months)
  
  if (nrow(df_filtered) == 0) {
    message("No matching GBIF records found for those months.")
    return(data.frame(
      scientificName = character(),
      month = character(),
      decimalLatitude = numeric(),
      decimalLongitude = numeric(),
      stringsAsFactors = FALSE
    ))
  }
  
  dplyr::select(df_filtered, scientificName, month, decimalLatitude, decimalLongitude)
}
