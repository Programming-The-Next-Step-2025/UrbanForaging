#' Launch the Urban Foraging Shiny App
#'
#' Works both from an installed package and from the development
#' source tree (`inst/app`).
#'
#' @export
run_uf_app <- function() {
  app_dir <- system.file("app", package = "urbanforaging")

  # If no app.R inside the installed path, fall back to source tree
  if (app_dir == "" || !file.exists(file.path(app_dir, "app.R"))) {
    app_dir <- file.path("inst", "app")
    message("Running app from source: ", normalizePath(app_dir))
  }

  shiny::runApp(app_dir, display.mode = "normal")
}
