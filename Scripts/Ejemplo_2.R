# Ejemplo 2

library(roadoi)
library(dplyr)

# Lectura del fichero de Dimensions
df_dm <- read.table('Dimensions.csv', header = TRUE, skip = 1, sep = ',', quote = '"', comment.char = '', stringsAsFactors=FALSE)

# Selección de los DOI y consulta a Unpaywall
dois <- df_dm$DOI

df_dm_un <- purrr::map(dois, 
                       .f = purrr::safely(function(x) roadoi::oadoi_fetch(x, email = 'usuario@correo.com')))
df_dm_un <- purrr::map_df(df_dm_un, 'result')
df_dm_un <- df_dm_un[, c('title', 'is_oa')]
df_dm_un

# Exportación
write.csv2(df_dm_un, 'Dimensions_OA.csv', row.names = FALSE, fileEncoding = 'utf-8')