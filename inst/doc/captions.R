## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----comment="", echo=FALSE---------------------------------------------------
cat('```{r fig.cap="figure caption"}\nplot(1:12)\n```\n\n```{r tab.cap="table caption"}\nhead(iris)\n```')

## ----eval=FALSE---------------------------------------------------------------
#  block_toc(style = "Table Caption")

## ----eval=FALSE---------------------------------------------------------------
#  block_toc(seq_id = "tab")

## ----eval=FALSE---------------------------------------------------------------
#  knitr::opts_chunk$set(
#    tab.cap.style = "Table Caption",
#    tab.cap.pre = "Table ",
#    tab.cap.sep = ": ",
#    )

## ----eval=FALSE---------------------------------------------------------------
#  knitr::opts_chunk$set(
#    fig.cap.style = "Image Caption",
#    fig.cap.pre = "Figure ",
#    fig.cap.sep = ": ",
#    )

## ----comment="", echo=FALSE---------------------------------------------------
cat('```{r fig.cap="figure caption", fig.cap.style=\"Image Caption\"}\nplot(1:12)\n```\n\n```{r tab.cap="table caption", tab.cap.style=\"Table Caption\"}\nhead(iris)\n```')

