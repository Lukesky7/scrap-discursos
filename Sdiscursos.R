library(rvest)
library(polite)


####Navegar links discursos
url <- "https://www.casarosada.gob.ar/informacion/discursos"
bow(url)


dflinks <- data.frame()

for(xpg in seq(from = 0,to = 1040, by = 40)){
  link = paste0("https://www.casarosada.gob.ar/informacion/discursos?start=", xpg ,"")
  try(links <- read_html(link) %>%
        html_nodes(".panel") %>%
        html_attr("href")) ####link peliculas
  links <- paste0("https://www.casarosada.gob.ar",links)
  
  
  try(df <- data.frame(links))
  try(dflinks <- rbind(dflinks,df[c("links")]))
  
  Sys.sleep(5)
  
  print(paste("Página:", xpg))
}



####Separamos links y extraemos con for

Dislinks <- dflinks$links

dfDis <- data.frame()

for(i in Dislinks[1:1060]){
  pg <- read_html(i)
  
  Titulo <- pg %>%
    html_nodes("strong")%>%
    html_text() %>% .[1]
  
  Fecha <- pg %>%
    html_nodes(".pull-right") %>%
    html_text() %>% .[1]
  
  Discurso <- pg %>%
    html_nodes(".col-md-offset-2") %>%
    html_text() %>% . [2]
  
  
  df <- data.frame(Fecha,Titulo,Discurso)
  
  dfDis <- rbind(dfDis,df[c("Fecha","Titulo","Discurso")])
  
  print(i)
  Sys.sleep(5)
}