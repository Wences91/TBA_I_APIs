# Altmetric.com

library(rAltmetric)

# Se pueden hacer peticiones con diferentes tipos de identificadores
alt_doi <- rAltmetric::altmetrics(doi = '10.1038/480426a')
alt_doi

alt_arx <- rAltmetric::altmetrics(arxiv = '1905.08233')
alt_arx

# Es posible convertir la respuesta en un data.frame
df_alt <- rAltmetric::altmetric_data(alt_doi)

# Para esta operación es necesario tener instalado y cargado el paquete dplyr
library(dplyr)

altmetric_data <- function(dois){
  df <- data.frame()
  for(doi in dois){
    alt <- rAltmetric::altmetrics(doi = doi)
    df_alt <- rAltmetric::altmetric_data(alt)
    df <- dplyr::bind_rows(df, df_alt)
  }
  
  return(df)
}

altmetric_data(dois[1:2])

# Es recomendable introducir la clave de la API
rAltmetric::altmetrics(apikey = 'TU_KEY')