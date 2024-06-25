summary_stat_airport <- function(df){
  
  result <- df |>
    group_by(apt, apt_nom) |>
    summarise(
      apt_pax_arr = sum(apt_pax_arr, na.rm = TRUE),
      apt_pax_dep = sum(apt_pax_dep, na.rm = TRUE),
      apt_pax_tr = sum(apt_pax_tr, na.rm = TRUE)
    ) |> 
    ungroup() |>
    rowwise() |>
    mutate(
      apt_pax_total = sum(c(apt_pax_arr, apt_pax_dep, apt_pax_tr), na.rm = TRUE) 
    )
  
  return(result)
  
}

create_data_from_input<- function(df, year_selected, month_selected){
  
  result <- df |>
    filter(
      as.character(an) %in% year_selected &
        mois %in% month_selected
    )
  
  return(result)
}