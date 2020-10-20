# DOAJ

#install.packages('jaod')
library(jaod)
res <- jaod::jaod_journal_search('issn:2504-0537')
res$results$bibjson.title

# En este caso permite simplificar mucho el trabajo
doaj_data <- function(dois){
  df <- data.frame(issn = character(),
                   title = character(),
                   editorial_review = character(),
                   stringsAsFactors = FALSE)
  
  for(issn in dois){
    getdata <- jaod::jaod_journal_search(paste0('issn:', issn))
    
    if(getdata$total > 0){
      df <- rbind.data.frame(df, data.frame(issn=issn, title=getdata$results$bibjson.title, editorial_review=getdata$results$bibjson.editorial_review.process))
    }
  }
  
  return(df)
}

df_do <- doaj_data(c('issn', '2504-0537', '2624-9898', '2297-2668'))
df_do