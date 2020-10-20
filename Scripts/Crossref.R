# Crossref

#install.packages('rcrossref')
library(rcrossref)

# Es posible recuperar citas de trabajos
df_cr <- rcrossref::cr_citation_count(doi='10.1002/asi.23309')
df_cr

# Se pueden pasar varios DOIs de manera directa
dois <- c('10.1002/asi.23309', '10.1016/j.joi.2007.02.001', '10.1007/s11192-014-1264-0')
df_cr <- rcrossref::cr_citation_count(doi = dois)
df_cr

# También se pueden buscar revistas mediante consultas
df_cr <- rcrossref::cr_journals(query = 'library and information science')
df_cr$data

# Así como buscar revistas directamente por uno o varios ISSN
df_cr <- rcrossref::cr_journals(issn = '1699-2407')
df_cr$data

issns <- c('1699-2407', '0165-5515')
df_cr <- rcrossref::cr_journals(issn = issns)
df_cr$data

# De las revistas se pueden además de los metadatos recuperar trabajos científicos
df_cr <- rcrossref::cr_journals(issn = '1699-2407', works = TRUE, limit = 50)
df_cr$data

# Estos pueden ser ordenados
df_cr <- rcrossref::cr_journals(issn = '1699-2407', works = TRUE, sort = 'is-referenced-by-count', order = 'desc')
df_cr$data

# Incluso se pueden hacer subbúsquedas sobre estos
df_cr <- rcrossref::cr_journals(issn = '1699-2407', works = TRUE, flq = c(`query.author`='Torres-Salinas'))
df_cr$data

# Es posible buscar artículos y ordenar los resultados
df_cr <- rcrossref::cr_works(query = 'library', sort = 'is-referenced-by-count', order = 'desc')
df_cr$data

# Igualmente se puede hacer usando varios DOIs
dois <- c('10.1002/asi.23309', '10.1016/j.joi.2007.02.001', '10.1007/s11192-014-1264-0')
df_cr <- rcrossref::cr_works(dois = dois, .progress = 'text')
df_cr$data

# Es posible superar el límite de 1000 mediante un cursor
df_cr <- rcrossref::cr_works(query = 'twitter', cursor = '*', cursor_max = 300, limit = 200, .progress = TRUE)
df_cr$data

# Por último, son posibles las búsquedas facetadas
df_cr <- rcrossref::cr_works(query = 'Twitter', facet = 'publisher-name:*', limit = 0)
df_cr$facets
