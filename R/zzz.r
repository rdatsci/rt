#' @import checkmate
#' @import utils
#' @importFrom tools file_ext
NULL

.onLoad = function(libname, pkgname) {
  backports::import(pkgname)
}
