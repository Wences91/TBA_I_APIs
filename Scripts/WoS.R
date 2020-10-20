# Web of Science

#install.packages('wosr')
library(wosr)

# En primer lugar es necesario establecer las credenciales de acceso
sid <- wosr::auth(username = NULL, password = NULL)

# Es posible ver la cantidad de documentos que recupera una consulta
wosr::query_wos('TS = scientometrics', sid = sid)
wosr::query_wos('TS = scientometrics', sid = sid, editions = c('SCI', 'SSCI'))

# También se pueden descargar los resultados de dicha consulta
df_ws <- wosr::pull_wos('TS = scientometrics', sid = sid)
df_ws$publication
