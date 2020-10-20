# Consulta manual

# Paquetes necesarios
library(httr)
library(rjson)

# Construcción de la consulta
query <- 'https://doaj.org/api/v1/search/journals/issn:2504-0537'

# Petición a la API
getdata <- httr::GET(url = query)

# De manera opcional se pueden especificar campos como los headers o user_agent
getdata <- httr::GET(url = query,  httr::user_agent('httr'))

# Es posible consultar todo el JSON que devuelve la API
getdata_json <- rjson::fromJSON(httr::content(getdata, type='text', encoding = 'UTF-8'))
getdata_json

# O especificar campos concretos
getdata_json$total
getdata_json$results[[1]]

# En este caso, como buscamos un ISSN lo normal es que devuelva un único resultado
getdata_json$results[[1]]$bibjson$title
getdata_json$results[[1]]$bibjson$editorial_review$process
getdata_json$results[[1]]$bibjson$license[[1]]$open_access
getdata_json$results[[1]]$bibjson$license[[1]]$type

# Además de buscar journals es posible buscar artículos científicos
query <- 'https://doaj.org/api/v1/search/articles/doi:10.3389/fpsyg.2013.00479'
getdata <- httr::GET(url = query)
getdata_json <- rjson::fromJSON(httr::content(getdata, type='text', encoding = 'UTF-8'))
getdata_json$results[[1]]$bibjson$title
getdata_json$results[[1]]$bibjson$journal$title

# Es posible automatizar este proceso para realizar multiples consultas
for(issn in c('2504-0537', '2624-9898', '2297-2668')){
  
  query <- paste0('https://doaj.org/api/v1/search/journals/issn:', issn)
  getdata <- httr::GET(url = query)
  getdata_json <- rjson::fromJSON(httr::content(getdata, type='text', encoding = 'UTF-8'))
  
  j_title <- getdata_json$results[[1]]$bibjson$title
  j_er <- getdata_json$results[[1]]$bibjson$editorial_review$process
  
  print(c(issn, j_title, j_er))
}

# De igual manera se pueden crear funciones con ello y generar data.frames
doaj_data <- function(dois){
  df <- data.frame(issn = character(),
                   title = character(),
                   editorial_review = character(),
                   stringsAsFactors = FALSE)
  
  for(issn in dois){
    query <- paste0('https://doaj.org/api/v1/search/journals/issn:', issn)
    getdata <- httr::GET(url = query)
    getdata_json <- rjson::fromJSON(httr::content(getdata, type='text', encoding = 'UTF-8'))
    
    j_title <- getdata_json$results[[1]]$bibjson$title
    j_er <- getdata_json$results[[1]]$bibjson$editorial_review$process
    
    
    df <- rbind.data.frame(df, data.frame(issn=issn, title=j_title, editorial_review=j_er))
  }
  
  return(df)
}

df <- doaj_data(c('2504-0537', '2624-9898', '2297-2668'))

# Sin embargo, es necesario tener en cuenta en estos casos los posible errores que pueden aparecer durante todo el proceso
doaj_data(c('issn', '2504-0537', '2624-9898', '2297-2668'))

doaj_data <- function(dois){
  df <- data.frame(issn = character(),
                   title = character(),
                   editorial_review = character(),
                   stringsAsFactors = FALSE)
  
  for(issn in dois){
    query <- paste0('https://doaj.org/api/v1/search/journals/issn:', issn)
    getdata <- httr::GET(url = query)
    getdata_json <- rjson::fromJSON(httr::content(getdata, type='text', encoding = 'UTF-8'))
    
    # Comprobación de la respuesta y resultados
    if(status_code(getdata) == 200 & getdata$headers$`x-total-count` > 0) {
      j_title <- getdata_json$results[[1]]$bibjson$title
      j_er <- getdata_json$results[[1]]$bibjson$editorial_review$process
      
      df <- rbind.data.frame(df, data.frame(issn=issn, title=j_title, editorial_review=j_er))
    }
  }
  
  return(df)
}

df <- doaj_data(c('issn', '2504-0537', '2624-9898', '2297-2668'))
