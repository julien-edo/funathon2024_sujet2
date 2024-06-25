clean_dataframe <- function(dataframe){
  
  if(!is.data.frame(dataframe))
    stop("L'objet n'est pas un data.frame")
  
  result <- dataframe |> 
    mutate(
      an = str_sub(ANMOIS, 1, 4) |> as.integer(), 
      mois = str_sub(ANMOIS, 5, 6) |> as.integer(), 
    )
  
  colnames(result) <- tolower(colnames(result))
  
  return(result)
  
}