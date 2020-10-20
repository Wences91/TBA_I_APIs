# arXiv

#install.packages('aRxiv')
library(aRxiv)

# Se pueden hacer consultas y recuperar preprints, además de ordenar los resultados
df_ar <- aRxiv::arxiv_search('au:"Rodrigo Costas" AND ti:altmetrics')
df_ar


df_ar <- aRxiv::arxiv_search('au:"Rodrigo Costas" AND ti:altmetrics', sort_by = 'submitted', ascending = FALSE)
df_ar

# Es posible consultar el número de preprints sin recuperarlos
aRxiv::arxiv_count('submittedDate:[20180101 TO 20191231]')

aRxiv::arxiv_count('submittedDate:20190512*')
df_ar <- aRxiv::arxiv_search('submittedDate:20190512*', sort_by = 'submitted', ascending = FALSE, limit = 300)
df_ar