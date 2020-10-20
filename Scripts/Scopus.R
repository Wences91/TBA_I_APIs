# Scopus

#install.packages('rscopus')
library(rscopus)

# Es necesario disponer de una clave de acceso
key <- rscopus::get_api_key(api_key = '')
rscopus::set_api_key(api_key = '')

# Se puede comprobar si está cargada en la sesión
rscopus::have_api_key()

# Los id de autores de Scopus pueden ser buscados
author_sc <- rscopus::process_author_name(last_name = 'Moed', first_name = 'Henk F.', verbose = FALSE)
author_sc$au_id


# Con ese id o el nombre se pueden obtener publicaciones de los autores
author_sc <- rscopus::author_retrieval(last_name = 'Moed', first_name = 'Henk F.', verbose = FALSE)
author_sc <- rscopus::author_retrieval(au_id = '7003555412', verbose = FALSE)
author_sc$content$`author-retrieval-response`[[1]]$coredata$`document-count`
author_sc$content$`author-retrieval-response`[[1]]$coredata$`cited-by-count`

# También se pueden recuperar metadatos
df_sc <- rscopus::author_df(last_name = 'Moed', first_name = 'Henk F.', verbose = FALSE)
df_sc <- rscopus::author_df(au_id = '7003555412', verbose = FALSE)
df_sc

# Asimismo se pueden hacer busquedas de documentos
df_sc <- rscopus::scopus_search(query = 'TITLE-ABS-KEY(altmetrics)', count = 10, view = 'COMPLETE', verbose = FALSE)
df_sc <- rscopus::gen_entries_to_df(df_sc$entries)
head(df_sc$df)