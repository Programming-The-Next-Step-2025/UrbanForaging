#' @title Shiny Server for Urban Foraging
#' @description Defines the server logic for the Urban Foraging app.
#' @export
# ── Server logic ────────────────────────────────────────────────────────────
# This handles all interactivity: rendering maps, responding to inputs,
# saving new foraging spots, querying GBIF, and building the plant catalogue.

server <- function(input, output, session) {

  # Initialize the map for community foraging spots
  output$map <- renderLeaflet({
    leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
      setView(lng = 4.9041, lat = 52.3676, zoom = 12)
  })

  # Update markers on the map based on selected months
  observe({
    df <- spots_rv() %>% filter(month %in% input$filter_months)
    leafletProxy("map") %>% clearMarkers()
    if (nrow(df) == 0) return()
    leafletProxy("map") %>% addCircleMarkers(
      data = df, lng=~lon, lat=~lat,
      popup = ~{
        idx <- match(plant, plants_df$label)
        paste0(
          "<b>", htmlEscape(plant), "</b><br><i>", month, "</i>",
          ifelse(nchar(notes), paste0("<br>", htmlEscape(notes)), ""),
          "<br><br><strong>Standard image</strong><br>",
          "<img src=\"", plants_df$img[idx],
          "\" width=\"140\" style=\"margin:4px 0\" onerror=\"this.onerror=null;this.src='/www/noimage.png';\">",
          "<br><strong>Description</strong><br>", htmlEscape(plants_df$info[idx]), "<br>",
          ifelse(plants_df$infourl[idx] != "",
                 paste0("<a href=\"", plants_df$infourl[idx], "\" target=\"_blank\">More info</a>"), ""),
          ifelse(!is.na(photo),
                 paste0("<br><br><strong>Your photo</strong><br><img src=\"", photo, "\" width=\"140\">"), "")
        )
      })
  })

  observeEvent(input$add, {
    req(input$plant_pick, input$month_new, input$map_center)

    photo_path <- NA_character_
    if (!is.null(input$photo)) {
      dir.create(file.path(www_path, "photos"), showWarnings = FALSE)
      dest <- file.path(www_path, "photos", input$photo$name)
      file.copy(input$photo$datapath, dest, overwrite = TRUE)
      photo_path <- file.path("/www/photos", input$photo$name)
    }

    # Call to our custom function `save_spots()` (defined in R/save_spots.R)
    # It adds the new spot to the dataset, saves it to CSV, and updates the reactive state
    save_spots(
      data = spots_rv(),
      plant = input$plant_pick,
      lat = input$map_center$lat,
      lon = input$map_center$lng,
      month = input$month_new,
      notes = input$notes,
      photo_path = photo_path,
      path = spots_csv,
      reactive_ref = spots_rv
    )

    showNotification("Spot added!")
  })

  # Initialize the GBIF map
  output$gbif_map <- renderLeaflet({
    leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
      setView(lng = 4.9041, lat = 52.3676, zoom = 6)
  })

  # Handle GBIF search
  observeEvent(input$gbif_go, {
    req(input$gbif_species, input$gbif_months)
    output$gbif_msg <- renderText("Searching …")

    tryCatch({

      # Call to custom function that queries GBIF for matching observations
      df <- get_gbif_occurrences_by_month(
        scientific_name = input$gbif_species,
        months          = input$gbif_months,
        limit           = input$gbif_limit
      )

      leafletProxy("gbif_map") %>% clearMarkers()
      if (nrow(df) == 0) {
        output$gbif_msg <- renderText("No records found.")
      } else {
        leafletProxy("gbif_map") %>% addCircleMarkers(
          data = df, lng = ~decimalLongitude, lat = ~decimalLatitude,
          radius = 3, fillOpacity = 0.8,
          popup = ~paste0(
            "<i>", scientificName, "</i><br>",
            ifelse(!is.na(country), country, ""),
            ifelse(!is.na(year), paste0("<br>", year), "")
          ))
        output$gbif_msg <- renderText(paste(nrow(df), "records plotted."))
      }
    }, error = \(e) { output$gbif_msg <- renderText(paste("Error:", e$message)) })
  })

  # Render the plant catalogue as scrollable HTML
  output$catalogue_html <- renderUI({
    df <- arrange(plants_df, label)
    blocks <- split(df, toupper(substr(df$label, 1, 1)))
    tags$div(lapply(names(blocks), \(letter) {
      blk <- blocks[[letter]]
      tagList(
        tags$h3(letter, class="mt-3"),
        lapply(seq_len(nrow(blk)), \(i) {
          pl <- blk[i, ]
          tags$div(class="mb-3 d-flex align-items-start",
                   tags$img(src=pl$img, height=60,
                            onerror="this.onerror=null;this.src='/www/noimage.png';",
                            class="me-2 border rounded"),
                   tags$div(
                     tags$b(pl$label), " – ", tags$i(pl$sci), tags$br(),
                     pl$info, tags$br(),
                     if (pl$infourl != "")
                       tags$a("More info", href=pl$infourl, target="_blank")
                   )
          )
        })
      )
    }))
  })

  # Get the initial center of the map once it’s loaded
  session$onFlushed(function() session$sendCustomMessage("getCentre", "now"))
}
