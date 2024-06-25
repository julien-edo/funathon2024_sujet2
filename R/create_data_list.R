create_data_list <- function(source_file){
  
  if(!file.exists(source_file))
    stop("Fichier introuvable")
  
  return(read_yaml(source_file))
}
