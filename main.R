

library(yaml)
library(readr)
library(purrr)
library(dplyr)
library(stringr)
library(sf)
library(leaflet)
library(ggplot2)
library(plotly)
library(lubridate)
library(htmltools)
library(gt)

source("R/create_data_list.R")
source("R/import_data.R")  
source("R/clean_dataframe.R")
source("R/figures.R")
source("R/table.R")
source("R/divers_functions.R")

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- 1:12
palette <- c("green", "blue", "red")

# Load data ----------------------------------
urls <- create_data_list("./sources.yml")

pax_apt_all <- import_airport_data(urls$airports)
pax_cie_all <- import_compagnies_data(urls$compagnies)
pax_lsn_all <- import_liaisons_data(urls$liaisons)

airports_location <- st_read(urls$geojson$airport)

# Arrange data ------

liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]

# Graphique -----

figure_plotly <- plot_airport_line(pax_apt_all, default_airport)
    
# Tableau ----

month_selected <- MONTHS_LIST[5]
year_selected <- YEARS_LIST[2]

pax_apt_all_selected <- create_data_from_input(pax_apt_all,
                                               year_selected,
                                               month_selected
)

stats_aeroports <- summary_stat_airport(pax_apt_all)

create_table_airports(stats_aeroports)

# Carte -----

map_leaflet_airport(df = pax_apt_all, 
                    airports_location = airports_location, 
                    month = month_selected, 
                    year= year_selected)


