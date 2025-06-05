# Additional Packages -----------------------------------------------------------
#' @importFrom dplyr bind_rows
#' 
# ------------------------------------------------------------------------------
# FUNCTION: add_foraging_location
# ------------------------------------------------------------------------------

#' @title Add a New Foraging Location
#'
#' @description
#' Adds a new plant observation to an existing foraging dataset. Useful for user-contributed entries in the Urban Foraging Map app.
#'
#' @param data A data frame of existing foraging locations.
#' @param plant Name of the plant found (character).
#' @param lat Latitude of the location (numeric).
#' @param lon Longitude of the location (numeric).
#' @param month The month when the plant is harvestable (e.g., "April").
#' @param notes Optional notes about the location or plant (character).
#'
#' @details
#' The new entry is appended as a row to the input data frame using `dplyr::bind_rows()`.
#'
#' @return A data frame with the new location added.
#'
#' @examples
#' df <- data.frame(
#'   plant = character(),
#'   lat = numeric(),
#'   lon = numeric(),
#'   month = character(),
#'   notes = character(),
#'   stringsAsFactors = FALSE
#' )
#' df <- add_foraging_location(df, "Wild Garlic", 52.37, 4.89, "March", "Under the bridge")
#'
#' @export
add_foraging_location <- function(data, plant, lat, lon, month, notes = "") {
  new_entry <- data.frame(
    plant = plant,
    lat = lat,
    lon = lon,
    month = month,
    notes = notes,
    stringsAsFactors = FALSE
  )
  dplyr::bind_rows(data, new_entry)
}

