create_table_airports <- function(df, option_interactive = TRUE){
  
  
  df <- df %>%
    mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
    ) %>%
    select(name_clean, everything())
  
  result <- gt(
    df |>
      select(-apt, -apt_nom),
    locale = "fr"
  ) |>
    fmt_integer(
      columns = c(starts_with("apt_pax")),
      use_seps = TRUE,
      sep_mark = ' '
    ) |>
    fmt_markdown(
      columns = "name_clean"
    ) |>
    cols_label(
      name_clean = "Nom",
      apt_pax_arr = "Passagers arrivée",
      apt_pax_dep = "Passagers départ",
      apt_pax_tr = "Passagers transit",
      apt_pax_total = "Passagers total"
    ) |> 
    tab_header(
      title = "Statistiques globales sur les aéroports"
    ) |>
    tab_source_note(
      source_note = "Source : DGAC"
    ) |>
    tab_style(
      style = cell_fill(color = "powderblue"),
      locations = cells_title()
    ) 
  
  if(option_interactive)
    result <- result |> 
    opt_interactive()
  
  return(result)
}