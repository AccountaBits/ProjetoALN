library(purrr)
library(rvest)
library(dplyr)
library(stringr)
library(xml2)
library(httr)
library(XML)

# Depois
for (i in ws2){
  names(ws2[i]) = str_extract(ws2[2], pattern = "[/]$")
}


getData <- function(){
  url <- "http://splegisws.camara.sp.gov.br/ws/ws2.asmx"
  
  ws2 <- url %>% 
    read_html() %>% 
    html_nodes(xpath = '//li/a') %>%
    html_attr("href") %>%
    map(., str_replace, "ws2.asmx","") %>%
    unlist() %>%
    map(., str_replace, "[/?][o][p][/=]","/") %>%
    unlist() %>% 
    map(url,paste0,.) %>%
    unlist()
  Promovente <<- ws2[31] %>% 
    GET() %>% 
    content() %>%
    xmlParse() %>% 
    xmlToDataFrame()
  
  TipoMateria <<- ws2[33] %>% 
    GET() %>% 
    content() %>%
    xmlParse() %>% 
    xmlToDataFrame()
  
  ws2[29] <- paste0(ws2[29],"?Codigo=string")
  ProjVetPromovente <- map(ws2[29],str_replace, "string", as.character(Promovente$Chave)) %>% unlist()
  ProjVetDF <- list()
  for (i in 1:50){
    ProjVetDF[[i]] <-  ProjVetPromovente[i] %>% 
      GET() %>% 
      content() %>%
      xmlParse() %>% 
      xmlToDataFrame() 
  }
  
}
is_empty(ProjVetDF[[35]])
getData()

ws2 <- url %>% 
  read_html() %>% 
  html_nodes(xpath = '//li/a') %>%
  html_attr("href") %>%
  map(., str_replace, "ws2.asmx","") %>%
  unlist() %>%
  map(., str_replace, "[/?][o][p][/=]","/") %>%
  unlist() %>% 
  map(url,paste0,.) %>%
  unlist()

