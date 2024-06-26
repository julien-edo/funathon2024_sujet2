plot_airport_line <- function(df, selected_airport){
  
   trafic_aeroports  <- df |>
    filter(apt %in% selected_airport) |>
    mutate(
      trafic = apt_pax_dep + 
        apt_pax_tr + 
        apt_pax_dep
    ) |>
    mutate(
      date = ym(paste(an, "-", mois))
    )
  
  figure_ggplot <- trafic_aeroports %>%
    ggplot(.) + geom_line(aes(x = date, y = trafic))
  
  return(ggplotly(figure_ggplot))
}

map_leaflet_airport <- function(df, airports_location, month_selected, year_selected){
  
  
  trafic_date <- df %>%
    filter(
      mois %in% month_selected,
      as.character(an) %in% year_selected
    )
  
  trafic_aeroports <- inner_join(
    airports_location |>
      select(setdiff(colnames(airports_location), colnames(trafic_date))),
    trafic_date,
    by = c("Code.OACI" = "apt")
  )
  
  trafic_aeroports <- trafic_aeroports |>
    mutate(
      volume = ntile(trafic, 3)
    ) %>%
    mutate(
      color = palette[volume]
    )
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$color
  )
  
  carte_interactive <- leaflet(trafic_aeroports) |>
    addTiles() |>
    addAwesomeMarkers(
      icon=icons[],
      label=~paste0(str_to_title(Nom), "", " (",Code.OACI, ") : ", trafic, " voyageurs")
    )
  
  return(carte_interactive)
  
}
