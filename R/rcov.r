#' Test the coverage of a package
#'
#' @description
#' Uses the \code{covr} package (\url{https://github.com/jimhester/covr}) to
#' test the code coverage.
#'
#' @template path
#' @param report [\code{logical(1)}]\cr
#'  Use the function \code{\link[covr]{report}} to display the coverage information in a browser.
#' @template return-itrue
#' @export
rcov = function(path = getwd(), report = FALSE) {
  pkgname = pkgload::pkg_name(path = path)

  requireNamespace("covr")

  messagef("Checking code coverage of package '%s'", pkgname)
  coverage = covr::package_coverage(pkgload::pkg_path(path = path))
  print(coverage)
  if (report) {
    covr::report(coverage,
      file = file.path(dirname(tempdir()), paste0(pkgname, "-report.html")),
      browse = TRUE)
  }
  invisible(TRUE)
}
