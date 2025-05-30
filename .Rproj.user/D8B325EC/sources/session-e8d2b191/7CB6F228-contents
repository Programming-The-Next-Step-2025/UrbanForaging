
# ---------------------------------------------------------------------------
# Urban Foraging • Shiny App Launcher
# This file is meant for development and code review.
# Users should run the app with: urbanforaging::run_uf_app()
# ---------------------------------------------------------------------------


# Helper function to source R files from either local dev or installed package
source_file <- function(fname) {
  pkg_path <- system.file(fname, package = "urbanforaging")
  if (pkg_path != "") {
    source(pkg_path, local = TRUE)
  } else {
    source(file.path("R", fname), local = TRUE)
  }
}

# Load dependencies and data setup
source_file("app_setup.R")

# Load UI and server definitions
source_file("shiny_ui.R")
source_file("shiny_server.R")

# Launch the app
shinyApp(ui = ui, server = server)
run_uf_app()
