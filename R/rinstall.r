#' Installs R packages
#'
#' @description
#' Installs R packages from local directory, CRAN or Git.
#'
#' @param pkgs [\code{character}]\cr
#'  Strings convertible by \code{\link{stringToPackage}}.
#' @param add [\code{logical(1)}]\cr
#'  Append packages to your \code{~/.rt/packages} file?
#'  Default is \code{FALSE}.
#' @template return-itrue
#' @export
rinstall = function(pkgs = character(0L), add = FALSE) {
  pkgs = lapply(pkgs, stringToPackage)
  assertFlag(add)
  lib = getLibraryPath()

  pn = extract(pkgs, "name")
  is.cran = extract(pkgs, "type") == "cran"
  if (any(is.cran)) {
    messagef("Installing %i packages from CRAN: %s", sum(is.cran), collapse(pn[is.cran]))
    install.packages(pn[is.cran], lib = lib, INSTALL_opts = getOption("rt.install.args"))
  }

  for (pkg in pkgs[!is.cran])
    installPackage(pkg, temp = !add)
  if (add)
    addPackagesToCollection(pkgs)
  invisible(TRUE)
}
