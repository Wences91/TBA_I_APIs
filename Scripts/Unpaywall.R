# Unpaywall

#install.packages('roadoi')
library(roadoi)
library(dplyr)

# Es posible buscar metadatos de varias publicaciones
dois <- c('10.7326/m18-2101', '10.1093/biosci/biz088')
df_un <- roadoi::oadoi_fetch(dois = dois, email = 'usuario@correo.com')
df_un

# Incluso que marque el proceso de la consulta
dois <- c('10.7326/m18-2101', '10.1093/biosci/biz088', '10.1126/science.aat7693', '10.1038/s41467-019-12808-z',
          '10.1136/bmj.k5094', '10.1126/science.aax0848', '10.1016/s0140-6736(19)30041-8', '10.1038/s41586-019-1666-5')
df_un <- roadoi::oadoi_fetch(dois = dois, email = 'usuario@correo.com', .progress = 'text')
df_un

# Debido al formato de respuesta, algunos campos necesitan de un procesamiento posterior
df_un[2,]$oa_locations[[1]]
dplyr::mutate(df_un, urls = purrr::map(best_oa_location, 'url') %>% 
                purrr::map_if(purrr::is_empty, ~ NA_character_) %>%
                purrr::flatten_chr()
)[c('doi', 'urls')]

# También se pueden omitir los fallos y filtrar el resultado
dois <- c('10.7326/m18-2101', '10.1093/biosci/biz088', '10.1126/science.aat7693', '10.1038/s41467-019-12808-z',
          '10.1136/bmj.k5094', '-', '10.1016/s0140-6736(19)30041-8', '10.1038/s41586-019-1666-5')

df_un <- purrr::map(dois, 
                    .f = purrr::safely(function(x) roadoi::oadoi_fetch(x, email = 'usuario@correo.com')))

df_un <- purrr::map_df(df_un, 'result')
df_un <- df_un[, c('doi', 'is_oa')]
df_un