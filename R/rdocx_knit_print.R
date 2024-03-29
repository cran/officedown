#' @export
#' @importFrom officer to_wml to_pml
#' @importFrom knitr knit_print asis_output opts_knit
knit_print.run <- function(x, ...){
  if(grepl( "docx", opts_knit$get("rmarkdown.pandoc.to")))
    knit_print( asis_output(
      paste("`", to_wml(x), "`{=openxml}", sep = "")
    ) )
  else if(grepl( "pptx", opts_knit$get("rmarkdown.pandoc.to"))){
    knit_print( asis_output(
      paste("`", to_pml(x), "`{=openxml}", sep = "")
    ) )
  } else knit_print( asis_output("") )
}


#' @export
knit_print.fp_par <- function(x, ...){
  if(grepl( "docx", opts_knit$get("rmarkdown.pandoc.to"))){
    knit_print( asis_output(
      paste("`", to_wml(x), "`{=openxml}", sep = "")
    ) )
  } else if(grepl( "pptx", opts_knit$get("rmarkdown.pandoc.to"))){
    knit_print( asis_output(
      paste("`", to_pml(x), "`{=openxml}", sep = "")
    ) )
  } else knit_print( asis_output("") )
}

#' @export
#' @importFrom officer shape_properties_tags
knit_print.block <- function(x, ...){
  if(grepl( "docx", opts_knit$get("rmarkdown.pandoc.to"))){
    knit_print( asis_output(
      paste("```{=openxml}", to_wml(x), "```", sep = "\n")
    ) )
  } else if(grepl( "pptx", opts_knit$get("rmarkdown.pandoc.to"))){
    layout <- knitr::opts_current$get("layout")
    master <- knitr::opts_current$get("master")
    doc <- get_reference_pptx()
    ph <- knitr::opts_current$get("ph")
    if(is.null(ph)){
      ph <- officer::ph_location_type(type = "body")
    }
    bg <- knitr::opts_current$get("bg")
    if(is.null(bg)){
      bg <- "transparent"
    }
    if(!inherits(ph, "location_str")){
      stop("ph should be a placeholder location; ",
           "see officer::placeholder location for an example.",
           call. = FALSE)
    }

    id_xfrm <- get_content_ph(ph, layout, master, doc)
    new_ph <- shape_properties_tags(left = id_xfrm$left,
                           top = id_xfrm$top,
                           width = id_xfrm$width,
                           height = id_xfrm$height,
                           rot = id_xfrm$rotation,
                           label = id_xfrm$ph_label,
                           ph = id_xfrm$ph,
                           ln = sp_line(lwd = 0, linecmpd = "sng", lineend = "rnd"))
    xml_elt <- paste0( "<p:sp>", new_ph,
                       "<p:txBody><a:bodyPr/><a:lstStyle/>",
                       to_pml(x), "</p:txBody></p:sp>" )
    knit_print( asis_output(
      paste("```{=openxml}", xml_elt, "```", sep = "\n")
    ) )
  } else knit_print( asis_output("") )
}


#' @export
#' @title Force Block Printing while Knitting
#' @description When used in a loop, calls to blocks do not generate
#' output because `knit_print` method is not called.
#' Use the function to force printing. Also you should tell the chunk
#' to use results 'as-is' (by adding `results='asis'` to your chunk header).
#' @param x a block object, result of a block function from officer package
#' @param ... unused arguments
#' @return None. the function only print XML code.
#' @family functions that force printing
#' @examples
#' library(rmarkdown)
#' rmd_file_src <- system.file(
#'   package = "officedown", "examples", "word_loop.Rmd")
#' rmd_file_des <- tempfile(fileext = ".Rmd")
#' if(pandoc_available()){
#'
#'   file.copy(rmd_file_src, to = rmd_file_des)
#'   docx_file_1 <- tempfile(fileext = ".docx")
#'   render(rmd_file_des, output_file = docx_file_1, quiet = TRUE)
#'
#'   if(file.exists(docx_file_1)){
#'     message("file ", docx_file_1, " has been written.")
#'   }
#' }
knit_print_block <- function(x, ...){
  if(grepl( "docx", opts_knit$get("rmarkdown.pandoc.to"))){
    cat(paste("```{=openxml}", to_wml(x), "```\n\n", sep = "\n"))
  } else if(grepl( "pptx", opts_knit$get("rmarkdown.pandoc.to"))){
    cat(paste("```{=openxml}", to_pml(x), "```\n\n", sep = "\n"))
  } else cat("")
}

#' @export
#' @title Force Run Printing while Knitting
#' @description When used in a loop, runs do not outputs
#' because `knit_print` method is not called.
#' Use the function to force printing. Also you should tell the chunk
#' to use results 'as-is' (by adding `results='asis'` to your chunk header).
#' @param x a run object, result of a run function from officer package
#' @param ... unused arguments
#' @family functions that force printing
#' @return None. the function only print XML code.
#' @examples
#' library(rmarkdown)
#' rmd_file_src <- system.file(
#'   package = "officedown", "examples", "word_loop.Rmd")
#' rmd_file_des <- tempfile(fileext = ".Rmd")
#' if(pandoc_available()){
#'
#'   file.copy(rmd_file_src, to = rmd_file_des)
#'   docx_file_1 <- tempfile(fileext = ".docx")
#'   render(rmd_file_des, output_file = docx_file_1, quiet = TRUE)
#'
#'   if(file.exists(docx_file_1)){
#'     message("file ", docx_file_1, " has been written.")
#'   }
#' }
knit_print_run <- function(x, ...){
  if(grepl( "docx", opts_knit$get("rmarkdown.pandoc.to"))){
    cat(paste("`", to_wml(x), "`{=openxml}", sep = ""))
  } else if(grepl( "pptx", opts_knit$get("rmarkdown.pandoc.to"))){
    cat(paste("`", to_pml(x), "`{=openxml}", sep = ""))
  } else cat("")
}

