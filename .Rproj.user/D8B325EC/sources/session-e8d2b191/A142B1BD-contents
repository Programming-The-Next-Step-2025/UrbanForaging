#' Launch the Urban Foraging Shiny App
#'
#' Works both from an installed package and from the development
#' source tree.
#'
#' @export
run_uf_app <- function() {
  # Helper to load files from R/ if local, or from system.file if installed
  source_file <- function(fname) {
    pkg_path <- system.file(fname, package = "urbanforaging")
    if (pkg_path != "") {
      source(pkg_path, local = TRUE)
    } else {
      local_path <- file.path("R", fname)
      if (!file.exists(local_path)) stop("Could not find: ", fname)
      source(local_path, local = TRUE)
    }
  }

  # Load setup, UI, and server
  source_file("app_setup.R")
  source_file("shiny_ui.R")
  source_file("shiny_server.R")

  # Launch the app
  shiny::shinyApp(ui = ui, server = server)
}

