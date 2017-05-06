library(glm2)
library(MASS)
library(scatterplot3d)
library(xtable)
library(stepp)
library(stepwise)
library(reshape2)
library(ggplot2)
library(mosaic)
library(mda)
library(mdatools)
library(earth)
library(polspline)
library(faraway)
library(Rmisc)
library(rvest)
library(httr)
library(jsonlite)
library(rattle)
#-----------------------------------------------------------------------------------------

res_url <- 'https://www.dcard.tw/f/sex'
res <- read_html(res_url)
label_a <- res %>% html_nodes('div.PostEntry_container_245XM > a')
a_href <- label_a %>% html_attr('href')
j_url <- 'https://www.dcard.tw/_api/posts/'

for ( i in 3:length(a_href)){
  
  con_url <- a_href[i]
  split_xl <- unlist(strsplit(con_url, split='/f/sex/p/', fixed = TRUE))[2]
  split_xll <- unlist(strsplit(split_xl, split='-', fixed = TRUE))[1]
  
  url <- gsub(" +","",paste(j_url, split_xll, '?'))
  j_key <- fromJSON(url, flatten = TRUE)
  
  content <- j_key$content
  img_url <- j_key$media
  title <- unlist(strsplit(j_key$title, split = '\\', fixed = 'TRUE'))[1]
  
  main_path <- "E:\\Desk\\R\\DCard\\"
  #sub_path <- gsub(" +", "", title)
  #path <-  gsub(" +", "", paste(main_path, sub_path))
  dir.create(main_path, showWarnings = FALSE)
  
  for (img in img_url$url){
    #img_name = grep("(a-zA-Z0-9).jpg", img, perl=TRUE, value=TRUE)
    img_name = unlist(strsplit(img, split='https://i.imgur.com/', fixed = TRUE))[2]
    download.file(img, destfile = gsub(" +", "", paste(main_path, img_name)), mode = "wb")
  }
  
}

