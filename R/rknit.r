#' Knit a document with knitr
#'
#' @description
#' Calls \code{\link[knitr]{knit2pdf}} (Rnw) or \code{\link[rmarkdown]{render}} (Rmd) on a file.
#'
#' @param file [\code{character(1)}]\cr
#'   Document to knit.
#' @param output_format [\code{character(1)}]\cr
#'   \code{pdf_document}, \code{html_document} or \code{word_document}.
#'   For Rnw-files output will be always PDF which is generated by running \code{\link[knitr]{knit2pdf}}.
#'   For Rmd-files the YAML header information for \code{output} will be taken into account as default but can be overridden by this parameter.
#'   Default is HTML.
#' @template return-itrue
#' @export
rknit = function(file, output_format = NULL) {
  assertFileExists(file, access = "r")

  assertString(output_format, null.ok = TRUE)
  supported_formats = c("pdf_document", "html_document", "word_document")
  if (!is.null(output)) {
    output = tolower(output)
    output_format = supported_formats[pmatch(output, supported_formats)]
    if (length(output_format)!=1) {
      stop(sprintf("Output format %s ambiguous. Supported are the following: %s", output_format, stringi::stri_join(supported_formats, collapse = ", ")))
    }
  }
  requireNamespace("knitr")

  file_type = tolower(file_ext(file))

  if (file_type == "rnw") {
    knitr_file = knitr::knit2pdf(file)
  } else if (file_type == "rmd") {
    rmarkdown::render(file, output_format = output_format)
  } else {
    stop(sprintf("File type %s is not supported", file_type))
  }

  invisible(TRUE)
}
