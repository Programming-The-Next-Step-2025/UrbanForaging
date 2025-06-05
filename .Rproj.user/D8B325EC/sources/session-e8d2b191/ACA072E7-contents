#' Save a new foraging spot and update the app's dataset
#'
#' @description
#' Adds a new foraging spot to the current dataset, writes it to a CSV file,
#' and updates the app's reactive storage. Combines user input with the existing
#' dataset using `add_foraging_location()`.
#'
#' @param data Existing dataset of foraging locations.
#' @param plant Plant name (character).
#' @param lat Latitude (numeric).
#' @param lon Longitude (numeric).
#' @param month Month name (character).
#' @param notes Notes (optional, character).
#' @param photo_path Optional path to a user photo (character).
#' @param path File path to save CSV data.
#' @param reactive_ref The reactiveVal() used in the app server.
#'
#' @return Invisibly returns the updated data.
#' @export
save_spots <- function(data, plant, lat, lon, month, notes = "", photo_path = NA_character_, path, reactive_ref) {
  updated <- add_foraging_location(data, plant, lat, lon, month, notes)
  updated$photo[nrow(updated)] <- photo_path  # add photo to last row
  readr::write_csv(updated, path)
  reactive_ref(updated)
  invisible(updated)
}
