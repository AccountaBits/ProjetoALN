library(RCurl)
library(rvest)
library(XML)
library(RJSONIO)
library(httr)
library(data.table)
library(dplyr)
library(dict)

url_request <- "https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0"
url_path <- "https://api.prodam.sp.gov.br:9443/store/apis/info?name=SOF&version=v2.1.0&provider=admin"
url_headers <- list(httpheader = c("Accept: application/json", "Authorization: Bearer 7eae96cb1d25142a33bed919881e8f90"))

credores_url <- paste0(url_request, "/consultarCredores")

request = RCurl::getURLContent(credores_url, curl = getCurlHandle(.opts = url_headers), .encoding = "UTF-8") %>% 
  RJSONIO::fromJSON()


lstCredores <- data.frame()

for(i in 1:length(request$lstCredores)){
  row <- request$lstCredores[[i]] %>%
    as.character() %>% 
    unlist() %>% 
    as.data.frame() %>% 
    t.data.frame() %>% 
    as.data.frame()
  lstCredores <- rbind(lstCredores, row)
}

