#' @title Shiny UI for Urban Foraging
#' @description Defines the UI for the Urban Foraging app.
#' @export
# ── UI ──────────────────────────────────────────────────────────────────────
# This sets up the overall layout of the app: header, tabs, and JS integration.

ui <- fluidPage(
  tags$head(tags$script(HTML(js))), # Include custom JS to track map center
  titlePanel("Urban Foraging Map – Amsterdam"), # App title at the top
  tabsetPanel( # Everything inside here is split into tabs

    # Tab 1 — Community spots
    # Users can log and view foraging spots shared by the community.
    # They select a plant, describe the spot, and add it to the map.

    tabPanel("Community spots",
             sidebarLayout(
               sidebarPanel(

                 # Dropdown to pick a plant (with images and scientific names)
                 selectizeInput("plant_pick", "Plant", choices = NULL,
                                options = list(
                                  valueField = "label",
                                  labelField = "label",
                                  searchField = c("label", "sci"),
                                  options = select_options,
                                  render = I("{
                                    option: function(item, escape) {
                                      return '<div style=\"display:flex;align-items:center\">' +
                                        '<img src=\"' + item.img + '\" height=\"30\" style=\"margin-right:6px\" onerror=\"this.onerror=null;this.src=\\'/www/noimage.png\\';\">' +
                                        '<div><b>' + escape(item.label) + '</b> – <i>' + escape(item.sci) + '</i></div></div>';
                                    }
                                  }")
                                )),
                 # Pick a season or month
                 selectInput("month_new", "Season / month", choices = month.name, selected = "April"),

                 # Optional notes about the spot
                 textAreaInput("notes", "Notes (optional)", rows = 3),

                 # Optional photo upload
                 fileInput("photo", "Photo (optional)", accept = c("image/jpeg", "image/png")),

                 # Filter to show only selected months on the map
                 pickerInput("filter_months", "Show months", choices = month.name, selected = month.name, multiple = TRUE),

                 # Button to add current map center as a new spot
                 actionButton("add", "Add map centre →", class = "btn-success"),
                 helpText("Pan/zoom to the location, then press “Add”.")
               ),

               # Map output
               mainPanel(leafletOutput("map", height = 600))
             )),

    # Tab 2 — GBIF lookup
    # Lets users search for plant observation data from GBIF (Global Biodiversity Info Facility).
    # They choose a plant, set filters, and view the results on a map.

    tabPanel("GBIF lookup",
             sidebarLayout(
               sidebarPanel(

                 # Dropdown to pick a plant using scientific or common names
                 selectizeInput("gbif_species", "Plant", choices = NULL,
                                options = list(
                                  valueField = "sci",
                                  labelField = "label",
                                  searchField = c("label", "sci"),
                                  options = select_options_gbif,
                                  placeholder = "Start typing a plant…",
                                  render = I("{
                                    option: function(item, escape) {
                                      return '<div style=\"display:flex;align-items:center\">' +
                                        '<img src=\"' + item.img + '\" height=\"30\" style=\"margin-right:6px\" onerror=\"this.onerror=null;this.src=\\'/www/noimage.png\\';\">' +
                                        '<div><b>' + escape(item.label) + '</b> – <i>' + escape(item.sci) + '</i></div></div>';
                                    }
                                  }")
                                )),

                 # Filter observations by month
                 pickerInput("gbif_months", "Months", choices = month.name, multiple = TRUE, selected = c("March", "April")),

                 # Limit number of GBIF records retrieved (this makes sure the map isn't overwhelming and recent entries are prioritized)
                 numericInput("gbif_limit", "Max records", 500, min = 10, step = 10),

                 # Start GBIF search
                 actionButton("gbif_go", "Search GBIF", class = "btn-primary")
               ),

               # Show GBIF data on map and messages below
               mainPanel(leafletOutput("gbif_map", height = 600),
                         verbatimTextOutput("gbif_msg"))
             )),

    # Tab 3 — Plant catalogue
    # A scrollable (alphabetical) list of all plants in the dataset
    # for browsing or learning more about each plant.

    tabPanel("Plant catalogue",
             div(style = "max-height:650px; overflow-y:auto; padding:1rem;",
                 uiOutput("catalogue_html")))
  )
)

