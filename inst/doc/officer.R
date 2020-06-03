## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
taghl <- function(x){
  structure(list(name = "span", attribs = list(style = "color:#7b1b47;"), 
    children = list(x)), class = "shiny.tag")
}

## ----setup--------------------------------------------------------------------
library(officedown)
library(officer)

## ----echo=FALSE, comment=""---------------------------------------------------
rmd <- system.file(package = "officedown", "examples", "officer.Rmd")
rmd <- readLines(rmd)
cat(rmd, sep = "\n")

