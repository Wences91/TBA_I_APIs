# Ejemplo 1

library(wosr)
library(rAltmetric)
library(dplyr)

# Realizamos una consulta en WOS
sid <- wosr::auth(username = NULL, password = NULL)
wosr::query_wos('TS = (Wikipedia AND altmetric*)', sid = sid)
df_ej1 <- wosr::pull_wos('TS = (Twitter AND altmetric*)', sid = sid)

# Consultamos los DOIs en Altmetric.com usando una función propia
dois <- df_ej1$publication$doi


altmetric_data <- function(dois){
  df <- data.frame()
  for(doi in dois){
    alt <- rAltmetric::altmetrics(doi = doi)
    df_alt <- rAltmetric::altmetric_data(alt)
    df <- dplyr::bind_rows(df, df_alt)
  }
  
  return(df)
}

df_ej1_alt <- altmetric_data(dois)

# Seleccionamos de todos los campos el DOI y Altmetric Attention Score
df_ej1_alt <- df_ej1_alt[,c('doi', 'score')]
df_ej1_alt