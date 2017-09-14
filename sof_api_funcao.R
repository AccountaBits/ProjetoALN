library(RCurl)
library(RJSONIO)
library(dplyr)
library(readxl)

url_request <- "https://gatewayapi.prodam.sp.gov.br:443/financas/orcamento/sof/v2.1.0"
url_headers <- list(httpheader = c("Accept: application/json", "Authorization: Bearer 7eae96cb1d25142a33bed919881e8f90"))
paths <- read_excel("/home/leonardo/Desktop/RSOF/paths.xlsx")
path_list <- as.list(paths$urlPattern)

RESTResources <- function(){
  for(i in 1:seq_along(path_list)){
    path <- path_list[i]
    url_path <- paste0(url_request, path)
    print(url_path)
    i <- data.frame()
    request = RCurl::getURLContent(url_path, curl = getCurlHandle(.opts = url_headers),.encoding = "UTF-8") %>%
      RJSONIO::fromJSON()
    for(j in 1:length(request[[2]])){
      row <- request[[2]][j] %>%
        as.character() %>% 
        unlist() %>% 
        as.data.frame() %>% 
        t.data.frame()
      i <- rbind(i, row)
    }
  }
}

RESTResources()