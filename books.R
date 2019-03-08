rm(list = ls()); gc(); gc()

options(bitmapType='cairo')
options(scipen = 999)

library(dplyr)
library(purrr)
library(tidyr)
# library(readr)
# library(stringr)
# library(ggplot2)
library(rvest)

# Define your workspace: "X:/xxx/"
wd <- "c:/github/cultist-simulator-books/"
setwd(wd)



## retrieve wikipedia list of pirates page
#books.url <- "https://cultistsimulator.gamepedia.com/Category:Books"
#books.url <- "https://cultistsimulator.gamepedia.com/List_of_books"
books.url <- "C:/github/cultist-simulator-books/Category Books - Cultist Simulator Wiki.html"


## read the page into R
books.wiki <- read_html(books.url)


## function to get title and link from an <a href>
f.get.link.and.title <- function(xml){
  url.vest <- xml %>% rvest::html_attr("href")
  title.vest <- xml %>% rvest::html_attr("title")
  return(tibble::tibble(title = title.vest, url = url.vest))
}


books.list <- books.wiki %>% 
  # grab all book links
  html_nodes("#mw-pages ul li a") %>% 
  # get title and link into a dataframe
  purrr::map_dfr(f.get.link.and.title)
  
## write booklist as csv to disk
readr::write_csv(books.list, "csv/booklist.csv")
  



  
  